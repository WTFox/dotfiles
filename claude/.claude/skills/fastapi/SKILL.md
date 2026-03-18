---
name: fastapi
description: >
  Load when writing, reviewing, or debugging FastAPI code — route handlers,
  dependencies, background tasks, middleware, or lifespan events. Covers the
  patterns Claude consistently gets wrong: business logic in handlers, dependency
  injection for sessions, response models, status codes, and async pitfalls.
  Load alongside sqlalchemy-postgres when DB access is involved.
---

# FastAPI: What Claude Gets Wrong in Production Code

This skill is not a FastAPI tutorial. It covers the specific patterns that tend
to be wrong or dangerous in AI-generated FastAPI code.

---

## Route Handlers Must Be Thin

The single most common mistake: business logic in route handlers. Handlers have
one job — parse the request, call a service, return a response.

```python
# WRONG — business logic, DB access, and error handling all in the handler
@router.post("/orders", status_code=201)
async def create_order(
    payload: OrderCreate,
    session: AsyncSession = Depends(get_session),
    current_user: User = Depends(get_current_user),
):
    # This is service logic — it doesn't belong here
    product = await session.get(Product, payload.product_id)
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    if product.stock < payload.quantity:
        raise HTTPException(status_code=400, detail="Insufficient stock")
    order = Order(user_id=current_user.id, product_id=product.id, ...)
    session.add(order)
    await session.commit()
    return order

# RIGHT — handler delegates entirely to the service layer
@router.post("/orders", response_model=OrderResponse, status_code=201)
async def create_order(
    payload: OrderCreate,
    current_user: CurrentUser,
    order_service: OrderServiceDep,
):
    return await order_service.create(current_user.id, payload)
```

---

## Always Declare `response_model`

Without `response_model`, FastAPI serializes whatever the handler returns — including
internal fields like hashed passwords, internal IDs, and audit columns.

```python
# WRONG — returns the full ORM object, exposes everything
@router.get("/users/{user_id}")
async def get_user(user_id: UUID, session: AsyncSession = Depends(get_session)):
    return await session.get(User, user_id)

# RIGHT — response filtered to declared fields
@router.get("/users/{user_id}", response_model=UserResponse)
async def get_user(user_id: UUID, user_service: UserServiceDep) -> UserResponse:
    return await user_service.get_by_id(user_id)
```

---

## Dependency Injection: Use `Annotated` Deps, Not Raw `Depends()`

```python
# FINE but verbose — Depends() in every function signature
async def get_user(
    user_id: UUID,
    session: AsyncSession = Depends(get_session),
    current_user: User = Depends(get_current_user),
):

# BETTER — declare deps once, reuse everywhere (FastAPI 0.95+)
from typing import Annotated
from fastapi import Depends

CurrentUser = Annotated[User, Depends(get_current_user)]
SessionDep = Annotated[AsyncSession, Depends(get_session)]
OrderServiceDep = Annotated[OrderService, Depends(get_order_service)]

async def create_order(
    payload: OrderCreate,
    current_user: CurrentUser,
    order_service: OrderServiceDep,
):
    ...
```

Sessions should be provided by a dependency, never created inside a handler or service.

---

## Correct HTTP Status Codes

```python
# WRONG — 200 for everything
@router.post("/orders")
async def create_order(payload: OrderCreate): ...  # should be 201

@router.delete("/orders/{id}")
async def delete_order(order_id: UUID): ...  # should be 204 with no body

# RIGHT
@router.post("/orders", response_model=OrderResponse, status_code=201)
async def create_order(payload: OrderCreate): ...

@router.delete("/orders/{id}", status_code=204)
async def delete_order(order_id: UUID): ...
# For 204: return None or Response(status_code=204) — do not return the deleted object
```

---

## Pydantic v2 Patterns

FastAPI uses Pydantic v2. Several v1 patterns break silently or cause deprecation warnings.

```python
# WRONG — Pydantic v1 style
class OrderResponse(BaseModel):
    class Config:
        orm_mode = True  # v1 name

    @validator("amount")
    def validate_amount(cls, v):  # v1 style
        ...

# RIGHT — Pydantic v2 style
class OrderResponse(BaseModel):
    model_config = ConfigDict(from_attributes=True)  # v2 name for orm_mode

    @field_validator("amount")
    @classmethod
    def validate_amount(cls, v: Decimal) -> Decimal:  # v2 style
        ...

# WRONG — v1 serialization
user = UserResponse.from_orm(db_user)  # v1

# RIGHT — v2 serialization
user = UserResponse.model_validate(db_user)  # v2
```

---

## Exception Handling: Raise, Don't Return

```python
# WRONG — returns a 200 with an error body; clients can't detect failure reliably
@router.get("/orders/{order_id}")
async def get_order(order_id: UUID):
    order = await order_service.get(order_id)
    if not order:
        return {"error": "not found"}

# RIGHT — raise HTTPException; FastAPI converts it to the correct HTTP status
@router.get("/orders/{order_id}", response_model=OrderResponse)
async def get_order(order_id: UUID, order_service: OrderServiceDep):
    return await order_service.get_by_id_or_raise(order_id)
    # service raises NotFoundError → global exception handler → 404
```

Register a global exception handler to convert domain exceptions to HTTP responses:
```python
@app.exception_handler(NotFoundError)
async def not_found_handler(request: Request, exc: NotFoundError):
    return JSONResponse(status_code=404, content={"detail": str(exc)})

@app.exception_handler(AuthorizationError)
async def auth_handler(request: Request, exc: AuthorizationError):
    return JSONResponse(status_code=403, content={"detail": str(exc)})
```

---

## Lifespan Events: Use `@asynccontextmanager`, Not `on_event`

```python
# WRONG — deprecated in FastAPI 0.93+
@app.on_event("startup")
async def startup():
    await init_db()

# RIGHT — lifespan context manager
from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app: FastAPI):
    # startup
    await init_db()
    yield
    # shutdown
    await close_db()

app = FastAPI(lifespan=lifespan)
```

---

## Background Tasks: For Fire-and-Forget Only

`BackgroundTask` runs after the response is sent, in the same process. It's appropriate
for non-critical tasks (send a notification email). It's not appropriate for tasks that
must complete reliably, require retries, or take more than a few seconds — use a task
queue (Celery, ARQ, etc.) for those.

```python
@router.post("/orders", status_code=201)
async def create_order(
    payload: OrderCreate,
    background_tasks: BackgroundTasks,
    order_service: OrderServiceDep,
):
    order = await order_service.create(payload)
    background_tasks.add_task(send_confirmation_email, order.id)  # fire and forget
    return order
```
