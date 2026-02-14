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
---

Generate a changelog entry from git history and output App Store release notes.

## Instructions

1. **Get the current version:**
   - Read `app.json` → `expo.version`
   - Fallback: read `package.json` → `version`
   - Replace `[Project Name]` with the app name from `expo.name` if found in CHANGELOG.md header

2. **Find the last documented version:**
   - Read `CHANGELOG.md` and find the most recent `## vX.Y` entry
   - If the current version already has an entry, tell the user and ask if they want to update it

3. **Gather commits since last release:**
   - Run `git log --oneline --format="%h %ad %s" --date=short` from the last release to HEAD
   - Use commit history and dates in CHANGELOG.md to determine the boundary

4. **Categorize commits into:**
   - **Features & Improvements** — new functionality, UX changes, copy updates
   - **Bug Fixes** — fixes to existing behavior
   - **Infrastructure** — build config, tooling, CI, dependencies, docs

5. **Write the entry** at the TOP of the changelog (below the header) using this format:

```markdown
## vX.Y — YYYY-MM-DD

### Features & Improvements
- Description of change

### Bug Fixes
- Description of fix

### Infrastructure
- Description of infra change
```

Omit empty category sections. Use today's date unless the user specifies otherwise.

6. **Output App Store "What's New" text** — plain text, no markdown, suitable for copy-paste into App Store Connect. Keep it concise and user-facing (omit infrastructure items). Example:

```
What's New in v1.1:

• Feature one
• Feature two
• Bug fix description
```

## User Input

$ARGUMENTS

If the user provides a version number, use that instead of the one in app.json. If they provide additional notes, incorporate them into the release notes.
