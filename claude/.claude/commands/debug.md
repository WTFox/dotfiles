---
name: debug
description: >
  Diagnose a bug, error, or unexpected behavior. Pass a traceback, error message,
  test failure output, or a description of what's wrong and what you expected instead.
  Usage: /debug <error or description>
  Example: /debug AttributeError: 'NoneType' object has no attribute 'id' in order_service.py line 58
  Example: /debug test_create_order is passing locally but failing in CI with IntegrityError
  Example: /debug GET /api/v1/orders returns 200 but the list is always empty even though orders exist
disable-model-invocation: true
---

Debug the following issue: $ARGUMENTS

## Instructions

Delegate to the **debugger** subagent with the full context: "$ARGUMENTS"

Tell the debugger:
- If a traceback was provided, start by reading the application-code frames bottom-up
- If a test failure was provided, run the specific test first: `pytest <test_path> -xvs`
- If a behavior description was provided, first clarify the reproduction steps, then trace from the endpoint inward
- Do not propose a fix until the root cause (the specific violated assumption) is identified
- After identifying the root cause, propose the minimal targeted fix and suggest what test would prevent regression

The debugger should produce a structured report: symptom → root cause → execution trace → fix → regression test.
