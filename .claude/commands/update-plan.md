---
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash(git log:*)
---

Maintain PLAN.md with project roadmap and completed work tracking.

## Instructions

1. **Read the current plan** from `PLAN.md`

2. **Check git history for completed work:**
   - Run `git log --oneline -30` to see recent commits
   - Cross-reference with items in "In Progress" and "Planned" sections
   - Move completed items to the "Completed" section with the date

3. **Update `PLAN.md`** following this structure:

```markdown
# [Project Name] — Roadmap

## Completed
- [x] Item description — YYYY-MM-DD

## In Progress
- [ ] Item description

## Planned
- [ ] Item description

## Ideas
- Item description (not committed, exploring)
```

4. **Rules:**
   - Move items from "Planned" → "In Progress" → "Completed" based on git evidence
   - Add completion dates when moving to "Completed"
   - Only add NEW planned items if the user explicitly requests it
   - Keep descriptions concise but specific enough to be actionable
   - Preserve the user's original wording when moving items between sections

5. **If `$ARGUMENTS` contains new items to plan:**
   - Add them to the appropriate section ("Planned" by default, "Ideas" if speculative)
   - Ask the user to confirm placement if ambiguous

## User Input

$ARGUMENTS

If the user provides specific items, add them. If no arguments, scan git history and update status of existing items.
