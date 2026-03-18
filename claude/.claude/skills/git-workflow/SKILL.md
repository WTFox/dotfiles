---
name: git-workflow
description: >
  Load when writing a commit message, creating a PR description, naming a branch,
  reviewing git history, or squashing commits. Also load when asked to summarize
  changes for a changelog or release note. Keeps commit history clean, semantic,
  and useful as a debugging artifact.
---

# Git Workflow Best Practices

## Commits: The Conventional Commits Standard

Every commit message follows this format:

```
<type>(<scope>): <short summary in imperative mood>

[optional body: what and why, not how]

[optional footer: breaking changes, issue refs]
```

**Types:**
- `feat` — a new feature (triggers a minor version bump)
- `fix` — a bug fix (triggers a patch bump)
- `refactor` — code change that neither fixes a bug nor adds a feature
- `test` — adding or updating tests only
- `docs` — documentation only
- `perf` — a performance improvement
- `chore` — build process, dependency update, tooling (no production code change)
- `ci` — CI/CD configuration changes

**Scope** (optional but highly recommended) — the module, feature, or layer affected:
- `feat(orders)`, `fix(auth)`, `refactor(user-repo)`, `test(snowflake)`, `chore(docker)`

**The summary line:**
- Imperative mood: "add validation" not "added validation" or "adds validation"
- No capital first letter: "add endpoint" not "Add endpoint"
- No period at end
- Max 72 characters — this is the hard limit for readability in `git log --oneline`

**The body** (use when the change isn't obvious from the summary):
- Explain *what* changed and *why*, not *how* (the code shows how)
- Wrap at 72 characters per line
- Leave a blank line between summary and body

**Examples — good commits:**

```
feat(orders): add paginated order history endpoint

Adds GET /api/v1/orders with limit/offset pagination.
Scoped to the authenticated user's orders only.

Closes #142
```

```
fix(auth): prevent 500 when JWT contains invalid user id

The get_current_user dependency called get_by_id_or_raise which
raised NotFoundError for deleted users. Changed to get_by_id and
return 401 if None, matching the expected auth failure behavior.
```

```
perf(snowflake): add clustering key filter to events query

The daily events query was doing a full table scan because the
WHERE clause only filtered on user_id (not the cluster key).
Added event_date filter so Snowflake can prune micro-partitions.
Reduces scan from ~2TB to ~40GB for typical date ranges.
```

```
chore(docker): pin postgres base image to 16.2-alpine
```

**Examples — bad commits (and why):**
```
fixed stuff                         ← no type, no scope, past tense, vague
WIP                                 ← never commit WIP to a shared branch
Update order service                ← no type, no scope, past tense
Added new feature for user orders with pagination and fixed the bug  ← two changes in one
```

---

## Branch Naming

```
<type>/<short-description>

feat/order-history-endpoint
fix/auth-invalid-user-500
refactor/user-repository-cleanup
chore/pin-docker-base-images
test/snowflake-integration-coverage
```

Rules:
- Lowercase and hyphens only — no underscores, no slashes except the type prefix
- Short but specific — `fix/auth-500` is fine; `fix/fix` is not
- One concern per branch — don't mix a feature and a refactor in the same branch

---

## Pull Request Descriptions

Every PR needs a description that answers three questions:
1. **What changed?** — a brief summary of the actual changes
2. **Why?** — the motivation (links to issue, customer report, performance data)
3. **How to test it?** — what a reviewer should do to verify the change

Template:

```markdown
## What changed
[1-3 sentence summary of the change. Assume the reader hasn't seen the issue or conversation.]

## Why
[Motivation. Link the issue: "Closes #142" or "Part of #99". Include data if it's a perf fix.]

## How to test
[Step-by-step instructions for the reviewer to verify the change locally or in staging.]
- [ ] `docker compose run backend pytest tests/api/test_orders.py -xvs`
- [ ] Hit `GET /api/v1/orders?limit=10` with a valid token and verify pagination works
- [ ] Verify an unauthenticated request returns 401

## Notes for reviewer
[Anything unusual about the implementation, tradeoffs made, or areas to pay extra attention to.]

## Screenshots (if UI change)
[Before/after screenshots or a recording.]
```

---

## Keeping History Clean

**Squash before merging** any branch with "WIP", "fix typo", "oops", or similar commits.
The squashed commit message should follow the conventional commit format above.

**Rebase, don't merge** to incorporate upstream changes on a feature branch:
```bash
git fetch origin
git rebase origin/main
```
This keeps the branch history linear and makes `git log --oneline` readable.

**Never force-push to main or shared branches.** Only force-push to your own
feature branch (`git push --force-with-lease` is safer than `--force` — it fails
if someone else pushed since your last fetch).

---

## Writing Good Commit Messages for AI-Assisted Changes

When Claude helps write code, the commit message should still reflect *your understanding*
of what changed and why — not just a paraphrase of Claude's explanation. Before committing:
1. Read the diff with `git diff --staged`
2. Make sure you understand every changed line
3. Write the commit message in your own words

This matters because commit messages are debugging artifacts. Six months from now,
`git blame` will show this commit on a line that's causing a bug. The message is the
only explanation of *why* the line was written that way.
