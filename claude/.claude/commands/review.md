---
name: review
description: >
  Review code for correctness, security, architecture, test coverage, and project
  conventions. Pass a PR number, branch name, file path, or nothing (reviews staged
  changes). Produces a structured report with severity-rated findings.
  Usage: /review [pr:<number> | branch:<name> | <file-path>]
  Example: /review pr:42
  Example: /review branch:feature/add-comments
  Example: /review app/api/v1/endpoints/orders.py
  Example: /review (reviews git staged changes)
disable-model-invocation: true
---

Review the following: $ARGUMENTS

## Instructions

Delegate to the **code-reviewer** subagent.

Tell the reviewer:
- If a PR number was given (e.g. `pr:42`): run `gh pr diff 42` and `gh pr view 42`
- If a branch was given (e.g. `branch:feature/add-comments`): run `git diff main...feature/add-comments`
- If a file path was given: read that file directly
- If nothing was given: run `git diff --staged`

The reviewer must work through all six dimensions in order:
1. Architecture and layering (business logic in handlers?)
2. Security (walk the security-checklist skill systematically)
3. Language-specific patterns (load the appropriate language skill first)
4. Test coverage (happy path, 401, 403/404, validation for every new endpoint)
5. Error handling (no silent catches, correct exception types)
6. API contract (correct status codes, response shapes, pagination)

Every finding must include: severity (CRITICAL/HIGH/MEDIUM/LOW), file and line number,
what the problem is, and a concrete suggested fix.

The review ends with a verdict: APPROVE / REQUEST CHANGES / NEEDS DISCUSSION.
A CRITICAL or HIGH finding always results in REQUEST CHANGES.
