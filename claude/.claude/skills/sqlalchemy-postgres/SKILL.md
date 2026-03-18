---
name: sqlalchemy-postgres
description: >
  Load when writing, reviewing, or debugging SQLAlchemy 2.x ORM code against
  PostgreSQL. Covers the patterns Claude consistently gets wrong: select() vs
  query(), async session usage, relationship loading, N+1 queries, transactions,
  and Alembic migration gotchas.
---

# SQLAlchemy + PostgreSQL: What Claude Gets Wrong in Production Code

This skill covers SQLAlchemy 2.x async patterns. If the codebase uses SQLAlchemy 1.x
(session.query() style), note that explicitly — the patterns differ significantly.

---

## `select()` Not `session.query()`: SQLAlchemy 2.x Style

`session.query()` is the SQLAlchemy 1.x API. All new code uses `select()`.

```python
# WRONG — SQLAlchemy 1.x style (still works but deprecated)
users = session.query(User).filter(User.email == email).all()
user = session.query(User).filter_by(id=user_id).first()

# RIGHT — SQLAlchemy 2.x style
from sqlalchemy import select

result = await session.execute(select(User).where(User.email == email))
users = result.scalars().all()

result = await session.execute(select(User).where(User.id == user_id))
user = result.scalar_one_or_none()
```

`scalar_one_or_none()` returns the object or `None`. `scalar_one()` returns the object
or raises if zero or multiple rows. `scalars().all()` returns a list.

---

## Async Session: Don't Create It Inside Functions

The session is a unit of work. It should be created by the dependency injection system
and injected — never created inside a repository or service method.

```python
# WRONG — creates a new session per call, can't participate in a transaction
class UserRepo:
    async def get_by_id(self, user_id: UUID) -> User | None:
        async with async_session() as session:  # wrong — creates its own session
            result = await session.execute(select(User).where(User.id == user_id))
            return result.scalar_one_or_none()

# RIGHT — session is injected
class UserRepo:
    def __init__(self, session: AsyncSession) -> None:
        self.session = session

    async def get_by_id(self, user_id: UUID) -> User | None:
        result = await self.session.execute(select(User).where(User.id == user_id))
        return result.scalar_one_or_none()
```

---

## Relationship Loading: Avoid N+1 Queries

SQLAlchemy's default lazy loading fires a new SQL query for each relationship access.
In async mode, lazy loading is disabled entirely — you must declare eager loading.

```python
# WRONG — accessing order.items fires a separate query per order
orders = (await session.execute(select(Order))).scalars().all()
for order in orders:
    print(order.items)  # raises MissingGreenlet in async / fires N queries in sync

# RIGHT — load relationships in the initial query
from sqlalchemy.orm import selectinload, joinedload

# selectinload: separate IN query (best for one-to-many)
result = await session.execute(
    select(Order).options(selectinload(Order.items))
)
orders = result.scalars().all()

# joinedload: SQL JOIN (best for many-to-one / single object)
result = await session.execute(
    select(Order).options(joinedload(Order.customer))
    .where(Order.id == order_id)
)
order = result.unique().scalar_one_or_none()
# Note: .unique() is required when using joinedload to deduplicate rows
```

---

## UUID Primary Keys with PostgreSQL

```python
# WRONG — uses Python-generated UUIDs (doesn't use Postgres gen_random_uuid())
class User(Base):
    id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)

# RIGHT — Postgres generates the UUID at insert time (more efficient, works in migrations)
from sqlalchemy import func

class User(Base):
    id: Mapped[UUID] = mapped_column(
        primary_key=True,
        server_default=func.gen_random_uuid(),
    )
```

---

## Transactions: Let the Session Manage Them

```python
# WRONG — manual commit/rollback scattered through service code
async def transfer_funds(from_id: UUID, to_id: UUID, amount: Decimal) -> None:
    from_account.balance -= amount
    await session.commit()      # committed before the credit — leaves DB inconsistent on failure
    to_account.balance += amount
    await session.commit()

# RIGHT — keep all writes in one transaction; commit once at the end
async def transfer_funds(from_id: UUID, to_id: UUID, amount: Decimal) -> None:
    from_account = await session.get(Account, from_id)
    to_account = await session.get(Account, to_id)
    from_account.balance -= amount
    to_account.balance += amount
    # session.commit() called by the dependency (or explicitly once at the end)
    await session.commit()

# For multi-step operations that need an explicit savepoint:
async with session.begin_nested():  # creates a SAVEPOINT
    # operations here — rolled back to savepoint on exception
    ...
```

---

## `expire_on_commit`: Set to False for Async

After `session.commit()`, SQLAlchemy expires all attributes by default. Accessing
them fires a new query — which requires an active session. In async code with
connection-per-request patterns this frequently causes `DetachedInstanceError`.

```python
# In your session factory
async_session = async_sessionmaker(
    engine,
    class_=AsyncSession,
    expire_on_commit=False,  # attributes remain accessible after commit
)
```

---

## Alembic: Migration Gotchas

**Always check the generated migration before applying it.** Alembic's autogenerate
misses: custom types, partial indexes, check constraints, column server defaults set
via DDL (not `server_default=`), and changes inside JSON/JSONB columns.

```python
# After alembic revision --autogenerate -m "add comments table":
# 1. Open the generated file in migrations/versions/
# 2. Verify upgrade() creates exactly what you expect
# 3. Verify downgrade() reverses it completely
# 4. Check that indexes are created for every FK column — Alembic often misses these

# WRONG migration — missing index on FK column
def upgrade() -> None:
    op.add_column("comments", sa.Column("order_id", sa.UUID(), nullable=False))

# RIGHT migration — FK column always gets an index
def upgrade() -> None:
    op.add_column("comments", sa.Column("order_id", sa.UUID(), nullable=False))
    op.create_index("ix_comments_order_id", "comments", ["order_id"])
```

**Adding NOT NULL columns to existing tables:** You can't add a non-nullable column
without a default to a table that already has rows. Either add with a server default,
or use a two-step migration (add nullable → backfill → add NOT NULL constraint).
