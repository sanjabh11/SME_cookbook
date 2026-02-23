# Cowork Hybrid Workflows — CLAUDE.md
# Cowork Integration (Jan 2026) | Non-Technical Teams
# For staff who prefer Slack/Google Chat and cannot access Antigravity

---

## 1. What Is Cowork for Claude Code?

**Cowork** (Jan 2026) is Anthropic's integration that lets non-technical users interact with Claude Code directly from Slack or Google Chat — without needing to open Antigravity at all.

**When to use Cowork (not Antigravity):**
- You are a non-technical user who finds IDEs overwhelming
- You need a quick result (ad copy review, report summary, data lookup)
- You are on mobile and need a fast answer

**When to use Antigravity + Claude Code instead:**
- You need Claude to read or write files
- You need to run a multi-step workflow from your CLAUDE.md
- You need the slot-machine pattern or sub-agents

---

## 2. Audience Instructions

- Use plain English only. No technical setup required.
- Cowork prompts are limited to text — you cannot paste images in Cowork.
- For image-based workflows (e.g., mockup-to-code), use `cross-team/prototyping-from-image/` in Antigravity.

---

## 3. Cowork Workflow Templates

### Template A: Quick Ad Copy Review (Marketing via Slack)

**In Slack, message the Claude bot:**
```
@Claude Review this ad headline: "Precision ROS2 controllers — built for scale"
Check: under 30 characters? Benefit-driven? No competitor names?
```

**Expected reply:** Pass/fail with suggested alternative if needed.

### Template B: Quick Sales Question (Finance via Slack)

```
@Claude Our Q1 revenue was ₹12,45,000. Q4 last year was ₹10,80,000. 
Calculate quarter-over-quarter growth percentage. Round to 2 decimal places.
```

**Expected reply:** Calculation + plain English explanation.

### Template C: Compliance Quick Check (Legal via Slack)

```
@Claude Does this sentence comply with WCAG 2.1 plain language requirement?
"The aforementioned provisions shall be construed in accordance with applicable statutory frameworks."
```

**Expected reply:** Plain English verdict + simplified rewrite.

### Template D: Escalate to Full Workflow

If the Cowork answer isn't enough, ask:
```
@Claude I need the full workflow. What should I open in Antigravity?
```

Claude will direct you to the correct folder and CLAUDE.md.

---

## 4. Safety Rules for Cowork

1. **Never share real financial data, customer names, or employee details** in Slack/Chat prompts (even in private channels — always treat as non-confidential).
2. **Cowork responses are not audited** at the same level as Antigravity sessions. For compliance-relevant outputs, always use Antigravity + MCP.
3. **Cowork cannot run the Session-End Ritual** — do this manually in Antigravity at the end of the day.

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Cowork hybrid CLAUDE.md created with plain-English templates for Slack/Chat integrations | Setup |
