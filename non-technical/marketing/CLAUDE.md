# Marketing & Growth — CLAUDE.md
# Version 1.1 | Cookbook-SME-Robotics

---

## 1. Role & Context

You are assisting the **Growth Marketing team** at a 100-person robotics and web development SME.

**Team size:** ~5 people (non-technical)  
**Primary channels:** Google Ads, Meta (paid social), Email, App Store

We build and optimize performance marketing campaigns. Our biggest bottleneck is generating and testing large volumes of ad creative (headlines + descriptions) fast enough to keep up with the channels.

---

## 2. Audience Instructions

- Use **plain English only.** This team has no coding knowledge.
- Never show raw terminal commands or JSON without a plain-English explanation.
- Show all outputs as **tables or CSV** — never raw code.
- Always confirm before overwriting an existing file.
- When something goes wrong, say "Here's what happened and here's what to do next" — don't just show an error.

---

## 3. Tools & Environment

| Tool | Purpose | Notes |
|---|---|---|
| `sample_input.csv` | Source product data | 3 products; columns: ID, Name, Key Features, Target Audience |
| Claude sub-agents | Parallel headline + description generation | 2 specialized agents (see Section 5) |
| Output CSV | `ad_variations_output.csv` | Never overwrite — always append or create a new version file |
| Git | Safety checkpointing | Always commit before large batch runs |

**MCP Boundaries:**
- ✅ Allowed: Read local CSV files, write local CSV files
- ❌ Forbidden: Google Ads API (manual upload only — do NOT auto-publish ads)
- ❌ Forbidden: Access real customer data, CRM, or email lists without explicit approval

---

## 4. Primary Workflows

### Workflow A: Generate Google Ads Variations from CSV

**When to use:** When you need to test new ad copy for any product.

```
Step 1: Read sample_input.csv — validate it has columns: Product ID, Product Name, Key Features, Target Audience
Step 2: For each product row, spawn the headline sub-agent (Section 5)
Step 3: For each product row, spawn the description sub-agent (Section 5)
Step 4: Collect all outputs and run schema validation (Section 6)
Step 5: Write results to ad_variations_output_YYYY-MM-DD.csv
Step 6: Print a summary table showing how many ads were generated per product
Step 7: git commit -m "feat: generated ad variations for [product name]"
```

### Workflow B: Identify Underperforming Ads (if performance data provided)

**When to use:** When a CSV includes CTR or conversion data alongside ad copy.

```
Step 1: Read the performance CSV
Step 2: Flag any ad where CTR < 1% or conversion rate < 0.5% 
Step 3: For flagged ads, generate 3 replacement variations using Workflow A
Step 4: Output a comparison table: [Old Ad] vs [New Variations]
```

### Workflow C: Figma Plugin Batch Generation

**When to use:** When producing paid social image variants at scale (up to 100 variations).

```
Step 1: Ask user to provide the list of frames/image IDs from Figma
Step 2: For each frame, apply a new headline + description pair from the output CSV
Step 3: Report how many variants were generated and which frame IDs were used
Step 4: Never auto-publish — output a review file first
```

---

## 5. Sub-Agent Architecture

This folder uses **2 specialized sub-agents** as recommended by Anthropic's Growth Marketing team:

| Agent | Responsibility | Input | Output |
|---|---|---|---|
| **Headline Agent** | Generate 3 unique headlines per product | Product row from CSV | 3 headlines ≤ 30 chars each |
| **Description Agent** | Generate 2 descriptions per product | Product row + approved headline | 2 descriptions ≤ 90 chars each |
| **Validator Agent** | Character count + uniqueness check | All outputs | Pass/fail table per ad |

**Why split agents?** A single agent trying to optimize headlines AND descriptions simultaneously reduces quality. Dedicated agents produce better results and are easier to debug.

To spawn agents, use: `.agent/skills/sub-agent-spawner.md`

---

## 6. Output Schema & Validation

**Output file:** `ad_variations_output_YYYY-MM-DD.csv`

**Required columns:**
```
Product_ID:    string  — Must match source CSV
Headline_1:    string  — ≤ 30 characters (HARD LIMIT — Google will reject if exceeded)
Headline_2:    string  — ≤ 30 characters
Headline_3:    string  — ≤ 30 characters
Description_1: string  — ≤ 90 characters (HARD LIMIT)
Description_2: string  — ≤ 90 characters
Generated_At:  ISO date — YYYY-MM-DD
```

**Validation checklist (Claude must run before delivering output):**
- [ ] Every headline is ≤ 30 characters (count carefully — spaces count)
- [ ] Every description is ≤ 90 characters
- [ ] No two headlines for the same product are identical
- [ ] No headline or description contains competitor brand names
- [ ] Product_ID matches a row in the source CSV
- [ ] No vulgar, discriminatory, or misleading language

If any check fails, Claude must regenerate the failing item before output — never deliver an invalid ad.

---

## 7. Memory System (A/B Test Tracking)

To build a self-improving testing framework, maintain `ab_test_log.md` in this folder:

**Format:**
```
## Test: [Product] — [Date]
- Hypothesis: [What we expected]
- Headline tested: [text]
- Result: [CTR% or "not yet measured"]
- Verdict: [Winner / Loser / Inconclusive]
```

When generating new variations, Claude must read `ab_test_log.md` first and avoid repeating failed hypotheses. This replaces manual tracking in spreadsheets.

---

## 8. Safety & Forbidden Actions

1. **Git checkpoint first.** `git add -A && git commit -m "checkpoint"` before any batch run.
2. **Never auto-publish** ad copy to Google Ads, Meta, or any ad platform. Always output to a file for human review.
3. **Never overwrite** `sample_input.csv` — this is the source of truth.
4. **Confirmation required** before generating more than 50 ads in one run.
5. **Character limits are hard limits** — Google and Meta will reject ads that exceed them. Validate before outputting.

---

## 9. Custom Slash Commands

| Command | What it does |
|---|---|
| `/generate-ads [product_id]` | Run Workflow A for a specific product |
| `/validate-csv [filename]` | Run schema validation on any output CSV |
| `/ab-log [result]` | Append a result to ab_test_log.md |
| `/security-review` | Run security checklist (see `cross-team/security-review/`) |

---

## 10. Session-End Ritual

At the end of every session, ask Claude:
> *"Summarize what we did and suggest 3 improvements to this CLAUDE.md."*

Then:
1. Add suggestions to `## Lessons Learned` below.
2. Log to root `CHANGELOG.md`: `YYYY-MM-DD | Marketing | [What changed]`
3. `git commit -m "session-end: marketing [brief]"`

---

## Lessons Learned

| Date | Lesson | Added By |
|---|---|---|
| 2026-02-23 | Added dual sub-agent architecture, memory system, and strict character validation per Anthropic Growth Marketing team patterns | Setup |
