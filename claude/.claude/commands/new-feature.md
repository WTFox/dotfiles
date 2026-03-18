---
name: new-feature
description: >
  Scaffold a complete vertical slice for a new feature — model, migration, repository,
  service, schemas, endpoint, and tests. The agent reads existing patterns first so
  generated code fits the codebase. Always shows a plan before writing any files.
  Usage: /new-feature <description>
  Example: /new-feature add a comments system where users can leave comments on orders
  Example: /new-feature add user notification preferences with email/sms toggles per event type
  Example: /new-feature add an audit log that records every change to an order's status
disable-model-invocation: true
---

Scaffold a new feature: $ARGUMENTS

## Instructions

Delegate to the **feature-scaffolder** subagent with the feature description: "$ARGUMENTS"

Tell the scaffolder to:
1. Read at least one existing model, repository, service, endpoint, and test file before writing anything — the generated code must match the existing patterns precisely
2. Present a complete plan (files to create, files to modify, data model, endpoints, authorization rules) and wait for confirmation before writing
3. Generate all files in dependency order: model → migration → repository → schemas → service → endpoint → tests → router registration
4. Run the quality checklist on every generated file before finishing
5. End with the commands to apply the migration and run the new tests

The scaffolder must not skip the plan step — no files should be written without explicit confirmation.
