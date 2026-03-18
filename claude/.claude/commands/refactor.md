---
name: refactor
description: >
  Safely refactor a file or function — extract service logic, split large functions,
  rename for clarity, improve types, or fix layering violations. Always runs tests
  before and after. Shows a plan before modifying anything.
  Usage: /refactor <file or description of what to improve>
  Example: /refactor backend/app/api/v1/endpoints/orders.py — the create handler has too much logic
  Example: /refactor the process_report function in report_service.py is 120 lines, split it up
  Example: /refactor rename UserPrefs to UserPreferences everywhere in the codebase
  Example: /refactor the order views are making direct DB calls, move them to the service layer
disable-model-invocation: true
---

Refactor: $ARGUMENTS

## Instructions

Delegate to the **refactorer** subagent with the refactoring target: "$ARGUMENTS"

Tell the refactorer to:
1. Read the target file AND find its existing tests before touching anything
2. If the code to be refactored has no test coverage, flag this and recommend adding tests first rather than refactoring blind
3. Run the relevant tests before making any changes and record the number of passing tests
4. Show a clear plan describing: what's wrong, what will change, what won't change, and which files are affected — wait for confirmation
5. Make changes incrementally: create new code, update callers, run tests, then remove old code
6. Run the tests again after the refactor — the same number must pass
7. For renames: use grep to find every reference before renaming, including in tests and any frontend code that imports from the backend

The refactorer must not change behavior — only structure. If it encounters something that looks like a bug, it should note it separately rather than fixing it as part of the refactor.
