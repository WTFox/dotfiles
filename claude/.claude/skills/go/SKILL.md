---
name: go
description: >
  Load when writing, reviewing, or debugging Go code — services, CLI tools,
  HTTP handlers, concurrency patterns, or tests. Covers the patterns Claude
  consistently gets wrong in production Go: error wrapping, goroutine leaks,
  context propagation, and project layout. Do not load for Python or other languages.
---

# Go: What Claude Gets Wrong in Production Code

This skill is not a Go tutorial. It's a correction guide for the specific patterns
that tend to be wrong in AI-generated Go code. Read this before writing or reviewing
any Go in this project.

---

## Error Handling: Always Wrap with Context

The most common mistake in generated Go is bare error returns with no context.
In production, "record not found" is useless. "get user by id abc-123: record not found"
is actionable.

```go
// WRONG — loses context at every layer
func (r *UserRepo) GetByID(ctx context.Context, id uuid.UUID) (*User, error) {
    var user User
    err := r.db.QueryRowContext(ctx, `SELECT ...`, id).Scan(&user.ID, &user.Email)
    if err != nil {
        return nil, err  // caller sees "sql: no rows" with no idea which query
    }
    return &user, nil
}

// RIGHT — wrap with %w to preserve the chain for errors.Is/errors.As
func (r *UserRepo) GetByID(ctx context.Context, id uuid.UUID) (*User, error) {
    var user User
    err := r.db.QueryRowContext(ctx, `SELECT ...`, id).Scan(&user.ID, &user.Email)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, fmt.Errorf("get user %s: %w", id, ErrNotFound)
        }
        return nil, fmt.Errorf("get user %s: %w", id, err)
    }
    return &user, nil
}
```

**Sentinel errors** for conditions callers need to check:
```go
// Define in the package that owns the concept
var (
    ErrNotFound   = errors.New("not found")
    ErrConflict   = errors.New("conflict")
    ErrForbidden  = errors.New("forbidden")
)

// Check with errors.Is — works through the %w wrapping chain
if errors.Is(err, ErrNotFound) {
    http.Error(w, "not found", http.StatusNotFound)
}
```

---

## Context: First Parameter, Propagated Everywhere

`context.Context` must be the first parameter of every function that does I/O.
No exceptions. If you're adding a `ctx` parameter three layers deep because an inner
function needs it, that's correct — propagate it all the way up.

```go
// WRONG — context stops at the handler
func (h *Handler) GetUser(w http.ResponseWriter, r *http.Request) {
    user, err := h.repo.GetByID(uuid.MustParse(id))  // no ctx — can't cancel
}

// RIGHT — ctx flows from request to repo
func (h *Handler) GetUser(w http.ResponseWriter, r *http.Request) {
    user, err := h.repo.GetByID(r.Context(), uuid.MustParse(id))
}

// WRONG — creating a background context inside a function that received one
func (s *Service) Process(ctx context.Context, id string) error {
    return s.repo.Update(context.Background(), id)  // loses cancellation signal
}

// RIGHT — pass ctx through
func (s *Service) Process(ctx context.Context, id string) error {
    return s.repo.Update(ctx, id)
}
```

---

## Goroutines: Never Launch Without a Leak Prevention Plan

Every goroutine needs an answer to: "what stops this goroutine and when?"
Uncontrolled goroutines are the most common source of memory leaks in Go services.

```go
// WRONG — goroutine leaks if the caller exits or ctx is cancelled
go func() {
    for item := range items {
        process(item)  // runs forever, no way to stop it
    }
}()

// RIGHT — goroutine exits when ctx is cancelled
go func() {
    for {
        select {
        case <-ctx.Done():
            return
        case item, ok := <-items:
            if !ok {
                return
            }
            process(item)
        }
    }
}()

// RIGHT — use errgroup for structured concurrency
g, ctx := errgroup.WithContext(ctx)
for _, item := range items {
    item := item  // capture loop variable (pre-Go 1.22)
    g.Go(func() error {
        return process(ctx, item)
    })
}
if err := g.Wait(); err != nil {
    return fmt.Errorf("process batch: %w", err)
}
```

---

## Project Layout: The Standard Structure

```
cmd/
  server/
    main.go           # Entry point — only flag parsing and wiring. No logic.
internal/             # Private packages — not importable by other modules
  handlers/           # HTTP handlers (thin — parse, call service, respond)
  services/           # Business logic
  repository/         # Data access
  models/             # Domain types (structs, not ORM models)
  config/             # Config struct loaded from environment
pkg/                  # Public packages (if any are truly reusable externally)
migrations/           # SQL migration files
```

`internal/` is enforced by the Go toolchain — other modules cannot import it.
Use it for everything that isn't intentionally a public API.

`main.go` should be ~20 lines: parse flags, load config, wire dependencies, call `run()`.
All real logic lives in `internal/`.

---

## Interfaces: Define Them at the Point of Use

Go interfaces are implicit and should be small. Define them where they're consumed,
not where they're implemented. This is the opposite of Java/C# convention.

```go
// WRONG — large interface defined in the repository package
// (forces all consumers to implement 15 methods)
type UserRepository interface {
    GetByID(ctx context.Context, id uuid.UUID) (*User, error)
    GetByEmail(ctx context.Context, email string) (*User, error)
    List(ctx context.Context, limit, offset int) ([]*User, error)
    Create(ctx context.Context, u *User) error
    Update(ctx context.Context, u *User) error
    Delete(ctx context.Context, id uuid.UUID) error
    // ... 9 more methods
}

// RIGHT — service defines the interface it actually needs
// (easy to mock in tests, easy to swap implementations)
type userGetter interface {
    GetByID(ctx context.Context, id uuid.UUID) (*User, error)
}

type UserService struct {
    repo userGetter  // only depends on what it uses
}
```

---

## Testing: Table-Driven Tests Are the Standard

```go
func TestGetByID(t *testing.T) {
    tests := []struct {
        name    string
        id      uuid.UUID
        setup   func(*testing.T, *sql.DB)
        want    *User
        wantErr error
    }{
        {
            name: "returns user when found",
            id:   testUserID,
            setup: func(t *testing.T, db *sql.DB) {
                insertTestUser(t, db, testUserID, "alice@example.com")
            },
            want: &User{ID: testUserID, Email: "alice@example.com"},
        },
        {
            name:    "returns ErrNotFound when missing",
            id:      uuid.New(),
            setup:   func(t *testing.T, db *sql.DB) {},
            wantErr: ErrNotFound,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            db := setupTestDB(t)  // t.Cleanup handles teardown
            tt.setup(t, db)
            repo := NewUserRepo(db)

            got, err := repo.GetByID(context.Background(), tt.id)

            if tt.wantErr != nil {
                if !errors.Is(err, tt.wantErr) {
                    t.Errorf("GetByID() error = %v, wantErr %v", err, tt.wantErr)
                }
                return
            }
            if err != nil {
                t.Fatalf("GetByID() unexpected error: %v", err)
            }
            // Compare with reflect.DeepEqual or cmp.Diff — not ==
            if diff := cmp.Diff(tt.want, got); diff != "" {
                t.Errorf("GetByID() mismatch (-want +got):\n%s", diff)
            }
        })
    }
}
```

Use `t.Cleanup` not `defer` for test teardown — it runs even if the test calls `t.Fatal`.
Use `testify/require` only when the assertion should stop the test. Use `testify/assert`
for non-fatal checks. `cmp.Diff` (from `google/go-cmp`) gives much better failure messages
than `reflect.DeepEqual`.

---

## Common Gotchas

**Loop variable capture (pre-Go 1.22):** In Go versions before 1.22, loop variables are
shared across iterations. Always capture inside the loop body when launching goroutines:
```go
for _, id := range ids {
    id := id  // re-declare — creates new variable for each iteration
    go process(id)
}
```

**`defer` in loops:** Deferred calls run at function return, not at the end of
the loop iteration. Don't `defer file.Close()` inside a loop — close it explicitly
or move to a helper function.

**nil interface vs nil pointer:** A nil pointer stored in a non-nil interface is not nil.
```go
var u *User = nil
var i interface{} = u
fmt.Println(i == nil)  // false — the interface has a type, only the value is nil
```

**`http.DefaultServeMux`:** Never use the default mux in production — it's global and
any package can register routes on it. Always create `http.NewServeMux()`.
