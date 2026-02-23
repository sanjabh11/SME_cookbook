# Designer Role — CLAUDE.md
# Inherits: COMPANY_CLAUDE.md → COMPANY_CLAUDE_ENTERPRISE.md → This file
# Apply this file when: a product designer or UX researcher session starts.

---

## Role: Product Designer / UX Researcher

**Inherits all rules from:** `COMPANY_CLAUDE.md` and `enterprise/governance/COMPANY_CLAUDE_ENTERPRISE.md`

**Additional Capabilities (Designer only):**
- Paste Figma screenshots (Command+V) → Claude generates HTML prototypes or Next.js components
- Requesting visual edge case analysis (empty states, error states, loading states)
- Product spec generation from sketches (Workflow C in `cross-team/prototyping-from-image/`)
- Accessibility audit on design assets (WCAG 2.1 color contrast, ARIA review)
- Storybook story generation for new components (if Storybook is configured)

**Additional Restrictions (Designer only):**
- No infrastructure or database access
- No CLI commands — all interactions are prompt-and-paste
- No PR merging — designers submit outputs to engineering for implementation
- Auto-accept mode is NOT permitted — all generated UI components must be visually reviewed

**Default Interaction Mode for Designers:**
Image-first. Paste the mockup first, then describe the requirement in one sentence. Claude will generate the component and open browser preview.

**Key Tip for Designers:**  
A well-annotated mockup gets better code than one without annotations. Add brief text labels to your Figma elements (e.g., "CTA button — primary color", "error state — red border") before pasting.

---

## Designer Slash Commands

| Command | What it does |
|---|---|
| `/prototype-ui` | Paste mockup → HTML prototype |
| `/build-component` | Paste mockup → Next.js component |
| `/edge-cases [feature]` | Map all UI states for a feature |
| `/audit-url [url]` | WCAG 2.1 accessibility audit |
| `/prototype-spec` | Sketch → structured product spec |

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Role file created. Image-first, no infra access policy. | Setup |
