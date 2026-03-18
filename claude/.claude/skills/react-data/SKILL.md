---
name: react-data
description: >
  Load when writing, reviewing, or debugging React/TypeScript code — components,
  hooks, data fetching with TanStack Query, forms, and state management. Covers the
  patterns Claude consistently gets wrong: useEffect for data fetching, missing
  loading/error states, Zod schema mismatches, and TypeScript anti-patterns.
---

# React + TypeScript: What Claude Gets Wrong in Production Code

This skill covers React with TypeScript, TanStack Query v5, and Zod. If the project
uses a different data fetching library, note the differences.

---

## Data Fetching: TanStack Query, Not `useEffect`

`useEffect` for data fetching causes race conditions, missing loading/error handling,
no caching, and double-fetching in Strict Mode. Use TanStack Query.

```typescript
// WRONG — manual fetch in useEffect
const [orders, setOrders] = useState<Order[]>([]);
const [loading, setLoading] = useState(false);

useEffect(() => {
  setLoading(true);
  fetch("/api/v1/orders")
    .then(res => res.json())
    .then(data => setOrders(data))  // race condition: stale response arrives after newer one
    .finally(() => setLoading(false));
}, []);

// RIGHT — TanStack Query handles caching, deduplication, background refetch, errors
import { useQuery } from "@tanstack/react-query";

function useOrders() {
  return useQuery({
    queryKey: ["orders"],
    queryFn: () => api.get<Order[]>("/api/v1/orders"),
  });
}

function OrderList() {
  const { data: orders, isLoading, isError, error } = useOrders();

  if (isLoading) return <Spinner />;
  if (isError) return <ErrorMessage error={error} />;

  return <ul>{orders.map(o => <OrderItem key={o.id} order={o} />)}</ul>;
}
```

---

## Query Keys: Structured, Not Flat Strings

Query keys determine cache identity. Structured keys let you invalidate precisely.

```typescript
// WRONG — flat string keys can collide, can't invalidate subsets
useQuery({ queryKey: ["orders"] })
useQuery({ queryKey: ["user-orders"] })

// RIGHT — hierarchical keys; invalidate by prefix
// Convention: [entity, scope, params]
useQuery({ queryKey: ["orders", "list"] })
useQuery({ queryKey: ["orders", "detail", orderId] })
useQuery({ queryKey: ["orders", "list", { status: "pending" }] })

// Invalidate all order queries after a mutation
queryClient.invalidateQueries({ queryKey: ["orders"] })

// Invalidate only the detail
queryClient.invalidateQueries({ queryKey: ["orders", "detail", orderId] })
```

Store query key factories in a dedicated file:
```typescript
export const orderKeys = {
  all: ["orders"] as const,
  lists: () => [...orderKeys.all, "list"] as const,
  detail: (id: string) => [...orderKeys.all, "detail", id] as const,
};
```

---

## Mutations: Optimistic Updates Done Right

```typescript
// WRONG — refetches after every mutation (slow, flickers)
const mutation = useMutation({
  mutationFn: (id: string) => api.delete(`/orders/${id}`),
  onSuccess: () => queryClient.refetchQueries({ queryKey: orderKeys.lists() }),
});

// RIGHT — optimistic update + rollback on error
const mutation = useMutation({
  mutationFn: (id: string) => api.delete(`/orders/${id}`),
  onMutate: async (id) => {
    await queryClient.cancelQueries({ queryKey: orderKeys.lists() });
    const previous = queryClient.getQueryData(orderKeys.lists());
    queryClient.setQueryData(orderKeys.lists(), (old: Order[]) =>
      old.filter(o => o.id !== id)
    );
    return { previous };  // context for rollback
  },
  onError: (_err, _id, context) => {
    queryClient.setQueryData(orderKeys.lists(), context?.previous);
  },
  onSettled: () => {
    queryClient.invalidateQueries({ queryKey: orderKeys.lists() });
  },
});
```

---

## TypeScript: Types From Zod Schemas, Not Parallel Definitions

Don't define a TypeScript type and a Zod schema separately — they drift.
Generate the type from the schema.

```typescript
// WRONG — two sources of truth that will diverge
interface Order {
  id: string;
  total: number;
  status: "pending" | "confirmed" | "shipped";
}

const OrderSchema = z.object({
  id: z.string().uuid(),
  total: z.number(),
  status: z.enum(["pending", "confirmed", "shipped"]),
});

// RIGHT — one schema, type is derived
const OrderSchema = z.object({
  id: z.string().uuid(),
  total: z.number(),
  status: z.enum(["pending", "confirmed", "shipped"]),
  created_at: z.string().datetime(),
});

type Order = z.infer<typeof OrderSchema>;  // derived — always in sync

// Parse API responses at the boundary
async function fetchOrder(id: string): Promise<Order> {
  const res = await fetch(`/api/v1/orders/${id}`);
  const data = await res.json();
  return OrderSchema.parse(data);  // throws ZodError if shape doesn't match
}
```

---

## TypeScript Anti-Patterns

```typescript
// WRONG — `any` defeats the type system entirely
function processData(data: any) {
  return data.items.map((item: any) => item.id);
}

// WRONG — type assertion without validation
const order = apiResponse as Order;  // no guarantee it actually is an Order

// RIGHT — unknown at boundaries, narrow with guards or Zod
function processData(data: unknown) {
  const parsed = OrderListSchema.parse(data);  // throws if invalid
  return parsed.items.map(item => item.id);
}

// WRONG — non-null assertion on potentially null values
const name = user!.profile!.name;  // crashes if either is null

// RIGHT — optional chaining + fallback
const name = user?.profile?.name ?? "Unknown";
```

---

## Component Patterns: Avoid Prop Drilling

```typescript
// WRONG — threading props 3+ levels deep
<Page user={user}>
  <Layout user={user}>
    <Sidebar user={user}>
      <UserAvatar user={user} />

// RIGHT — use context for cross-cutting concerns, or colocate data fetching
function UserAvatar() {
  const { data: user } = useCurrentUser();  // fetch directly where needed
  return <img src={user?.avatarUrl} />;
}

// For shared UI state (modal open, theme, etc.) — context is appropriate
const ModalContext = createContext<ModalContextValue | null>(null);
```

---

## Common Gotchas

**Stale closures in `useEffect`:** Always include all values used inside `useEffect`
in the dependency array. If a value changes but isn't in the array, the effect uses
the stale captured value.

```typescript
// WRONG — userId changes but effect doesn't re-run
useEffect(() => {
  fetchOrders(userId);  // stale userId if not in deps
}, []);  // missing userId

// RIGHT
useEffect(() => {
  fetchOrders(userId);
}, [userId]);
```

**`key` prop on lists:** React uses `key` to identify elements across renders.
Never use array index as key — it causes incorrect reconciliation when items reorder.
Use a stable, unique ID (database ID, UUID).

**`useCallback`/`useMemo` overuse:** Don't wrap everything. Only memoize when
a value is used as a dependency of another hook, or when rendering is measurably
slow. Premature memoization adds complexity with no benefit.
