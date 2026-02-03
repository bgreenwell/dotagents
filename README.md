# dotagents

**A directory-as-context standard for AI agents.**

> **Status:** Proposal / Draft 0.1.0

> **Inspiration:** Based on experience, emerging patterns in agentic coding, and [Issue #71 in agentsmd/agents.md](https://github.com/agentsmd/agents.md/issues/71).

---

## The problem: Context file manageability

As AI agents become integral to development, single context files (e.g., `AGENTS.md`, `CLAUDE.md`, `.cursorrules`) can become difficult to manage.

A monolithic file often leads to:
1.  **Inefficient token usage:** Agents read irrelevant information (e.g., database schemas when working on CSS).
2.  **Conflicting instructions:** Mixing behavioral rules with static knowledge can confuse priority.
3.  **Tool noise:** Multiple vendor-specific folders (`.claude/`, `.gemini/`, `.cursor/`) clutter the root directory.

## The solution: Organization via `AGENTS.md`

The **dotagents** standard is a philosophy of organization. It proposes using a slim `AGENTS.md` file in your project root to act as a **router**, directing agents to deeper context only when they need it.

While you can organize your project context however you like, we recommend using a hidden `.agents/` directory to keep your root clean and provide a predictable structure for different types of agent data.

### Recommended directory structure

This structure is a starting point—feel free to adapt it to your project's needs.

```text
.
├── AGENTS.md             # Entry point & router (Required)
└── .agents/              # Recommended context directory
    ├── rules/            # Invariant behavioral guidelines
    │   ├── coding.md     # e.g. "No `any` types"
    │   └── comms.md      # e.g. "Be concise"
    ├── context/          # Static reference data (read-only)
    │   ├── schema.sql    # Database structure
    │   └── api.ts        # API interfaces
    ├── logs/             # Agent activity logs & audit trails
    │   └── session_1.md
    ├── memory/           # Persistent project knowledge (read/write)
    │   ├── decisions.md  # ADRs (why we chose X over Y)
    │   └── user.md       # Learned user preferences
    ├── personas/         # Specialized agent profiles
    │   └── qa.md         # e.g. "QA Engineer" hat
    ├── skills/           # Executable capabilities (agentskills.io compliant)
    │   └── database-migration/
    │       ├── SKILL.md
    │       └── scripts/
    │           └── migrate.sh
    └── specs/            # Current task requirements
        └── feature_x.md
```

---

## Usage

### 1. The root file (`AGENTS.md`)

The heart of the standard. This file defines the agent's identity and provides instructions on where to find specific information. By keeping this file small, you save tokens and maintain clarity.

**Example `AGENTS.md`:**

```markdown
# AGENTS.md

## Identity
You are a Senior Rust Engineer focused on safety and performance.

## Context routing
- **If working on database:** READ `.agents/context/schema.sql`
- **If writing new features:** CHECK `.agents/specs/` for active PRDs.
- **If facing a decision:** CONSULT `.agents/memory/decisions.md` to ensure consistency.

## Capabilities
- You may execute scripts found in `.agents/skills/` to validate your work.
```

### 2. The `.agents/` directory (Ideas for organization)

This directory is where you store the "heavy" context. By organizing it logically, you enable **Progressive Disclosure**—loading only what is necessary for the task at hand.

#### Personas
*Recommended for: Specialized roles.*
Store specialized agent "hats" (e.g., `qa.md`, `architect.md`) here. You can instruct your agent to "adopt the QA persona found in `.agents/personas/qa.md`" when it's time to test.

#### Logs
*Recommended for: Audit & Debugging.*
Keep a clean root by storing session logs, agent thought traces, or execution history in a dedicated folder.

#### Memory
*Recommended for: Long-term knowledge.*
A place for agents to persist what they've learned about your preferences or the project's history (e.g., `.agents/memory/decisions.md`).

#### Skills
*Recommended for: Executable capabilities.*
This directory is a perfect home for [agentskills.io](https://agentskills.io) compliant skills. Place your `SKILL.md` folders here alongside their supporting scripts.

#### Context & Specs
*Recommended for: Static & Active data.*
Keep your database schemas, API specs, and current feature requirements organized so the agent knows exactly where to look.

---

## Relation to Agent Skills (agentskills.io)

**dotagents** and the **Agent Skills** standard are complementary. **Agent Skills** defines the *format* (how a skill is written), while **dotagents** defines the *architecture* (where it lives in your project).

| Feature | Agent Skills (agentskills.io) | dotagents |
| :--- | :--- | :--- |
| **Primary Goal** | **Standardize Behavior.** Defines the `SKILL.md` format for specific workflows. | **Standardize Organization.** Defines a unified directory structure for *all* agent data. |
| **Scope** | **Skill-Local.** References are specific to the skill. | **Project-Wide.** Context is global to the project. |
| **Implementation** | **Vendor-Fragmented.** Can lead to duplication across `.claude/`, `.cursor/`, etc. | **Vendor-Agnostic.** A single source of truth for all tools. |

---

## FAQ

**Why not use `.github/`?**
`.github` is platform-specific. `dotagents` is designed to be platform-agnostic, usable by local LLMs, IDE agents, and CLI agents alike.

**Should `.agents/` be committed?**
Generally, yes. This context is valuable for team alignment. Personal preferences (e.g., `.agents/memory/user.md`) should usually be gitignored.

**Is this related to `iannuttall/dotagents`?**
While they share a name, they serve different purposes. [iannuttall/dotagents](https://github.com/iannuttall/dotagents) is a tool for managing personal agent configurations across projects via symlinks. This project is an **architectural standard** for organizing project-specific context within a repository.

**Why use this standard?**
It's about **efficiency** and **cleanliness**. It encourages referencing files only when needed ("context routing") and prevents the explosion of vendor-specific configuration folders in your project root.
