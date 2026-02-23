# Prototyping from Image — CLAUDE.md
# Version 1.0 | Cookbook-SME-Robotics | Cross-Team

---

## 1. Role & Context

This is a **cross-team workflow** available to all staff — technical and non-technical.

**When to use this folder:** Any time you have a visual (mockup, sketch, photo of whiteboard, Figma screenshot, hand-drawn diagram) and want a working prototype or code immediately.

**Who uses this:** Product Designers, Robotics Engineers, Marketing (for landing page mockups), Management (for dashboard ideas).

**What "prototyping from image" means:**  
You paste a screenshot or image → Claude reads the visual → Claude generates a working implementation. No description needed beyond the image itself.

---

## 2. How to Paste an Image

**Mac:** `Command+V` to paste a screenshot directly into Claude Code.  
**Alternative:** Drag an image file into the Claude Code window.  
**Tip:** Screenshots of Figma frames work best. Annotate the image with text labels if anything is ambiguous.

---

## 3. Audience Instructions

- **Non-technical staff:** You only need to paste the image and say what kind of output you want ("make this a webpage", "make this a form", "make this a dashboard").
- **Technical staff:** You can add constraints in the prompt ("use Next.js", "use rclpy", "add dark mode").
- Claude will ask clarifying questions if the image is ambiguous — answer in plain English.

---

## 4. Primary Workflows

### Workflow A: Screen/UI Mockup → Working HTML Page

**When to use:** For any visual webpage or dashboard mockup.

```
Step 1: Paste image (Command+V)
Step 2: Say: "Turn this mockup into a working HTML page"
Step 3: Claude identifies: layout, colors, fonts, interactive elements
Step 4: Claude generates: single-file HTML + CSS + JS prototype
Step 5: Open the .html file in Chrome to verify visually
Step 6: Iterate: "Make the button blue" / "Add a sidebar" etc.
Step 7: Once approved, hand off to web-dev team for Next.js implementation
```

### Workflow B: System Diagram → ROS2 Node (Robotics Team)

**When to use:** Whiteboard node graph, system architecture photo.

```
Step 1: Paste diagram image
Step 2: Say: "Generate a ROS2 Python node from this diagram"
Step 3: Claude identifies: node names, topics, message types, logic
Step 4: Claude generates: complete rclpy Python node using canonical template
Step 5: Verify against sample_mockup.txt in technical/robotics/ for reference
Step 6: Move to technical/robotics/ folder for build and test
```

### Workflow C: Hand-Drawn Sketch → Product Spec

**When to use:** Turning whiteboard brainstorm into a structured spec for engineering.

```
Step 1: Photograph the whiteboard or sketch
Step 2: Say: "Convert this sketch into a product spec"
Step 3: Claude outputs a structured Markdown spec:
   - Feature description
   - User stories
   - Acceptance criteria
   - Components required
   - Open questions
Step 4: Review and share with the relevant team
```

### Workflow D: Screenshot → Functional Prototype (Rapid Accessibility Tool)

**When to use:** For legal/accessibility team building communication aids, quick internal tools.

```
Step 1: Show Claude a screenshot of an existing tool's gap
Step 2: Say: "Build a prototype that fills this gap"
Step 3: Claude generates a working HTML + JS prototype, one step at a time
Step 4: Test in browser before sharing with domain experts
```

---

## 5. Output Schema & Validation

**For HTML prototypes:**
- [ ] Opens and renders correctly in Chrome without errors
- [ ] All interactive elements (buttons, inputs) are functional
- [ ] Matches the color palette and layout of the source image
- [ ] Saved as `prototype_[description]_YYYY-MM-DD.html`

**For ROS2 nodes:** Follow validation checklist in `technical/robotics/CLAUDE.md`

**For product specs:**
- [ ] Every feature has at least one user story
- [ ] Every user story has acceptance criteria
- [ ] Open questions are listed explicitly

---

## 6. Safety & Forbidden Actions

1. **Prototypes are for review only.** Never deploy a prototype directly to production.
2. **No real data in prototypes.** Use placeholder text and sample images.
3. **Git checkpoint before iterating** on an existing prototype: `git add -A && git commit -m "checkpoint"`
4. **Hand off to the relevant team** for production implementation — don't build on top of a prototype indefinitely.

---

## 7. Custom Slash Commands

| Command | What it does |
|---|---|
| `/prototype-ui` | Run Workflow A — UI mockup to HTML |
| `/prototype-ros [paste image]` | Run Workflow B — diagram to ROS2 node |
| `/prototype-spec [paste image]` | Run Workflow C — sketch to product spec |

---

## 8. Session-End Ritual

At the end of every session:
> *"Summarize what prototype we built and suggest 3 improvements to this CLAUDE.md."*

Log to root `CHANGELOG.md`: `YYYY-MM-DD | Prototyping | [What was built]`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Initial creation: UI, ROS2, spec, and accessibility prototype workflows per Anthropic Product Design team patterns | Setup |
