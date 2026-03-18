---
name: debugging
description: >
  Load when investigating a bug, traceback, unexpected behavior, test failure,
  or performance anomaly in Python or React. Also load when asked to explain
  an error or trace through why something isn't working as expected. Provides
  a systematic methodology — not just pattern-matching on error messages.
---

# Debugging Methodology

## The Core Principle: Understand Before Fixing

The most common debugging mistake is jumping to a fix before understanding the root cause.
A symptom (e.g., "500 error on /orders") is not a cause. A cause is the specific line of
code, the specific state, and the specific condition that produced the symptom. Never
propose a fix until you can explain exactly what happened and why.

---

## Step 1: Read the Full Traceback Before Anything Else

Python tracebacks are read bottom-up. The last line is the exception. The frame above it
is where it was raised. Frames above that are the call chain that got there. The relevant
frame is almost always the one that's in *your* application code (not in a library).

```
Traceback (most recent call last):
  File ".../fastapi/routing.py", line 227, in run_endpoint_function  ← library frame, skip
    return await dependant.call(**values)
  File ".../app/api/v1/endpoints/orders.py", line 34, in create_order  ← YOUR CODE ← look here
    order = await order_service.create(current_user.id, payload)
  File ".../app/services/order_service.py", line 58, in create         ← YOUR CODE
    product = await self.repo.get_by_id_or_raise(item.product_id)
  File ".../app/repositories/product_repo.py", line 22, in get_by_id_or_raise  ← raised here
    raise NotFoundError("Product", str(product_id))
app.core.exceptions.NotFoundError: Product abc-123 not found
```

In this traceback, the error is clear: product `abc-123` doesn't exist. But why was
`abc-123` passed? That's the real question. Read one frame up from the raise.

---

## Step 2: Reproduce It Locally

Before reading any code, reproduce the error. A bug you can't reproduce reliably is much
harder to fix and easier to fix incorrectly. Try:

```bash
# For an API error — call the exact endpoint with the exact payload
http POST localhost:8000/api/v1/orders \
  Authorization:"Bearer $TOKEN" \
  items:='[{"product_id": "abc-123", "quantity": 2}]'

# For a test failure — run only that test with verbose output
pytest tests/api/test_orders.py::TestOrdersAPI::test_create_with_invalid_product -xvs

# For a background task — run it synchronously with the actual arguments
python -c "from app.workers.tasks import process_report; process_report.apply(args=['report-id-123'])"
```

The `-x` flag stops pytest on first failure. The `-s` flag shows print statements.
Both together make it much faster to iterate.

---

## Step 3: Identify the Failing Assumption

Every bug is a violated assumption. Find the assumption. Common categories:

**Wrong type**: A function expects a UUID but received a string `"abc-123"`. Check with:
```python
# Add temporarily to find the type
print(type(product_id), repr(product_id))
```

**None where a value was expected**: `get()` returned `None` and the code didn't check.
```python
# Find where None enters the chain
product = await session.execute(select(Product).where(Product.id == pid))
result = product.scalar_one_or_none()
print(f"product lookup for {pid!r}: {result!r}")  # None means the ID doesn't exist in DB
```

**Async/await mistake**: Forgetting `await` doesn't raise an error — it returns a
coroutine object, which is truthy but not the data you expected. If a value is
`<coroutine object ...>`, you're missing an `await`.
```python
# WRONG — result is a coroutine, not a User
user = user_repo.get_by_id(user_id)

# RIGHT
user = await user_repo.get_by_id(user_id)
```

**Session scope issue**: Using a session after it's been closed, or sharing a session
across async boundaries. SQLAlchemy raises `DetachedInstanceError` when you access
a lazy-loaded attribute on an object whose session has closed.

**State that outlasted its context**: A cached value that's stale, a test that left
data in the DB, or a request that shares state with a previous one.

---

## Step 4: Use Targeted Logging, Not Print Statements

For async FastAPI code, `print()` works but structured logging is more useful and
doesn't need to be removed:

```python
import logging
logger = logging.getLogger(__name__)

# In the suspect function — log the inputs and key intermediate states
async def create_order(self, user_id: UUID, payload: OrderCreate) -> Order:
    logger.debug(
        "create_order called",
        extra={"user_id": str(user_id), "item_count": len(payload.items)}
    )
    for item in payload.items:
        product = await self.product_repo.get_by_id(item.product_id)
        logger.debug(
            "product lookup",
            extra={"product_id": str(item.product_id), "found": product is not None}
        )
```

Enable DEBUG logging locally by setting `LOG_LEVEL=DEBUG` in your `.env`.
Never commit debug log lines — remove or lower to `logger.debug` after fixing.

---

## Step 5: SQLAlchemy Query Debugging

When a query returns unexpected results, log the compiled SQL:

```python
from sqlalchemy import select, event
from sqlalchemy.engine import Engine
import logging

# Option 1: Log all SQL globally (for a debugging session only)
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)

# Option 2: Print a specific query's SQL before executing it
stmt = select(Order).where(Order.user_id == user_id)
print(stmt.compile(compile_kwargs={"literal_binds": True}))
# Output: SELECT orders.id, orders.user_id ... WHERE orders.user_id = 'abc-123'
```

Common SQLAlchemy bugs:
- **Wrong results**: Missing `.where()` clause, or a filter on the wrong column
- **Empty results**: The WHERE clause uses Python equality but the column type doesn't match (e.g., UUID as string vs UUID type)
- **N+1 queries**: The SQL log shows the same SELECT firing in a loop — add `selectinload()`
- **Stale data**: Object loaded before a commit doesn't see new data — use `session.refresh(obj)` or reload from DB

---

## Step 6: React / Frontend Debugging

For unexpected UI behavior or API call failures:

```typescript
// Network tab first: check the actual request URL, headers, and response body
// This catches: wrong base URL, missing auth header, unexpected payload shape

// For state bugs: log the query/mutation state
const { data, isLoading, isError, error } = useCurrentUser();
console.log({ data, isLoading, isError, error });

// For TanStack Query cache bugs: use the DevTools
// Add <ReactQueryDevtools initialIsOpen={false} /> to App.tsx in development

// For type errors at runtime: check the Zod parse result
const result = UserSchema.safeParse(apiResponse);
if (!result.success) {
  console.error("Schema mismatch:", result.error.format());
}
```

---

## Step 7: Differential Diagnosis for Common Errors

| Error | First place to look |
|-------|---------------------|
| `422 Unprocessable Entity` | Pydantic validation failure — check `response.json()["detail"]` for which field failed |
| `401 Unauthorized` | Token missing, expired, or malformed — decode with `jwt.decode()` and check `exp` |
| `403 Forbidden` | Authorization check — find where `current_user.id != resource.user_id` |
| `500 Internal Server Error` | Check server logs — the response body is generic but the log has the traceback |
| `DetachedInstanceError` | Lazy-loaded attribute accessed after session closed — add `selectinload()` or reload |
| `MissingGreenlet` | Sync DB call inside async context — check for missing `await` or sync code in async function |
| `IntegrityError` | Unique constraint or FK violation — check the constraint name in the error message |
| `CORS error in browser` | Check `ALLOWED_ORIGINS` in FastAPI settings and that the correct origin is listed |
| `Cannot read properties of undefined` | API returned unexpected shape — check Zod schema vs actual response |

---

## Step 8: Fix Verification Checklist

Before declaring a bug fixed:
- [ ] The specific reproduction case from Step 2 now passes
- [ ] The related test (or a new test covering this exact case) passes
- [ ] The fix doesn't break any existing tests (`pytest -x`)
- [ ] The root cause (the violated assumption) is documented in the commit message
- [ ] Any temporary debug logging has been removed
