---
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash(git log:*)
  - Bash(git tag:*)
  - Bash(git diff:*)
  - Bash(ls:*)
  - Bash(node -e:*)
---

Run all documentation updates in a single pass. This is the main orchestrator — it contains condensed versions of each standalone command's logic since Claude Code commands cannot invoke each other.

## Instructions

Read `$ARGUMENTS` first. If the user specifies particular docs (e.g., "just changelog and readme"), only run those sections. Otherwise, run all sections below in order.

### 1. Detect Project Info

- Read `app.json` → `expo.name`, `expo.version`
- Fallback: `package.json` → `name`, `version`
- This name/version is used throughout all sections below

### 2. Design System (`constants/design.ts`)

- Scan `constants/`, `theme/`, `styles/`, `tailwind.config.*` for design tokens
- Catalog colors, typography, spacing, shadows, gradients, component patterns
- Create or update `constants/design.ts` with section-divider comment style
- If no design token files exist, create empty scaffolding and note it for the user

### 3. Changelog (`CHANGELOG.md`)

- Find last documented version in CHANGELOG.md
- Run `git log --oneline --format="%h %ad %s" --date=short` since that version
- Categorize into Features & Improvements / Bug Fixes / Infrastructure
- Write new entry at top of CHANGELOG.md (below header)
- If current version already documented, skip unless user requests update

### 4. README (`README.md`)

- Read `app.json`, `package.json`, `eas.json` for project config
- Scan file tree for project structure
- Generate/update sections: header, features, tech stack, prerequisites, getting started, project structure, dev commands, build & deploy, environment variables
- Don't duplicate CLAUDE.md content — complement it

### 5. Memory (`.claude/memory/MEMORY.md`)

- Read current memory file
- Scan recent git history (`git log --oneline -20`), patches, config changes
- Add new patterns, decisions, gotchas under appropriate sections
- Never remove existing entries

### 6. Plan (`PLAN.md`)

- Read current plan
- Cross-reference `git log --oneline -30` with planned/in-progress items
- Move completed items with dates
- Don't add new planned items unless user explicitly requests

### After All Updates

Summarize what was updated and what was skipped (and why). If any section needs user input (e.g., empty design tokens, ambiguous plan items), list those as action items.

## User Input

$ARGUMENTS
