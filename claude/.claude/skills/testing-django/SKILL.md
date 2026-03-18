---
name: testing-django
description: >
  Load when writing or reviewing tests for Django or Django REST Framework — APITestCase,
  pytest-django, factory_boy, authentication in tests, and permission testing. Covers the
  patterns Claude consistently gets wrong: force_authenticate vs token auth, missing
  django_db marks, queryset assertions, and incomplete permission coverage.
---

# Django Testing: What Claude Gets Wrong

This skill covers testing Django REST Framework APIs with both `APITestCase` and
`pytest-django`. It's a correction guide, not a tutorial.

---

## Authentication in Tests: `force_authenticate`, Not Token Strings

Building a real JWT in every test is slow and brittle. Use `force_authenticate` for
unit/integration tests. Test the real auth flow only in dedicated auth tests.

```python
# WRONG — brittle, slow, couples tests to auth implementation
class OrderAPITest(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(email="test@example.com", password="pass")
        response = self.client.post("/api/auth/login", {"email": "test@example.com", "password": "pass"})
        self.token = response.data["access"]
        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {self.token}")

# RIGHT — force_authenticate bypasses token validation; test business logic, not auth
class OrderAPITest(APITestCase):
    def setUp(self):
        self.user = UserFactory()
        self.client.force_authenticate(user=self.user)

# For pytest-django style
@pytest.fixture
def auth_client(api_client, user):
    api_client.force_authenticate(user=user)
    return api_client

@pytest.fixture
def api_client():
    return APIClient()
```

---

## pytest-django: Always Mark DB Tests

Without `@pytest.mark.django_db`, tests that hit the database raise an error.
Configure `django_db_setup` in `conftest.py` to avoid marking every single test.

```python
# WRONG — will raise django.test.utils.DatabaseBlockedBySetup
def test_create_order():
    order = OrderFactory()  # hits DB — no mark

# RIGHT — explicit mark
@pytest.mark.django_db
def test_create_order():
    order = OrderFactory()
    assert order.id is not None

# BETTER — use a base class fixture or conftest pytestmark to apply globally per module
# conftest.py
pytestmark = pytest.mark.django_db  # applies to all tests in this module

# OR: set in pytest.ini / pyproject.toml
# [pytest]
# addopts = --reuse-db  # django-pytest-factoryboy speedup
```

---

## factory_boy with Django: `DjangoModelFactory`

```python
import factory
from factory.django import DjangoModelFactory

class UserFactory(DjangoModelFactory):
    class Meta:
        model = User

    email = factory.Sequence(lambda n: f"user{n}@example.com")
    name = factory.Faker("name")
    password = factory.PostGenerationMethodCall("set_password", "testpass123")
    # set_password hashes correctly — do NOT use password="plaintext"

class OrderFactory(DjangoModelFactory):
    class Meta:
        model = Order

    user = factory.SubFactory(UserFactory)
    status = "pending"
    total = factory.Faker("pydecimal", left_digits=4, right_digits=2, positive=True)

class OrderItemFactory(DjangoModelFactory):
    class Meta:
        model = OrderItem

    order = factory.SubFactory(OrderFactory)
    product = factory.SubFactory(ProductFactory)
    quantity = factory.Faker("random_int", min=1, max=10)
```

---

## Testing ViewSets: Cover All Permission Paths

Every endpoint needs at minimum: happy path, unauthenticated, and wrong-user tests.

```python
@pytest.mark.django_db
class TestOrderAPI:
    # 1. Happy path
    def test_list_orders_returns_own_orders(self, auth_client, user):
        own_orders = OrderFactory.create_batch(3, user=user)
        other_order = OrderFactory()  # different user
        response = auth_client.get("/api/v1/orders/")
        assert response.status_code == 200
        ids = [o["id"] for o in response.data["results"]]
        assert all(str(o.id) in ids for o in own_orders)
        assert str(other_order.id) not in ids  # isolation enforced

    # 2. Unauthenticated
    def test_list_orders_unauthenticated_returns_401(self, api_client):
        response = api_client.get("/api/v1/orders/")
        assert response.status_code == 401

    # 3. Wrong user (object-level permission)
    def test_get_order_by_other_user_returns_404(self, auth_client):
        other_order = OrderFactory()  # different user
        response = auth_client.get(f"/api/v1/orders/{other_order.id}/")
        assert response.status_code == 404  # not 403 — don't reveal existence

    # 4. Validation
    def test_create_order_with_missing_fields_returns_400(self, auth_client):
        response = auth_client.post("/api/v1/orders/", data={}, format="json")
        assert response.status_code == 400
        assert "product" in response.data  # field-level error present
```

---

## Queryset Assertions: Test What the DB Contains

Don't only assert on the API response — assert the DB state changed correctly.

```python
def test_delete_order_removes_from_database(self, auth_client, user):
    order = OrderFactory(user=user)
    response = auth_client.delete(f"/api/v1/orders/{order.id}/")
    assert response.status_code == 204
    assert not Order.objects.filter(id=order.id).exists()  # verify DB state

def test_create_order_sets_correct_user(self, auth_client, user, product):
    response = auth_client.post("/api/v1/orders/", data={"product": str(product.id)}, format="json")
    assert response.status_code == 201
    order = Order.objects.get(id=response.data["id"])
    assert order.user == user  # not just what the response says
```

---

## Testing Signals and Emails: Use `mail.outbox`

```python
from django.core import mail

def test_order_confirmation_email_sent(auth_client, user, product):
    auth_client.post("/api/v1/orders/", data={"product": str(product.id)}, format="json")
    assert len(mail.outbox) == 1
    assert mail.outbox[0].to == [user.email]
    assert "confirmed" in mail.outbox[0].subject.lower()

# For Celery tasks: use CELERY_TASK_ALWAYS_EAGER = True in test settings
# or mock the task directly
def test_does_not_block_on_slow_task(mocker, auth_client, product):
    mock_task = mocker.patch("app.orders.tasks.generate_invoice.delay")
    auth_client.post("/api/v1/orders/", data={"product": str(product.id)}, format="json")
    mock_task.assert_called_once()
```

---

## Database Transactions in Tests

`APITestCase` (and `TestCase`) wraps each test in a transaction that rolls back —
fast but doesn't test `on_commit` hooks. `TransactionTestCase` actually commits
but is slower and requires explicit cleanup.

```python
# Use APITestCase (default) — fast, automatic rollback
class OrderAPITest(APITestCase): ...

# Use TransactionTestCase when testing on_commit callbacks or DB signals
# that only fire after a real commit
class OrderOnCommitTest(TransactionTestCase):
    def test_invoice_generated_after_commit(self):
        with self.captureOnCommitCallbacks(execute=True):
            OrderFactory(status="confirmed")
        # on_commit callbacks ran — assert their side effects
```
