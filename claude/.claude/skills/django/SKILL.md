---
name: django
description: >
  Load when writing, reviewing, or debugging Django code — models, views, DRF
  serializers, viewsets, URL routing, signals, or admin. Covers the patterns Claude
  consistently gets wrong: queryset filtering, N+1 via ORM relationships, DRF
  serializer validation, permission classes, and queryset ownership scoping.
  Load alongside testing-django when writing tests.
---

# Django: What Claude Gets Wrong in Production Code

This skill covers Django 4.x+ with Django REST Framework. It's a correction guide,
not a tutorial.

---

## Queryset Scoping: Filter by Ownership in `get_queryset()`

The most common DRF mistake: returning all objects to all authenticated users.
Ownership filtering belongs in `get_queryset()`, not in individual actions.

```python
# WRONG — any authenticated user can read any order
class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

# RIGHT — queryset scoped to the current user
class OrderViewSet(viewsets.ModelViewSet):
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user)
        # admin users might bypass: if self.request.user.is_staff: return Order.objects.all()
```

---

## N+1 Queries: `select_related` and `prefetch_related`

Django's ORM lazy-loads relationships. Accessing a FK or M2M field on 100 objects
fires 100 queries.

```python
# WRONG — fires 1 query for orders + 1 per order for the user (N+1)
orders = Order.objects.all()
for order in orders:
    print(order.user.email)  # separate query per iteration

# RIGHT — select_related for ForeignKey/OneToOne (SQL JOIN)
orders = Order.objects.select_related("user").all()

# RIGHT — prefetch_related for ManyToMany or reverse FK (separate IN query)
orders = Order.objects.prefetch_related("items__product").all()

# Combine both when needed
orders = (
    Order.objects
    .select_related("user")
    .prefetch_related("items__product", "tags")
    .filter(status="pending")
)
```

Use Django Debug Toolbar or `django.db.connection.queries` to verify query count.

---

## Serializers: Explicit Fields, Never `__all__`

`fields = "__all__"` exposes every model field including password hashes, internal
fields, and future fields you haven't considered yet.

```python
# WRONG — exposes password, internal_notes, stripe_customer_id, everything
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

# RIGHT — explicit list; add fields deliberately
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "email", "name", "created_at"]
        read_only_fields = ["id", "created_at"]

# Separate serializers for read vs write when shapes differ
class UserCreateSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=8)

    class Meta:
        model = User
        fields = ["email", "name", "password"]

    def create(self, validated_data):
        return User.objects.create_user(**validated_data)  # hashes password
```

---

## `perform_create`: Inject Request Context

Auto-populated fields (current user, parent FK) belong in `perform_create`, not
in the serializer.

```python
# WRONG — user passed in request body (client can forge it)
class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ["id", "order", "author", "content"]  # author from client

# RIGHT — inject author from the authenticated request
class CommentViewSet(viewsets.ModelViewSet):
    def perform_create(self, serializer):
        serializer.save(author=self.request.user)

class CommentSerializer(serializers.ModelSerializer):
    author = UserSerializer(read_only=True)  # read-only in response

    class Meta:
        model = Comment
        fields = ["id", "order", "author", "content"]
```

---

## Object-Level Permissions: Custom Permission Classes

DRF's `IsAuthenticated` checks that a user is logged in. For "can this user touch
this object," write a custom permission class.

```python
# WRONG — ownership check inside the view action (duplicated everywhere)
class CommentViewSet(viewsets.ModelViewSet):
    def destroy(self, request, pk=None):
        comment = self.get_object()
        if comment.author != request.user and not request.user.is_staff:
            return Response(status=403)
        comment.delete()
        return Response(status=204)

# RIGHT — reusable permission class
class IsOwnerOrAdmin(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.user.is_staff:
            return True
        return obj.author == request.user  # or obj.user, obj.owner — match the model field

class CommentViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated, IsOwnerOrAdmin]
    # get_object() automatically calls has_object_permission()
```

---

## Model Design: Explicit `on_delete`, Indexes, `__str__`

```python
# WRONG — missing on_delete (required), no indexes, no __str__
class Order(models.Model):
    user = models.ForeignKey(User)  # error: on_delete required
    product = models.ForeignKey(Product)
    created_at = models.DateTimeField(auto_now_add=True)

# RIGHT
import uuid

class Order(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="orders",
        db_index=True,  # explicit index (Django adds one for FK by default, but be explicit)
    )
    status = models.CharField(
        max_length=20,
        choices=[("pending", "Pending"), ("confirmed", "Confirmed"), ("shipped", "Shipped")],
        default="pending",
        db_index=True,  # index filter columns explicitly
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["user", "status"]),  # compound index for common filter
        ]

    def __str__(self) -> str:
        return f"Order {self.id} by {self.user_id} ({self.status})"
```

---

## Signals: Use Sparingly, Document Why

Signals create invisible coupling. Prefer explicit method calls over signals for
anything that's part of a predictable business flow.

```python
# BAD USE — post_save hides a critical side effect
@receiver(post_save, sender=Order)
def send_confirmation(sender, instance, created, **kwargs):
    if created:
        send_email(instance.user.email, ...)
# Problem: every test that creates an Order now sends email unless mocked

# GOOD USE — cache invalidation, search index updates, audit logging
# (side effects that are truly orthogonal to the business operation)
@receiver(post_save, sender=Product)
def invalidate_product_cache(sender, instance, **kwargs):
    cache.delete(f"product:{instance.id}")

# For business flows, call explicitly
def create_order(user, payload) -> Order:
    order = Order.objects.create(user=user, ...)
    send_confirmation_email(order)  # explicit, visible, testable
    return order
```

---

## `get_object_or_404` vs `get()`

```python
# WRONG — raises DoesNotExist (500 error) if not found
order = Order.objects.get(id=order_id)

# WRONG — need to remember to raise manually
order = Order.objects.filter(id=order_id).first()
if not order:
    return Response(status=404)

# RIGHT — raises Http404 (404 response) automatically
from django.shortcuts import get_object_or_404
order = get_object_or_404(Order, id=order_id, user=request.user)
# bonus: enforces ownership in one line
```
