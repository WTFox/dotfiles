---
name: testing-python
description: >
  Load when writing or reviewing Python tests — pytest fixtures, factory_boy,
  async tests, mocking, and test structure. Covers the patterns Claude consistently
  gets wrong: over-mocking, fixture scope, test naming, and the difference between
  unit and integration tests.
---

# Python Testing: What Claude Gets Wrong

This skill covers pytest patterns for FastAPI/SQLAlchemy projects. It's a correction
guide, not a pytest tutorial.

---

## Test Naming: `test_<what>_<when>_<expected>`

Test names are documentation. When a test fails at 2am, the name is all you have.

```python
# WRONG — what does this test? what's the expected outcome?
def test_create():
def test_order_1():
def test_error():

# RIGHT — readable failure messages without opening the file
def test_create_order_with_valid_payload_returns_201():
def test_create_order_when_product_not_found_returns_404():
def test_create_order_when_unauthenticated_returns_401():
def test_list_orders_returns_only_current_users_orders():
```

---

## Fixtures Over `setUp`: Compose, Don't Inherit

```python
# WRONG — unittest style in pytest (misses all the composability)
class TestOrdersAPI(unittest.TestCase):
    def setUp(self):
        self.client = TestClient(app)
        self.user = create_test_user()

# RIGHT — pytest fixtures compose, have scope control, and are reusable across files
@pytest.fixture
def client() -> TestClient:
    return TestClient(app)

@pytest.fixture
def auth_client(client: TestClient, user: User) -> TestClient:
    client.headers["Authorization"] = f"Bearer {create_token(user.id)}"
    return client

# Tests receive only what they need
def test_create_order(auth_client: TestClient, product: Product):
    response = auth_client.post("/api/v1/orders", json={"product_id": str(product.id)})
    assert response.status_code == 201
```

---

## factory_boy: No Hardcoded IDs or Data

Hardcoded test data creates hidden coupling between tests. One test's teardown
affects another's IDs. Use factories.

```python
# WRONG — hardcoded IDs, coupled tests
def test_get_order():
    response = client.get("/api/v1/orders/550e8400-e29b-41d4-a716-446655440000")
    assert response.status_code == 200

# RIGHT — factory creates isolated, realistic data
import factory
from factory.alchemy import SQLAlchemyModelFactory

class UserFactory(SQLAlchemyModelFactory):
    class Meta:
        model = User
        sqlalchemy_session_persistence = "commit"

    id = factory.LazyFunction(uuid4)
    email = factory.Sequence(lambda n: f"user{n}@example.com")
    name = factory.Faker("name")

class OrderFactory(SQLAlchemyModelFactory):
    class Meta:
        model = Order

    id = factory.LazyFunction(uuid4)
    user = factory.SubFactory(UserFactory)
    total = factory.Faker("pydecimal", left_digits=4, right_digits=2, positive=True)

# In tests
def test_get_order(auth_client: TestClient, db_session: Session):
    order = OrderFactory(user=auth_client.user)  # or use a fixture
    response = auth_client.get(f"/api/v1/orders/{order.id}")
    assert response.status_code == 200
```

---

## Async Tests: Use `pytest-anyio` or `pytest-asyncio`

```python
# WRONG — calling async code in a sync test
def test_create_user():
    user = user_service.create(...)  # returns a coroutine, not a User

# RIGHT — mark async tests (configure anyio_mode = "auto" in pytest.ini to avoid per-test marks)
import pytest

@pytest.mark.anyio
async def test_create_user(db_session: AsyncSession):
    service = UserService(UserRepo(db_session))
    user = await service.create(UserCreate(email="test@example.com"))
    assert user.id is not None
```

For FastAPI, prefer `httpx.AsyncClient` over `TestClient` for async tests:
```python
@pytest.fixture
async def async_client() -> AsyncGenerator[AsyncClient, None]:
    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client
```

---

## What to Mock (and What Not To)

Mock at the boundary of your system. Don't mock your own code.

```python
# WRONG — mocking your own repository; the test no longer tests real behavior
def test_create_order(mocker):
    mocker.patch.object(OrderRepo, "create", return_value=mock_order)
    result = order_service.create(payload)
    # this test passes even if create() has a bug

# RIGHT — use a real in-memory or test database; mock only external calls
@pytest.mark.anyio
async def test_create_order(db_session: AsyncSession):
    # Real DB, real repo, real service — tests the actual integration
    service = OrderService(OrderRepo(db_session), ProductRepo(db_session))
    order = await service.create(user_id, OrderCreate(product_id=product.id, quantity=2))
    assert order.id is not None
    assert order.total == product.price * 2

# Mock only: external HTTP calls, email/SMS sends, payment processors, S3/storage
def test_send_confirmation_email(mocker):
    mock_send = mocker.patch("app.email.send_email")
    order_service.create(payload)
    mock_send.assert_called_once_with(to=payload.email, subject="Order confirmed")
```

**Patch where the name is used, not where it's defined:**
```python
# The function is defined in app.utils but imported into app.services
# WRONG — patches the definition, not the usage
mocker.patch("app.utils.send_email")

# RIGHT — patches the name as seen by the code under test
mocker.patch("app.services.order_service.send_email")
```

---

## Fixture Scope: Match the Cost of Setup

```python
# session scope — created once for the entire test run (database engine, app instance)
@pytest.fixture(scope="session")
def engine():
    return create_async_engine(TEST_DATABASE_URL)

# function scope (default) — fresh per test (DB session, test data)
@pytest.fixture
async def db_session(engine) -> AsyncGenerator[AsyncSession, None]:
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    async with AsyncSession(engine) as session:
        yield session
        await session.rollback()  # clean up after each test
```

Use `scope="function"` (default) for anything that writes to the DB.
Use `scope="session"` for read-only, expensive setup (engine, schema creation).

---

## Every API Endpoint Needs These Four Tests

Minimum coverage for any authenticated endpoint:

```python
# 1. Happy path
def test_create_order_returns_201(auth_client, product):
    r = auth_client.post("/api/v1/orders", json={"product_id": str(product.id)})
    assert r.status_code == 201
    assert r.json()["id"] is not None

# 2. Unauthenticated (no token)
def test_create_order_unauthenticated_returns_401(client, product):
    r = client.post("/api/v1/orders", json={"product_id": str(product.id)})
    assert r.status_code == 401

# 3. Wrong user (authenticated but not authorized)
def test_get_order_by_different_user_returns_404(auth_client, other_users_order):
    r = auth_client.get(f"/api/v1/orders/{other_users_order.id}")
    assert r.status_code == 404  # or 403 — be consistent

# 4. Invalid input (validation)
def test_create_order_with_missing_product_returns_422(auth_client):
    r = auth_client.post("/api/v1/orders", json={})
    assert r.status_code == 422
```
