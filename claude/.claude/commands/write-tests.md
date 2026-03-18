---
name: write-tests
description: >
  Generate a comprehensive test suite for a file, class, function, or endpoint.
  Analyzes the target code to identify all test cases (happy path, edge cases,
  error conditions, auth cases) and generates tests following project conventions.
  Usage: /write-tests <file path or function name>
  Example: /write-tests backend/app/services/order_service.py
  Example: /write-tests backend/app/api/v1/endpoints/users.py
  Example: /write-tests OrderService.create
  Example: /write-tests the new comments endpoint I just wrote
disable-model-invocation: true
---

Write comprehensive tests for: $ARGUMENTS

## Instructions

Delegate to the **test-writer** subagent targeting: "$ARGUMENTS"

Tell the test-writer to:
1. Read the target file completely before identifying test cases — understand what it actually does, not what the name suggests
2. Determine the correct test layer for each case:
   - Pure business logic in services → unit tests in `tests/unit/` (mock all dependencies)
   - Repository queries → integration tests in `tests/integration/` (real test DB, rolled back after each test)
   - API endpoints → API tests in `tests/api/` (TestClient with dependency override)
3. For API endpoints specifically, always include: success case, 401 unauthenticated, 403/404 authorization failure, 422 validation failure
4. Use factory_boy factories for all test data — never hardcode IDs or emails
5. Name tests: `test_<what>_<when>_<expected>` (e.g. `test_create_order_with_out_of_stock_item_raises_insufficient_stock_error`)
6. After generating the test file, summarize: what's covered, what layer was chosen and why, and what's explicitly NOT covered here (and where it is covered)

The test-writer must write tests that would actually fail if the code broke — not tests that just call the code and assert it didn't raise.
