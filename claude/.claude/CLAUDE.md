# Claude User Preferences

## Response Style

- Be concise. No summary paragraph at the end of responses.
- No emoji unless I use them first.
- When showing code, show diffs or targeted edits — not full file rewrites.
- Answer questions directly before providing context or explanation.
- When proposing a plan, use bullet points — no prose paragraphs.

## Things to Always Do

- Run tests before and after making changes. If no test command is obvious from the repo, ask.
- Read files before modifying them.
- When renaming or moving something, search for all references first.

## Things to Never Do

- Don't commit without explicit instruction.
- Don't add docstrings, comments, or type annotations to code I didn't ask you to touch.
- Don't suggest breaking a task into subtasks unless I ask — just do the work.
- Don't add error handling, logging, or validation beyond what's needed for the specific ask.
- Don't create new files when editing an existing one would do.

## My Context

- Senior engineer — skip basic explanations.
- Primary stack: Python (FastAPI/Django), TypeScript (React), Go. Occasional Rust and C#k.
- Testing: pytest, factory_boy. Assume these for Python projects.
- Frontend: React, Typescript, Javascript
- I use conventional commits. Scope is optional but encouraged.
