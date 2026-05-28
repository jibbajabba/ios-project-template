# [Project Name]

Expo React Native app (iOS-focused). Uses Expo Router for navigation. Written in **TypeScript** — all new files must use `.ts`/`.tsx` extensions and be fully typed. Do not use `any`; prefer explicit types and interfaces.

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

## Coding Principles

Behavioral guidelines to reduce common LLM coding mistakes. Based on Andrej Karpathy's recommendations.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify. Run `/simplify` for a structured post-implementation review pass.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
