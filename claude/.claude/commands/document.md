---
name: document
description: >
  Write or improve documentation for a file, function, class, module, or endpoint.
  Produces docstrings, inline comments, README sections, or ADRs depending on what's
  needed. Explains the "why," not just the "what."
  Usage: /document <file-path | function-name | description>
  Example: /document app/services/order_service.py
  Example: /document the create_order function in order_service.py
  Example: /document README section for the authentication flow
  Example: /document ADR for why we chose cursor-based pagination
disable-model-invocation: true
---

Document the following: $ARGUMENTS

## Instructions

Delegate to the **docs-writer** subagent with the target: "$ARGUMENTS"

Tell the docs-writer:
- Read the target file or function completely before writing anything
- Match the documentation style already present in the file (Google docstrings, NumPy style, etc.)
- Prioritize explaining *why* over *what* — the code shows what; the docs explain the reasoning, constraints, and non-obvious decisions
- For functions/methods: document parameters, return values, exceptions raised, and any side effects
- For modules/files: document the purpose, what it owns, and how it fits into the architecture
- For API endpoints: document the full contract — auth requirements, possible status codes, request/response shapes
- For ADRs: use the standard format (Date, Status, Context, Decision, Reasoning, Consequences)
- Do not add comments that just restate the code — only document what isn't obvious from reading it
- Do not modify any logic — documentation only
