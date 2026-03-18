---
name: api-design
description: >
  Load when designing a new API endpoint, choosing HTTP methods or status codes,
  designing request/response schemas, deciding on URL structure, handling pagination,
  or reviewing an endpoint for REST consistency. Ensures every endpoint in the
  API follows the same conventions so the API is predictable and easy to consume.
---

# REST API Design Standards

## URL Structure: Resources, Not Actions

URLs identify resources. HTTP methods express the action. Never put verbs in URLs.

```
# Wrong — verbs in URL
POST /api/v1/create-order
POST /api/v1/orders/cancel
GET  /api/v1/get-user-orders

# Right — nouns in URL, verbs expressed via HTTP method
POST   /api/v1/orders              # create
GET    /api/v1/orders              # list
GET    /api/v1/orders/{id}         # retrieve
PATCH  /api/v1/orders/{id}         # partial update
DELETE /api/v1/orders/{id}         # delete
```

**Exception for actions with no clean resource mapping** — use a sub-resource noun
that represents the result of the action:

```
# Not ideal — verb in URL
POST /api/v1/orders/{id}/cancel

# Better — noun that represents the cancellation
POST /api/v1/orders/{id}/cancellation
POST /api/v1/orders/{id}/status     # body: {"status": "cancelled"}
```

**Nesting depth** — keep URLs shallow. Two levels of nesting is the practical limit.
More than two levels signals that the inner resource should be a top-level resource
with a filter parameter instead.

```
# Too deep
GET /api/v1/users/{user_id}/orders/{order_id}/items/{item_id}

# Better — items are a top-level resource, filtered by order
GET /api/v1/order-items/{item_id}
GET /api/v1/order-items?order_id={order_id}
```

---

## HTTP Methods: Use Them Correctly

| Method | Idempotent | Safe | Use for |
|--------|-----------|------|---------|
| GET | Yes | Yes | Retrieve — never modifies state |
| POST | No | No | Create or trigger actions |
| PUT | Yes | No | Full replace of a resource |
| PATCH | No | No | Partial update (preferred over PUT for most updates) |
| DELETE | Yes | No | Remove a resource |

Use **PATCH** over **PUT** for updates. PUT requires the client to send the full
resource state, which is error-prone and wasteful. PATCH sends only the changed fields.

---

## HTTP Status Codes: Use the Right One

The most important status codes and when to use each:

```
200 OK           — Successful GET, PATCH, or DELETE that returns a body
201 Created      — Successful POST that created a resource (include Location header)
204 No Content   — Successful DELETE or action with no response body
400 Bad Request  — Invalid input (Pydantic validation failure, malformed JSON)
401 Unauthorized — Missing or invalid authentication token
403 Forbidden    — Authenticated but not authorized for this resource/action
404 Not Found    — Resource doesn't exist (use this even when the reason is authorization
                   — "does not exist" is safer than "you can't access it")
409 Conflict     — Resource already exists (duplicate email), or state conflict
422 Unprocessable Entity — Valid JSON but semantically invalid (FastAPI uses this for Pydantic errors)
429 Too Many Requests    — Rate limit exceeded (include Retry-After header)
500 Internal Server Error — Unexpected server error (never expose details to client)
503 Service Unavailable  — Dependency unavailable (database down, etc.)
```

Common mistakes:
- Using 400 for "user not found" (should be 404)
- Using 200 for a create operation (should be 201)
- Using 403 when you mean 404 (reveals that the resource exists)
- Using 500 for a business logic error (should be 400/409/422)

---

## Request and Response Shapes: Be Consistent

Every endpoint in this API follows these conventions:

**IDs**: Always UUID strings in responses, never integers.

**Timestamps**: Always ISO 8601 with timezone: `"2024-01-15T14:30:00Z"`.
Never Unix timestamps, never datetime objects without timezone.

**Null vs. absent fields**: Fields that are optional and have no value should be
`null` in responses, not omitted. Clients should not have to handle both cases.

**Boolean fields**: Always explicit `true`/`false`, never `1`/`0` or `"yes"`/`"no"`.

**Money/decimals**: Always strings in API responses, never floats.
`"total": "29.99"` not `"total": 29.99` (floats lose precision).

**Enums**: Always lowercase strings. `"status": "pending"` not `"status": "PENDING"`.

```python
# Good response schema
class OrderResponse(BaseModel):
    id: UUID
    status: Literal["pending", "processing", "completed", "cancelled"]
    total: Decimal          # Pydantic serializes Decimal as string in JSON
    created_at: datetime
    user_id: UUID
    notes: str | None       # null when absent — not omitted
    model_config = {"from_attributes": True}
```

---

## Pagination: Always Required on List Endpoints

Every endpoint that returns a list must support pagination. No exceptions — even if
the dataset is small today, you need the contract in place before it grows.

Use cursor-based pagination for large datasets that grow continuously (event logs,
activity feeds). Use offset-based pagination for datasets that are queried with
filters and where "page N" has meaning to users.

**Standard paginated response envelope:**

```python
# backend/app/schemas/pagination.py
from typing import Generic, TypeVar
from pydantic import BaseModel

T = TypeVar("T")

class PaginatedResponse(BaseModel, Generic[T]):
    items: list[T]
    total: int          # total matching records (for showing "page X of Y")
    limit: int          # the limit used for this response
    offset: int         # the offset used for this response
    has_more: bool      # convenience: offset + len(items) < total
```

```python
# Usage in an endpoint
@router.get("/orders", response_model=PaginatedResponse[OrderResponse])
async def list_orders(
    limit: int = Query(default=50, ge=1, le=200),  # cap at 200 — protect the DB
    offset: int = Query(default=0, ge=0),
    status: str | None = Query(default=None),
    current_user: CurrentUser = Depends(),
    order_service: OrderServiceDep = Depends(),
) -> PaginatedResponse[OrderResponse]:
    items, total = await order_service.list(
        user_id=current_user.id,
        status=status,
        limit=limit,
        offset=offset,
    )
    return PaginatedResponse(
        items=[OrderResponse.model_validate(o) for o in items],
        total=total,
        limit=limit,
        offset=offset,
        has_more=offset + len(items) < total,
    )
```

---

## Error Response Shape: Consistent Across All Endpoints

All errors follow the same envelope so clients can handle them uniformly:

```json
{
  "detail": "Human-readable description of what went wrong",
  "code": "machine_readable_error_code",
  "field_errors": [
    { "field": "email", "message": "value is not a valid email address" }
  ]
}
```

`detail` is always present. `code` is present for business logic errors (not
validation errors). `field_errors` is only present for validation errors.

```python
# backend/app/core/exception_handlers.py
from fastapi.exceptions import RequestValidationError

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    field_errors = [
        {"field": ".".join(str(loc) for loc in err["loc"][1:]), "message": err["msg"]}
        for err in exc.errors()
    ]
    return JSONResponse(
        status_code=422,
        content={"detail": "Validation failed", "field_errors": field_errors}
    )
```

---

## Filtering and Sorting

List endpoints should support filtering via query parameters. Use consistent
parameter names across all list endpoints:

```
GET /api/v1/orders?status=pending&created_after=2024-01-01&sort=-created_at
```

**Sorting convention**: prefix with `-` for descending, no prefix for ascending.
`sort=created_at` = oldest first. `sort=-created_at` = newest first.
Support `sort` as a single string or a comma-separated list for multi-column sorting.

```python
from enum import Enum

class OrderSortField(str, Enum):
    CREATED_AT = "created_at"
    TOTAL = "total"
    STATUS = "status"

@router.get("/orders")
async def list_orders(
    sort: str = Query(default="-created_at"),  # newest first by default
    status: str | None = Query(default=None),
    created_after: datetime | None = Query(default=None),
    ...
```

---

## Versioning

The API is versioned via URL prefix (`/api/v1/`, `/api/v2/`). Version only when
making breaking changes. A breaking change is:
- Removing a field from a response
- Changing a field's type or format
- Removing or renaming an endpoint
- Changing the meaning of a field

Adding new optional fields to a response is NOT a breaking change.
Adding new optional query parameters is NOT a breaking change.

Before creating v2 of an endpoint, consider whether an additive change to v1 would
serve the need without breaking existing clients.
