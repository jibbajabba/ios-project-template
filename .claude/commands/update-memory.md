---
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash(git log:*)
  - Bash(git diff:*)
  - Bash(ls:*)
---

Maintain the project-local memory file with patterns, decisions, and gotchas.

## Instructions

1. **Read the current memory file** at `.claude/memory/MEMORY.md`

2. **Scan for new information worth recording:**
   - Recent git history: `git log --oneline -20`
   - Patch files in `patches/` — any new workarounds
   - Config changes in `app.json`, `eas.json`, `package.json`
   - New or modified files in `constants/`, `lib/`, `contexts/`

3. **Update `.claude/memory/MEMORY.md`** following these rules:
   - **Add** new entries under the appropriate section
   - **Never remove** existing entries unless the user explicitly asks
   - **Update** entries if the information has changed (e.g., a bug was fixed, a workaround is no longer needed)
   - Keep entries concise — bullet points, not paragraphs

4. **Memory file sections:**

```markdown
# [Project Name] — Project Memory

## Architecture
- Key architectural decisions and patterns

## Build & Deploy
- Build commands, EAS config, deployment notes

## Known Issues & Workarounds
- Active bugs, patches, workarounds with context

## Key Patterns
- Reusable patterns, conventions, gotchas

## Dependencies
- Notable dependency choices and version constraints
```

5. **What belongs in memory:**
   - Patterns confirmed across multiple instances
   - Workarounds for bugs (with links/context)
   - Build/deploy gotchas
   - Architecture decisions and their rationale
   - Dependency constraints or version pins

6. **What does NOT belong:**
   - Session-specific context or in-progress work
   - Information already in CLAUDE.md
   - Speculative or unverified conclusions

## User Input

$ARGUMENTS

If the user describes a specific pattern or decision, add it directly. If they say "scan" or provide no arguments, do a full scan of recent changes.
