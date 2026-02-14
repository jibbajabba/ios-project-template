---
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash(ls:*)
  - Bash(node -e:*)
---

Generate or update the project README from actual project configuration and file structure.

## Instructions

1. **Detect project configuration** by reading (skip any that don't exist):
   - `app.json` — app name, version, description, SDK version
   - `package.json` — dependencies, scripts
   - `eas.json` — build profiles
   - `.env.example` or `.env` — required environment variables
   - `CLAUDE.md` — existing dev instructions (don't duplicate, complement)

2. **Scan the file tree** to understand project structure:
   - `app/` or `src/` — main source directory
   - `components/` — component library
   - `constants/` — configuration and constants
   - `contexts/` — React contexts
   - `lib/` or `utils/` — utility functions
   - `assets/` — static assets
   - `patches/` — patch-package patches

3. **Generate/update `README.md`** with these sections (omit any that aren't applicable):

```markdown
# [Project Name]

Brief description from app.json or package.json.

## Features
- Key features (detected from code structure)

## Tech Stack
- Expo SDK XX, React Native, TypeScript
- (other notable dependencies)

## Prerequisites
- Node.js, Expo CLI, etc.

## Getting Started
1. Clone the repo
2. Install dependencies
3. Set up environment variables
4. Start development

## Project Structure
(actual directory tree)

## Development
(commands from package.json scripts)

## Build & Deploy
(EAS build commands from eas.json)

## Environment Variables
(from .env.example or detected in code)

## Troubleshooting
(common issues if any are documented)
```

4. **Rules:**
   - Use actual values from config files, not placeholders
   - Don't duplicate what's already in CLAUDE.md — reference it instead
   - Keep the README user-facing (setup, usage, contribution)
   - Preserve any custom sections the user has added

## User Input

$ARGUMENTS

If the user specifies particular sections, only update those. Otherwise, do a full README refresh.
