# Web Development — CLAUDE.md
# Version 1.0 | Cookbook-SME-Robotics

---

## 1. Role & Context

You are assisting the **Web Development team** at a 100-person robotics and web development SME.

**Team size:** ~12 engineers (technical)  
**Stack:** React, Next.js 14+, TypeScript, Tailwind CSS, Prisma, PostgreSQL, Vercel  
**Design workflow:** Designers produce Figma mockups → devs implement in Next.js

Our biggest bottleneck is the gap between design and implementation: static Figma exports require extensive re-explanation to translate into working code. We use Claude Code to paste mockup images directly and generate functional components immediately.

---

## 2. Audience Instructions

- Assume **TypeScript and React fluency.** Use modern React patterns (hooks, server/client components).
- All code must use **Next.js 14 App Router** conventions (not Pages Router).
- Default to **TypeScript** — no `any` types without justification.
- Prefer existing components and utilities in the codebase before creating new ones.
- Antigravity browser preview is the primary verification tool for UI changes.

---

## 3. Tools & Environment

| Tool | Purpose | Notes |
|---|---|---|
| `Next.js 14` | Full-stack framework | App Router, Server Components |
| `TypeScript` | Type safety | Strict mode enabled |
| `Tailwind CSS` | Styling | Use design tokens, not arbitrary values |
| `Prisma` | ORM | `npx prisma generate` after schema changes |
| `Vercel` | Deployment | `vercel --prod` for production deploy |
| `Antigravity` | Browser preview | Primary UI test tool |

**Dev commands:**
```bash
npm run dev          # Start local dev server (http://localhost:3000)
npm run build        # Production build (run before deploying)
npm run lint         # ESLint check
npx tsc --noEmit    # TypeScript check
npm test             # Jest tests
```

**MCP Boundaries:**
- ✅ Allowed: Read/write local files, GitHub API, Vercel API
- ❌ Forbidden: Access production database directly — use Prisma through the app
- ❌ Forbidden: Deploy to production without passing `npm run build` and `npm run lint`

---

## 4. Primary Workflows

### Workflow A: Figma Mockup → Next.js Component

**When to use:** When a designer provides a screenshot or Figma export.

```
Step 1: Paste the mockup image (Command+V) into Claude Code
Step 2: Claude identifies: layout structure, color palette, typography, interactive states
Step 3: Generate the Next.js component:
   - Use TypeScript with explicit Props interface
   - Use Tailwind for all styling (no inline styles)
   - Include: default state, hover state, disabled state, mobile responsive
   - Add ARIA labels for accessibility
Step 4: Generate a Storybook story for the component (if Storybook is configured)
Step 5: Open Antigravity browser preview to verify rendering
Step 6: Iterate on visual details until it matches the mockup
Step 7: git commit -m "feat: [component-name] from Figma mockup"
```

### Workflow B: Full Page Build (Mockup → Complete Next.js Page)

**When to use:** For full page designs with multiple components.

```
Step 1: Paste the full page mockup
Step 2: Decompose into components (header, hero, cards, footer, etc.)
Step 3: Build each component independently (Workflow A per component)
Step 4: Assemble into a page in app/[route]/page.tsx
Step 5: Wire up any data fetching (server component with fetch or Prisma)
Step 6: Run: npm run build && npm run lint
Step 7: Preview in Antigravity, verify mobile and desktop layouts
Step 8: git commit -m "feat: [page-name] page with all components"
```

### Workflow C: Edge Case Discovery

**When to use:** Before finalizing any new feature design.

```
Step 1: Describe the feature and its happy path
Step 2: Claude maps out all edge cases:
   - Empty states (no data, first-time user)
   - Error states (API failure, unauthorized, not found)
   - Loading states
   - Over-quota states
   - Mobile-only edge cases
Step 3: For each edge case, generate the corresponding UI state
Step 4: Output a Mermaid diagram of all states and transitions
Step 5: Review with designer before implementation
```

### Workflow D: State Management Change

**When to use:** When implementing complex client-side state.

```
Step 1: Describe what state is needed and what triggers transitions
Step 2: Claude generates the state logic using Zustand or React Context
Step 3: Walk through the implementation synchronously — monitor in real-time
Step 4: Generate tests for all state transitions
Step 5: Verify with Antigravity browser preview
```

---

## 5. Sub-Agent Architecture

For full page builds, spawn parallel component agents:

| Agent | Responsibility | Input | Output |
|---|---|---|---|
| **Component Agents (1 per component)** | Build single isolated component | Component mockup region | `.tsx` file |
| **Assembly Agent** | Combine components into page | All component files | `page.tsx` |
| **Test Agent** | Generate component tests | Each `.tsx` file | `.test.tsx` files |
| **Validator Agent** | Run build + lint + type check | All files | Pass/fail report |

---

## 6. Output Schema & Validation

**Component file structure:**
```tsx
// ComponentName.tsx
interface ComponentNameProps {
  // All props explicitly typed — no `any`
}

export function ComponentName({ prop1, prop2 }: ComponentNameProps) {
  // Component implementation
}
```

**Validation checklist (before delivery):**
- [ ] `npx tsc --noEmit` passes (no TypeScript errors)
- [ ] `npm run lint` passes (no ESLint errors)
- [ ] All interactive elements have ARIA labels
- [ ] Component is responsive (check at 375px, 768px, 1280px)
- [ ] All user-facing text is wrapped in translation function if i18n is configured
- [ ] Loading and error states are implemented

---

## 7. Safety & Forbidden Actions

1. **Git checkpoint first.** `git add -A && git commit -m "checkpoint"` before any auto-accept run.
2. **Never commit** with TypeScript errors or lint failures.
3. **Never deploy** without a successful `npm run build`.
4. **Synchronous mode** for: changes to `app/layout.tsx`, auth middleware, payment flows, and any file touching 5+ other components.
5. **Async / auto-accept mode** approved for: isolated new components, styling tweaks, test generation, documentation updates.
6. **Run `/security-review`** on all PRs touching auth, payments, or user data.

---

## 8. Custom Slash Commands

| Command | What it does |
|---|---|
| `/build-component [description or paste image]` | Run Workflow A |
| `/build-page [description or paste image]` | Run Workflow B |
| `/edge-cases [feature name]` | Run Workflow C — state map |
| `/state-management [description]` | Run Workflow D |
| `/validate` | Run tsc + lint + build check |
| `/security-review` | Run security checklist (see `cross-team/security-review/`) |

---

## 9. Session-End Ritual

At the end of every session, ask Claude:
> *"Summarize what we did and suggest 3 improvements to this CLAUDE.md."*

Then:
1. Add suggestions to `## Lessons Learned` below.
2. Log to root `CHANGELOG.md`: `YYYY-MM-DD | Web-Dev | [What changed]`
3. `git commit -m "session-end: web-dev [brief]"`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Initial creation: Figma-to-Next.js workflow, edge case discovery, component sub-agent pattern, TypeScript/lint validation gates | Setup |
