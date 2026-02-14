---
allowed-tools:
  - Read
  - Edit
  - Write
  - Glob
  - Grep
---

Scan the project for design tokens and maintain a consolidated design system document.

## Instructions

1. **Scan for design tokens** in these locations (skip any that don't exist):
   - `constants/` — colors, typography, spacing, shadows
   - `theme/` — theme definitions, dark/light mode
   - `styles/` — shared style files
   - `tailwind.config.*` — Tailwind/NativeWind config
   - `app.json` → splash/icon colors

2. **Catalog what you find:**
   - **Colors** — named colors, palettes, semantic tokens (primary, secondary, background, text, etc.)
   - **Typography** — font families, sizes, weights, line heights
   - **Spacing** — padding/margin scales, gap values
   - **Shadows & Elevation** — shadow definitions, elevation levels
   - **Gradients** — gradient definitions
   - **Component Patterns** — reusable style patterns (cards, buttons, inputs, etc.)
   - **Animation** — timing, easing, duration constants

3. **Create or update `constants/design.ts`** using section-divider comments:

```typescript
// ============================================================
// Design System — [Project Name]
// Auto-maintained by /update-design-system
// ============================================================

// --- Colors ---------------------------------------------------

// ... exported color constants

// --- Typography -----------------------------------------------

// ... exported typography constants

// --- Spacing --------------------------------------------------

// ... exported spacing constants
```

4. **If `$ARGUMENTS` contains "check" or "audit":**
   - Do NOT write any files
   - Instead, report what tokens exist, what's documented, and what's missing
   - Flag any inconsistencies (e.g., hardcoded colors in components that aren't in the design system)

5. **If design token files don't exist yet:**
   - Create `constants/design.ts` with empty section scaffolding
   - Tell the user what to populate

## User Input

$ARGUMENTS

If the user specifies particular categories (e.g., "just colors"), only scan and update those sections.
