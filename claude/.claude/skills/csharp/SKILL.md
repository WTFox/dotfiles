---
name: csharp
description: >
  Load when writing, reviewing, or debugging C# code — ASP.NET Core APIs, background
  services, console apps, or libraries. Covers the patterns Claude consistently gets
  wrong in production C#: async/await pitfalls, nullable reference types, DI patterns,
  cancellation tokens, and LINQ vs. loops. Do not load for Python, Go, or Rust.
---

# C#: What Claude Gets Wrong in Production Code

This skill is not a C# tutorial. It covers the specific patterns that tend to be
wrong or dangerous in AI-generated C#. Read this before writing or reviewing any
C# in this project.

---

## Async/Await: The Deadlock Traps

Generated C# async code frequently causes deadlocks or degrades performance through
a handful of consistent mistakes.

```csharp
// WRONG — .Result and .Wait() block synchronously and deadlock in ASP.NET Core
public IActionResult GetUser(Guid id)
{
    var user = _userService.GetByIdAsync(id).Result;  // deadlock waiting to happen
    return Ok(user);
}

// RIGHT — make the action async
public async Task<IActionResult> GetUser(Guid id)
{
    var user = await _userService.GetByIdAsync(id);
    return Ok(user);
}

// WRONG — missing ConfigureAwait in library code
// (library code should not capture the synchronization context)
public async Task<User> GetByIdAsync(Guid id)
{
    var result = await _dbContext.Users.FindAsync(id);  // captures context
    return result ?? throw new NotFoundException(id);
}

// RIGHT — ConfigureAwait(false) in library/service code
// (omit it in ASP.NET controller actions and Blazor — they need the context)
public async Task<User> GetByIdAsync(Guid id)
{
    var result = await _dbContext.Users.FindAsync(id).ConfigureAwait(false);
    return result ?? throw new NotFoundException(id);
}

// WRONG — async void (exceptions are unobservable, crashes the process)
public async void OnButtonClick(object sender, EventArgs e)
{
    await DoSomethingAsync();
}

// RIGHT — async Task, and handle exceptions at the call site
public async Task HandleClickAsync()
{
    await DoSomethingAsync().ConfigureAwait(false);
}
// Exception: event handlers must be async void — wrap the body in try/catch
public async void OnButtonClick(object sender, EventArgs e)
{
    try { await HandleClickAsync(); }
    catch (Exception ex) { _logger.LogError(ex, "Click handler failed"); }
}
```

---

## CancellationToken: Thread It Through Everything

Every async method that does I/O should accept a `CancellationToken`. ASP.NET Core
passes one automatically to action methods via `HttpContext.RequestAborted` — use it.

```csharp
// WRONG — can't be cancelled; wastes resources if client disconnects
public async Task<IActionResult> GetOrders()
{
    var orders = await _orderService.ListAsync();
    return Ok(orders);
}

// RIGHT — propagate the token from request to data access
public async Task<IActionResult> GetOrders(CancellationToken cancellationToken)
{
    var orders = await _orderService.ListAsync(cancellationToken);
    return Ok(orders);
}

// In service layer
public async Task<List<Order>> ListAsync(CancellationToken ct = default)
{
    return await _dbContext.Orders
        .Where(o => o.IsActive)
        .ToListAsync(ct)          // EF Core passes ct to the database
        .ConfigureAwait(false);
}
```

The pattern: `CancellationToken ct = default` in all async methods so callers
that don't care about cancellation don't have to pass anything.

---

## Nullable Reference Types: Enable Them and Mean It

Nullable reference types (`#nullable enable`) are enabled project-wide in new .NET
projects. Never disable them, and don't paper over warnings with `!` (the null-forgiving
operator) without a comment explaining why it's safe.

```csharp
// WRONG — null-forgiving operator used to silence a real warning
var user = await _repo.GetByIdAsync(id);
return user!.Email;  // crashes at runtime if user is null

// RIGHT — handle the null case explicitly
var user = await _repo.GetByIdAsync(id)
    ?? throw new NotFoundException($"User {id} not found");
return user.Email;

// WRONG — nullable property with no initialization guard
public class Order
{
    public string CustomerName { get; set; }  // warning: uninitialized non-nullable
}

// RIGHT — initialize non-nullable properties
public class Order
{
    public required string CustomerName { get; init; }  // 'required' enforces initialization
    public string? Notes { get; init; }                  // nullable: explicitly optional
}
```

---

## Dependency Injection: Constructor Injection, IOptions for Config

```csharp
// WRONG — service locator pattern (hides dependencies, untestable)
public class OrderService
{
    public async Task<Order> CreateAsync(OrderRequest request)
    {
        var repo = ServiceLocator.Get<IOrderRepository>();  // hidden dependency
        var email = ServiceLocator.Get<IEmailService>();
        ...
    }
}

// RIGHT — constructor injection (dependencies visible, mockable in tests)
public class OrderService
{
    private readonly IOrderRepository _repo;
    private readonly IEmailService _emailService;
    private readonly ILogger<OrderService> _logger;

    public OrderService(
        IOrderRepository repo,
        IEmailService emailService,
        ILogger<OrderService> logger)
    {
        _repo = repo;
        _emailService = emailService;
        _logger = logger;
    }
}

// WRONG — reading config directly from environment or IConfiguration in services
public class SnowflakeService
{
    public SnowflakeService()
    {
        var account = Environment.GetEnvironmentVariable("SNOWFLAKE_ACCOUNT");
    }
}

// RIGHT — IOptions<T> pattern: typed, validated, injectable, testable
public class SnowflakeOptions
{
    public const string Section = "Snowflake";
    [Required] public string Account { get; init; } = "";
    [Required] public string Warehouse { get; init; } = "";
    public int StatementTimeoutSeconds { get; init; } = 300;
}

// Register in Program.cs:
builder.Services.AddOptions<SnowflakeOptions>()
    .BindConfiguration(SnowflakeOptions.Section)
    .ValidateDataAnnotations()       // validates [Required] at startup, not at first use
    .ValidateOnStart();

// Inject in service:
public class SnowflakeService
{
    private readonly SnowflakeOptions _options;
    public SnowflakeService(IOptions<SnowflakeOptions> options)
    {
        _options = options.Value;
    }
}
```

---

## Records vs. Classes: Use Records for Data

```csharp
// Use record for immutable data transfer objects, value objects, domain events
// Records get: structural equality, ToString, deconstruction, with-expressions
public record OrderCreated(Guid OrderId, Guid UserId, decimal Total, DateTime CreatedAt);

// Use class for entities with identity and mutable state
public class Order
{
    public Guid Id { get; private set; }
    public OrderStatus Status { get; private set; }

    public void Cancel()
    {
        if (Status == OrderStatus.Shipped)
            throw new InvalidOperationException("Cannot cancel a shipped order");
        Status = OrderStatus.Cancelled;
    }
}

// With-expression creates a modified copy (only on records)
var updated = original with { Status = OrderStatus.Confirmed };
```

---

## LINQ: Readable Over Clever

Prefer method syntax for most LINQ, query syntax for complex multi-table joins.
Don't chain 8 LINQ operators when a loop is clearer.

```csharp
// Fine — simple and readable
var activeOrders = orders
    .Where(o => o.IsActive && o.Total > 0)
    .OrderByDescending(o => o.CreatedAt)
    .Take(50)
    .Select(o => new OrderSummary(o.Id, o.Total, o.CreatedAt))
    .ToList();

// WRONG — materializing before filtering (loads all rows into memory)
var expensive = await _dbContext.Orders
    .ToListAsync()          // loads ALL orders from DB
    .ContinueWith(t => t.Result.Where(o => o.Total > 1000).ToList());

// RIGHT — filter in the database
var expensive = await _dbContext.Orders
    .Where(o => o.Total > 1000)
    .ToListAsync(ct);       // one SQL query with WHERE clause
```

**N+1 with EF Core** — the same problem as SQLAlchemy:
```csharp
// WRONG — fires one query per order to load the customer
var orders = await _dbContext.Orders.ToListAsync(ct);
foreach (var order in orders)
{
    Console.WriteLine(order.Customer.Name);  // lazy load on each iteration
}

// RIGHT — eager load with Include
var orders = await _dbContext.Orders
    .Include(o => o.Customer)
    .Include(o => o.Items).ThenInclude(i => i.Product)
    .ToListAsync(ct);
```

---

## Disposal: using Declarations Over using Statements

```csharp
// OLD STYLE — extra nesting
using (var connection = new SqlConnection(connectionString))
{
    await connection.OpenAsync(ct);
    // ...
}  // disposed here

// MODERN — disposed at end of enclosing scope, no extra nesting
using var connection = new SqlConnection(connectionString);
await connection.OpenAsync(ct);
// ... connection disposed when method returns

// IAsyncDisposable — use await using for async cleanup
await using var stream = new FileStream(path, FileMode.Open);
```

---

## Logging: Structured, Not Interpolated

```csharp
// WRONG — string interpolation defeats structured logging (no queryable fields)
_logger.LogInformation($"Order {orderId} created by user {userId} for ${total}");

// RIGHT — message template with named placeholders (logged as structured fields)
_logger.LogInformation(
    "Order {OrderId} created by {UserId} for {Total}",
    orderId, userId, total);

// WRONG — logging in a hot path without level check (ToString() called even if not logged)
_logger.LogDebug($"Processing item {item.ToDetailedString()}");

// RIGHT — expensive serialization only happens if debug is enabled
if (_logger.IsEnabled(LogLevel.Debug))
    _logger.LogDebug("Processing item {@Item}", item);
// OR use LoggerMessage.Define for high-performance logging in hot paths
```
