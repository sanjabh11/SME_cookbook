# Glossary — Enterprise Edition Terms

Plain-English definitions for every new term introduced in the V2.0 Enterprise Upgrade.  
**If you're new to any of these, read here before opening any enterprise/ file.**

---

## A

**ASL-3 (AI Safety Level 3)**  
Anthropic's internal security classification for AI systems that could potentially provide meaningful assistance with creating weapons of mass destruction or conduct cyberattacks at a national scale. Our enterprise workflows are audited against ASL-3 standards to ensure compliance. *Think of it as an ISO certification, but for AI safety.*

**Auto-Approve Rate**  
The percentage of Claude Code actions that are automatically accepted without requiring your explicit confirmation. Anthropic's Feb 2026 research targets 20–40% as the optimal range for enterprise teams. Too low = slow. Too high = risky.

---

## C

**Champion Program**  
A structured internal training approach where 1–2 "AI Champions" per department are deeply trained in Claude Code, then responsible for training their own team members. This is how the CodePath partnership (Feb 13 2026) works at scale. *Think: train the trainer.*

**Claude Code Security (Preview)**  
An Enterprise/Team-only feature (Feb 2026 preview) that runs automated vulnerability scans on entire codebases and proposes human-reviewable patches. It does not auto-apply patches — always requires human sign-off.

**Cowork**  
Anthropic's lightweight collaboration integration (Jan 2026) that allows non-technical users to interact with Claude Code via plain conversation in Slack/Google Chat without needing Antigravity installed. Used in `non-technical/cowork-hybrid/`.

---

## G

**GitOps**  
The practice of using Git as the single source of truth for infrastructure and policy configuration. In our context: your `CLAUDE.md` policies are version-controlled via Git, and changes propagate automatically to all repos via the `.github/workflows/claude-propagate.yml` action.

---

## M

**MCP (Model Context Protocol)**  
Anthropic's open standard for connecting Claude to external tools and data sources securely. Used whenever Claude needs to interact with external APIs, databases, or systems beyond reading local files.

**Monorepo**  
A single Git repository containing multiple projects/packages. Large enterprises often use a monorepo so that policy updates (CLAUDE.md changes) can be propagated to all projects in one commit rather than updating 100+ separate repos.

---

## R

**RBAC (Role-Based Access Control)**  
A security model where permissions and capabilities are assigned based on a user's role (Engineer, Analyst, Exec, Designer) rather than individually. In our cookbook: each role `.md` file "inherits" from `COMPANY_CLAUDE.md` and adds role-specific rules.

**Risk Quadrant**  
A 2×2 framework for classifying autonomous session risk: [Session Length: Short/Long] × [Auto-Approve Rate: Low/High]. Low-risk = short sessions, low auto-approve. High-risk = long sessions, high auto-approve. Per Anthropic Feb 18 2026 research, keep sessions under 45 minutes with fewer than 3 human interventions for optimal outcomes.

**RSP (Responsible Scaling Policy)**  
Anthropic's formal policy document committing to specific safety measures before developing more powerful AI models. Current version: RSP v2.2 (Feb 2026). Enterprise deployments must align their governance workflows with RSP commitments.

---

## S

**Session-End Ritual**  
The standard end-of-session protocol: ask Claude to summarize the session + suggest 3 CLAUDE.md improvements → commit suggestions → update CHANGELOG.md → `git commit`. This prevents automation degradation over time.

**Skills Marketplace (Org-Level)**  
A feature introduced Dec 18 2025 in the Anthropic Console allowing admin users to deploy Claude Code Skills across an entire organization simultaneously. Instead of each developer installing skills manually, an admin pushes them workspace-wide.

**Sub-Agent**  
A specialized Claude instance given a single, focused responsibility (e.g., "only generate headlines", "only validate YAML", "only write tests"). Spawned by an orchestrator agent. Cleaner outputs, easier debugging than asking one Claude to do everything.

---

## Terms NOT In This Glossary

If you encounter a term not listed here, ask Claude directly:  
> *"In plain English, what is [term] and how does it relate to our cookbook?"*

Add the answer here and commit: `git commit -m "glossary: added [term] definition"`
