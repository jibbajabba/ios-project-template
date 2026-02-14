# [Project Name]

Expo React Native app (iOS-focused). Uses Expo Router for navigation.

## Development

```bash
npx expo start          # Start dev server
npx expo run:ios        # Run on iOS simulator
```

### Environment Variables

Stored in `.env` (gitignored). Copy `.env.example` to get started.

## Building

Uses EAS Build for TestFlight and production submissions.

```bash
eas build --profile development --platform ios    # Dev build
eas build --profile production --platform ios      # Production build
```

## Claude Code Commands

These slash commands maintain project documentation automatically:

| Command | What it does |
|---------|-------------|
| `/update-docs` | Runs all documentation updates in one pass |
| `/update-design-system` | Scans for design tokens, maintains `constants/design.ts` |
| `/update-changelog` | Generates changelog entry from git history, outputs App Store "What's New" text |
| `/update-readme` | Regenerates README from actual project config and file structure |
| `/update-memory` | Records patterns, decisions, and gotchas in `.claude/memory/MEMORY.md` |
| `/update-plan` | Tracks roadmap progress in `PLAN.md`, auto-marks completed items from git |

### Usage

- Run `/update-docs` before each release to refresh everything
- Run `/update-changelog` when preparing an App Store submission
- Run `/update-memory` after solving a tricky bug or making an architecture decision
- Run `/update-design-system check` for a read-only audit of design tokens
- Pass arguments to any command for targeted updates (e.g., `/update-docs just changelog and readme`)

### Project-Local Memory

`.claude/memory/MEMORY.md` is committed to the repo and shared across machines. It stores project-specific patterns, workarounds, and decisions that Claude should remember. This is separate from Claude's auto-memory (which is machine-specific and stored in `~/.claude/`).
