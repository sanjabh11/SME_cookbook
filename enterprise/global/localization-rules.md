# Global & International Team Support
# Multi-language CLAUDE.md guidelines | Timezone-aware session rules

---

## Language Support for CLAUDE.md Files

Claude Code supports CLAUDE.md files written in any language. For international teams, create language-specific versions:

```
technical/robotics/
├── CLAUDE.md              ← English (canonical/reference version)  
├── CLAUDE.ja.md           ← Japanese team override
├── CLAUDE.de.md           ← German team override
└── CLAUDE.pt-BR.md        ← Brazil Portuguese team override
```

**Rule:** The English `CLAUDE.md` is always the authoritative version. Language variants may ADD culturally specific notes but must not contradict or omit any safety rule from the English version.

---

## Template: Non-English CLAUDE.md Starter

Copy and translate this to create a localized variant:

```markdown
# [チーム名] — CLAUDE.md (日本語版 / 英語版の補足)
# This file supplements the English CLAUDE.md. All safety and security rules in CLAUDE.md apply.

## このフォルダについて (About This Folder)
[Translated team description]

## 注意事項 (Important Notes for Japanese Team)
- 全ての出力は日本語で作成すること (All outputs in Japanese)
- 品質チェック前に英語版の検証チェックリストも実行すること (Also run English validation before delivering)
- セッション終了時のリチュアルは英語版の指示に従うこと (Session-end ritual follows English CLAUDE.md)
```

---

## Timezone-Aware Session Rules

### For Synchronous Multi-Timezone Teams

When a team is spread across 3+ time zones (e.g., India + EU + US West):

1. **Designate a "Prime Time Window"** (2–3 hours when 2+ regions overlap):
   - India + EU overlap: 12:00–15:00 IST  
   - EU + US East overlap: 14:00–18:00 CET  
   - Global: Tuesday/Wednesday are typically safest for all-hands async reviews

2. **Async-first default:** Use the slot-machine pattern during off-hours and share diffs at the next overlap window.

3. **Approval gates:** For sessions that modify shared infrastructure, require a human reviewer in a different timezone to review before merging.

### Timezone Reference Table

| Team Location | Business Hours (local) | UTC Offset | Overlap with IST |
|---|---|---|---|
| India (IST) | 09:00–18:00 | UTC+5:30 | — |
| Germany (CET) | 09:00–18:00 | UTC+1 | 12:30–14:30 IST |
| US East (EST) | 09:00–18:00 | UTC-5 | None (next day) |
| US West (PST) | 09:00–18:00 | UTC-8 | 22:30–01:30 IST |

---

## Data Residency & GDPR (EU Teams)

For EU-based team members processing data subject to GDPR:

1. **Confirm data residency:** Verify with Anthropic Enterprise that your plan includes EU data residency for prompt processing.
2. **No EU personal data** in any Cowork/Slack prompts — use Antigravity + MCP only.
3. **Cookie consent and privacy notice:** If Claude Code generates web code for EU users, ensure GDPR consent flows are included in every component.
4. **Right to Erasure:** Log all Claude-generated content that might contain personal data — deletion requests require manual audit of session logs.
5. **Data Processing Agreement (DPA):** Required in addition to standard ToS for EU enterprise deployments. Contact `privacy@anthropic.com`.

---

## International Compliance Quick Reference

| Region | Key Regulation | Primary Concern | Action |
|---|---|---|---|
| EU | GDPR | Personal data processing | DPA + EU data residency |
| US Healthcare | HIPAA | PHI access | BAA + see `enterprise/compliance/HIPAA-checklist.md` |
| India | DPDP Act 2023 | Data localization | Confirm data residency with Anthropic |
| US Federal | FedRAMP | Cloud security | Confirm FedRAMP status with Anthropic |
| Australia | Privacy Act 1988 | Cross-border data transfer | Verify Anthropic adequacy decision |
