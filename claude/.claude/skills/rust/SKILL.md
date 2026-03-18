---
name: rust
description: >
  Load when writing, reviewing, or debugging Rust code — services, CLI tools,
  async code with Tokio, or systems programming. Covers the patterns Claude
  consistently gets wrong in production Rust: unnecessary clones, error handling
  with thiserror/anyhow, async pitfalls, and lifetime over-engineering.
  Do not load for Python, Go, or other languages.
---

# Rust: What Claude Gets Wrong in Production Code

This skill is not a Rust tutorial. It covers the specific patterns that tend to be
wrong or suboptimal in AI-generated Rust. Read this before writing or reviewing
any Rust in this project.

---

## Error Handling: thiserror for Libraries, anyhow for Applications

Generated Rust code often uses `Box<dyn Error>` or bare `String` errors. Use the
right tool for the context:

```rust
// WRONG — Box<dyn Error> loses type information, can't match on error variants
fn get_user(id: Uuid) -> Result<User, Box<dyn std::error::Error>> { ... }

// RIGHT for library/domain code — thiserror generates std::error::Error impls
use thiserror::Error;

#[derive(Debug, Error)]
pub enum UserError {
    #[error("user {0} not found")]
    NotFound(Uuid),

    #[error("email {email} already exists")]
    EmailConflict { email: String },

    #[error("database error: {0}")]
    Database(#[from] sqlx::Error),  // #[from] enables ? operator conversion
}

fn get_user(id: Uuid) -> Result<User, UserError> { ... }

// RIGHT for application/binary code — anyhow gives you context() and ensure!()
use anyhow::{Context, Result};

fn run() -> Result<()> {
    let config = load_config()
        .context("failed to load configuration")?;  // adds context to any error
    
    let user = get_user(config.admin_id)
        .with_context(|| format!("failed to get admin user {}", config.admin_id))?;
    
    Ok(())
}
```

Use `?` with `.context()` (anyhow) or `#[from]` (thiserror) — never `.unwrap()` in
production code paths. `.unwrap()` is acceptable only in:
- `main()` for truly unrecoverable startup failures
- Test code
- Cases where you've documented the invariant that makes it safe

---

## Clones: Earn Every Clone

The most common performance mistake in generated Rust is unnecessary `.clone()` calls
added to satisfy the borrow checker instead of rethinking ownership.

```rust
// WRONG — cloning to avoid thinking about lifetimes
fn process_name(user: &User) -> String {
    let name = user.name.clone();  // why? we only read it
    format!("Hello, {}", name)
}

// RIGHT — borrow the string slice directly
fn process_name(user: &User) -> String {
    format!("Hello, {}", user.name)  // name is borrowed, no clone needed
}

// WRONG — cloning inside a loop (allocates on every iteration)
for item in &items {
    let id = item.id.clone();
    process(id);
}

// RIGHT — pass a reference
for item in &items {
    process(&item.id);
}

// Clone IS appropriate when:
// 1. You need ownership and can't borrow (e.g., passing to a thread)
// 2. The type is Copy-equivalent and Clone is trivial (small structs)
// 3. You've profiled and determined it's not a bottleneck
```

When the borrow checker pushes back, the right response is usually to rethink
the ownership model, not to `.clone()`. Ask: who should own this data?

---

## Async: Tokio Patterns and Pitfalls

```rust
// WRONG — blocking operation inside async function blocks the executor thread
async fn get_file_contents(path: &str) -> Result<String> {
    std::fs::read_to_string(path)?  // sync I/O blocks the async runtime
}

// RIGHT — use tokio's async I/O
async fn get_file_contents(path: &str) -> Result<String> {
    tokio::fs::read_to_string(path).await?
}

// WRONG — CPU-intensive work blocks the executor
async fn hash_password(password: &str) -> Result<String> {
    bcrypt::hash(password, 10)?  // blocks for 100ms+ — starves other tasks
}

// RIGHT — offload blocking work to a thread pool
async fn hash_password(password: &str) -> Result<String> {
    let password = password.to_owned();
    tokio::task::spawn_blocking(move || bcrypt::hash(password, 10))
        .await
        .context("spawn_blocking panicked")?
        .context("bcrypt failed")
}

// WRONG — holding a mutex guard across an await point deadlocks
async fn update_cache(cache: &Mutex<HashMap<String, String>>, key: String, val: String) {
    let mut map = cache.lock().unwrap();
    expensive_async_operation().await;  // deadlock: holding mutex while yielding
    map.insert(key, val);
}

// RIGHT — release the lock before awaiting, or use tokio::sync::Mutex
async fn update_cache(cache: &tokio::sync::Mutex<HashMap<String, String>>, key: String, val: String) {
    let result = expensive_async_operation().await;
    let mut map = cache.lock().await;
    map.insert(key, result);
}
```

---

## Lifetimes: Don't Over-Engineer Them

Generated Rust often introduces explicit lifetime annotations where they aren't needed,
or uses them to work around a design problem that should be solved differently.

```rust
// OVER-ENGINEERED — unnecessary lifetime annotation
fn first_word<'a>(s: &'a str) -> &'a str {
    // 'a is inferred by lifetime elision rules — don't write it explicitly
}

// CORRECT — let the compiler infer it
fn first_word(s: &str) -> &str {
    s.split_whitespace().next().unwrap_or("")
}

// SIGNAL: if you're fighting lifetimes on a struct, consider owning the data
// instead of borrowing it. Owned data is simpler; borrow when performance demands it.

// FIGHTING LIFETIMES:
struct Parser<'a> {
    input: &'a str,        // borrowed — now the struct's lifetime is coupled to the input
    current: &'a str,
}

// OFTEN SIMPLER — own the data
struct Parser {
    input: String,         // owned — struct is self-contained
    position: usize,
}
```

The rule: use references (borrows) when you've established that ownership is elsewhere
and performance matters. Default to owned data until profiling says otherwise.

---

## Iterators: Prefer Chains Over Loops

Rust's iterator chains are not just idiomatic — they're often faster (the compiler
can optimize chains that explicit loops cannot) and always more readable.

```rust
// IMPERATIVE — mutable accumulator, hard to see intent
let mut result = Vec::new();
for user in &users {
    if user.is_active {
        result.push(user.email.clone());
    }
}

// IDIOMATIC — intent is clear, no mutation
let result: Vec<&str> = users.iter()
    .filter(|u| u.is_active)
    .map(|u| u.email.as_str())
    .collect();

// IMPERATIVE — error handling in a loop
let mut parsed = Vec::new();
for s in &strings {
    parsed.push(s.parse::<i32>()?);
}

// IDIOMATIC — collect into Result<Vec<_>>
let parsed: Result<Vec<i32>, _> = strings.iter()
    .map(|s| s.parse::<i32>())
    .collect();
```

---

## Struct Design: Builder Pattern for Complex Construction

When a struct has more than 3-4 fields or optional fields, use the builder pattern.
Don't add a dozen optional fields to `new()`.

```rust
// UNWIELDY — positional args, optional fields as Option
let config = ServerConfig::new(
    "0.0.0.0".to_string(),
    8080,
    Some(30),
    None,
    Some(true),
    None,
    // ... what do these mean?
);

// IDIOMATIC — builder pattern, self-documenting
let config = ServerConfig::builder()
    .host("0.0.0.0")
    .port(8080)
    .timeout_secs(30)
    .tls_enabled(true)
    .build()?;
```

Use the `bon` or `derive_builder` crate rather than hand-rolling builders.

---

## Common Clippy Lints to Know

These lints catch common mistakes — run `cargo clippy` and treat warnings as errors
in CI (`cargo clippy -- -D warnings`):

- `clippy::unwrap_used` — use `?` or explicit error handling instead
- `clippy::expect_used` — same (`.expect("reason")` is okay in tests)
- `clippy::clone_on_ref_ptr` — cloning an Arc/Rc when a borrow would suffice
- `clippy::large_futures` — large async futures that should be boxed
- `clippy::unused_async` — async fn that doesn't actually await anything

Add to `Cargo.toml` for consistent enforcement:
```toml
[lints.clippy]
unwrap_used = "warn"
pedantic = "warn"
```
