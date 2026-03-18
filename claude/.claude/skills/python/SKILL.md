---
name: python
description: >
  Load when writing, reviewing, or debugging general Python code — not framework-
  specific. Covers the patterns Claude consistently gets wrong in production Python:
  mutable defaults, exception handling, type hints, dataclasses, closures, and
  common gotchas. Load this alongside a framework skill (fastapi, django) when relevant.
---

# Python: What Claude Gets Wrong in Production Code

This skill is not a Python tutorial. It covers the specific patterns that tend to
be wrong or dangerous in AI-generated Python. Read this before writing or reviewing
any Python in this project.

---

## Mutable Default Arguments: The Oldest Trap

The default value is evaluated once at function definition time, not on every call.
Mutable defaults (lists, dicts, sets) are shared across all calls.

```python
# WRONG — all callers share the same list object
def add_item(item: str, items: list[str] = []) -> list[str]:
    items.append(item)
    return items

add_item("a")  # ["a"]
add_item("b")  # ["a", "b"] — NOT ["b"] as you'd expect

# RIGHT — use None as sentinel, create fresh object each call
def add_item(item: str, items: list[str] | None = None) -> list[str]:
    if items is None:
        items = []
    items.append(item)
    return items
```

Same trap for class attributes vs instance attributes:
```python
# WRONG — tags is shared across all User instances
class User:
    tags: list[str] = []

    def add_tag(self, tag: str) -> None:
        self.tags.append(tag)  # modifies the class-level list

# RIGHT — assign in __init__ or use dataclass field()
from dataclasses import dataclass, field

@dataclass
class User:
    tags: list[str] = field(default_factory=list)
```

---

## Exception Handling: Catch Specific, Not Broad

```python
# WRONG — silences everything, including bugs you need to see
try:
    result = process_order(order_id)
except Exception:
    pass

# WRONG — catches KeyboardInterrupt and SystemExit
try:
    result = process_order(order_id)
except:
    logger.error("failed")

# RIGHT — catch the specific exception you expect
try:
    result = process_order(order_id)
except NotFoundError as e:
    raise HTTPException(status_code=404, detail=str(e)) from e
except ValidationError as e:
    raise HTTPException(status_code=422, detail=e.errors()) from e

# RIGHT — if you genuinely need to catch all unexpected errors (e.g., at a boundary),
# log the full traceback and re-raise or return a safe response
try:
    result = process_order(order_id)
except Exception as e:
    logger.exception("unexpected error processing order %s", order_id)
    raise  # or: return ErrorResponse(...)
```

`logger.exception()` automatically includes the traceback. `logger.error()` does not.

---

## Type Hints: Use Them, Use Them Correctly

```python
# WRONG — unhelpful hints that don't narrow types
def get_user(user_id: Any) -> dict:
    ...

# WRONG — Optional[str] is fine but the modern syntax is cleaner
from typing import Optional
def get_user(user_id: Optional[UUID]) -> Optional[User]:
    ...

# RIGHT — use X | None syntax (Python 3.10+) or from __future__ import annotations
def get_user(user_id: UUID | None) -> User | None:
    ...

# WRONG — list and dict as types (lowercase is correct, but old code uses List/Dict)
from typing import List, Dict
def process(items: List[str]) -> Dict[str, int]:
    ...

# RIGHT — built-in generics (Python 3.9+)
def process(items: list[str]) -> dict[str, int]:
    ...
```

For callables and return types:
```python
from collections.abc import Callable, Generator, AsyncGenerator
from typing import TypeVar

T = TypeVar("T")

# Return type for generators
def paginate(query) -> Generator[list[Row], None, None]:
    ...

# Higher-order function
def retry(fn: Callable[..., T], times: int = 3) -> T:
    ...
```

---

## Dataclasses Over Dicts for Structured Data

Don't pass `dict` between functions when the shape is known. Use `dataclass` or
`pydantic.BaseModel`. Dicts have no type checking, no attribute access, and no
documentation of their shape.

```python
# WRONG — what keys does this have? what are the types?
def process_payment(data: dict) -> dict:
    amount = data["amount"]
    currency = data.get("currency", "USD")
    ...

# RIGHT — explicit, typed, validated at creation
from dataclasses import dataclass
from decimal import Decimal

@dataclass(frozen=True)
class PaymentRequest:
    amount: Decimal
    currency: str = "USD"
    idempotency_key: str | None = None

def process_payment(request: PaymentRequest) -> PaymentResult:
    ...
```

Use `frozen=True` for value objects that shouldn't change after creation.
Use Pydantic `BaseModel` instead of `dataclass` when you need validation or
serialization (e.g., for API boundaries).

---

## Late Binding Closures

Lambda and nested function bodies are evaluated when called, not when defined.
Variables from the enclosing scope are looked up at call time.

```python
# WRONG — all lambdas capture the same 'i' variable (its final value)
multipliers = [lambda x: x * i for i in range(5)]
multipliers[0](10)  # returns 40, not 0 — 'i' is 4 after the loop

# RIGHT — capture the current value as a default argument
multipliers = [lambda x, i=i: x * i for i in range(5)]
multipliers[0](10)  # returns 0

# This is less of a problem with list comprehensions that return values,
# but is critical when lambdas or nested functions are stored and called later.
```

---

## `is` vs `==`: Identity vs Equality

`is` checks object identity (same object in memory). `==` checks equality (same value).

```python
# WRONG — works by accident for small integers (-5 to 256), breaks otherwise
if user_id is 42:
    ...

# WRONG — None comparison with ==
if result == None:
    ...

# RIGHT — always use == for value comparison, is only for None/True/False
if user_id == 42:
    ...

if result is None:  # correct — None is a singleton
    ...

if flag is True:    # correct for explicit True check
    ...
```

---

## Context Managers: Always Use Them for Resources

Any object with a `close()` method (files, DB connections, HTTP clients) should be
opened with `with`. This guarantees cleanup even if an exception occurs.

```python
# WRONG — file stays open if process() raises
f = open("data.csv")
data = process(f)
f.close()

# RIGHT — file is always closed
with open("data.csv") as f:
    data = process(f)

# For async resources
async with aiofiles.open("data.csv") as f:
    data = await f.read()

# For your own classes: implement __enter__/__exit__ or __aenter__/__aexit__
# Or use @contextlib.contextmanager / @contextlib.asynccontextmanager for generators
from contextlib import asynccontextmanager

@asynccontextmanager
async def get_db_session():
    session = Session()
    try:
        yield session
        await session.commit()
    except Exception:
        await session.rollback()
        raise
    finally:
        await session.close()
```

---

## Common Gotchas

**Modifying a list while iterating over it:**
```python
# WRONG — skips every other element silently
items = [1, 2, 3, 4]
for item in items:
    if item % 2 == 0:
        items.remove(item)

# RIGHT — iterate over a copy
for item in items[:]:
    if item % 2 == 0:
        items.remove(item)

# OR — use a list comprehension
items = [item for item in items if item % 2 != 0]
```

**`__init__` side effects:** Constructors should not do I/O, make network calls, or
raise exceptions that aren't `ValueError`/`TypeError`. Use a factory function or
`@classmethod` if construction needs I/O.

**String concatenation in loops:** `+=` on strings in a loop is O(n²).
Use `"".join(parts)` or a list accumulator.

**`dict.get()` vs `dict[]`:** Use `dict.get(key, default)` only when the key is
genuinely optional. If the key must exist, use `dict[key]` — it raises `KeyError`
with the key name, which is more debuggable than `None` propagating silently.
