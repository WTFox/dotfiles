---
name: security-checklist
description: >
  Load when reviewing code for security issues, writing authentication or
  authorization logic, or scaffolding new endpoints. Provides a systematic
  checklist covering injection, authentication, authorization, data exposure,
  secrets, and input validation. Language-agnostic — applies to Python, Go, Rust, C#.
---

# Security Checklist

Work through each section systematically. State what you checked and what you found
— even when clean. A section marked "checked, clean" is evidence of a review;
silence is not.

---

## 1. Injection (SQL, Command, Template)

The most critical category. Any instance is severity **CRITICAL**.

**SQL injection** — look for string construction in query positions:
```python
# CRITICAL — f-string in a SQL query
query = f"SELECT * FROM users WHERE email = '{email}'"
session.execute(text(query))

# CRITICAL — format() or % in query
cursor.execute("SELECT * FROM users WHERE id = %s" % user_id)  # % is fine for psycopg2 params but % formatting is not

# SAFE — parameterized query (ORM or explicit params)
session.execute(select(User).where(User.email == email))  # SQLAlchemy ORM
cursor.execute("SELECT * FROM users WHERE email = %s", (email,))  # psycopg2 params
```

**Command injection** — look for `subprocess`, `os.system`, `exec`, `eval` with user input:
```python
# CRITICAL — user input in shell command
os.system(f"convert {filename} output.png")   # filename = "x; rm -rf /"
subprocess.run(f"grep {pattern} logs.txt", shell=True)  # shell=True + user input = injection

# SAFE — pass as list, never shell=True with user input
subprocess.run(["convert", filename, "output.png"])
```

**Template injection** — Jinja2 `render_template_string` with user content is injection.
Always use `render_template` with static template files.

---

## 2. Authentication: Is the Endpoint Protected?

For every endpoint, ask: can an unauthenticated request reach this handler?

```python
# WRONG — no auth dependency; anyone can call this
@router.get("/admin/users")
async def list_all_users(session: SessionDep):
    ...

# RIGHT — requires valid token
@router.get("/admin/users")
async def list_all_users(current_user: CurrentUser, session: SessionDep):
    ...
```

Check:
- [ ] Every non-public endpoint has an auth dependency
- [ ] Token validation checks expiry (`exp` claim), signature, and issuer
- [ ] Refresh tokens are rotated on use (prevent token reuse after logout)
- [ ] Logout invalidates the token (blocklist or short expiry + refresh rotation)

---

## 3. Authorization: Does the User Own This Resource?

Authentication answers "who are you?" Authorization answers "are you allowed to do this?"
Missing authorization is severity **HIGH**.

```python
# WRONG — authenticated, but any user can read any order
@router.get("/orders/{order_id}", response_model=OrderResponse)
async def get_order(order_id: UUID, current_user: CurrentUser, service: OrderServiceDep):
    return await service.get_by_id(order_id)  # doesn't check ownership

# RIGHT — service filters by owner
async def get_by_id(self, order_id: UUID, user_id: UUID) -> Order:
    order = await self.repo.get_by_id(order_id)
    if order is None or order.user_id != user_id:
        raise NotFoundError("Order", str(order_id))  # 404, not 403 — don't confirm existence
    return order
```

Check:
- [ ] Every `GET /resource/{id}` checks the resource belongs to the current user (or user has permission)
- [ ] Every `PATCH/PUT/DELETE` checks ownership before writing
- [ ] Admin-only endpoints check for admin role, not just authentication
- [ ] Returning 404 (not 403) for unauthorized access to prevent existence disclosure

---

## 4. Data Exposure: What Are You Returning?

```python
# WRONG — ORM model returned directly; serializes ALL columns including password_hash
@router.get("/users/{id}")
async def get_user(user_id: UUID) -> User:  # User is the ORM model
    return await session.get(User, user_id)

# RIGHT — explicit response schema controls exactly what's returned
@router.get("/users/{id}", response_model=UserResponse)
async def get_user(user_id: UUID) -> UserResponse:
    ...

class UserResponse(BaseModel):
    id: UUID
    email: str
    name: str
    # password_hash, internal_notes, stripe_customer_id — NOT included
```

Check:
- [ ] Every endpoint has `response_model=` declared
- [ ] No password hashes, tokens, or internal IDs in API responses
- [ ] List endpoints don't include fields that are safe for individual objects but risky in bulk
- [ ] Error messages don't leak internal paths, stack traces, or SQL errors to clients

---

## 5. Secrets: No Hardcoded Credentials

Any hardcoded secret is severity **CRITICAL** — it's already compromised if it's in git.

```python
# CRITICAL — hardcoded in source
DATABASE_URL = "postgresql://admin:password123@prod-db.example.com/mydb"
STRIPE_KEY = "sk_live_abc123..."
JWT_SECRET = "my-secret-key"

# RIGHT — from environment / config system
import os
DATABASE_URL = os.environ["DATABASE_URL"]  # raises if missing — explicit failure
JWT_SECRET = settings.jwt_secret  # loaded via pydantic Settings from .env
```

Check:
- [ ] No credentials, API keys, tokens, or private keys in source code
- [ ] `.env` files are in `.gitignore`
- [ ] Secrets in CI/CD use the platform's secrets manager, not environment variables in workflow files
- [ ] Dependencies don't have known CVEs (`pip audit`, `npm audit`, `cargo audit`)

---

## 6. Input Validation: Validate at the Boundary

All external input (request bodies, query params, path params, file uploads) is untrusted.

```python
# WRONG — trusting user-supplied content type for file uploads
@router.post("/upload")
async def upload(file: UploadFile):
    # file.content_type is set by the client — it lies
    if file.content_type == "image/jpeg":
        process_image(await file.read())

# RIGHT — validate file content, not the claimed content type
import imghdr

content = await file.read()
actual_type = imghdr.what(None, h=content)
if actual_type not in ("jpeg", "png", "gif"):
    raise HTTPException(status_code=400, detail="Only JPEG, PNG, GIF allowed")
```

Check:
- [ ] Request bodies validated with Pydantic / FluentValidation / serde — not manual checks
- [ ] String length limits on all text fields (prevent DoS via huge inputs)
- [ ] File uploads: validate content (magic bytes), not claimed content type; enforce size limits
- [ ] Pagination parameters bounded (e.g., `limit: int = Query(default=20, le=100)`)
- [ ] Path parameters are UUIDs/ints, not raw strings used in queries

---

## 7. CORS and Headers

```python
# WRONG — allows any origin (fine for development, dangerous in production)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,  # this combination is especially dangerous
)

# RIGHT — explicit allowlist
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_origins,  # ["https://app.example.com"]
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE"],
    allow_headers=["Authorization", "Content-Type"],
)
```

In production, also set:
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`
- `Strict-Transport-Security` (HTTPS only)
- `Content-Security-Policy` (if serving HTML)
