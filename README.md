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

## The solution: The `.agents/` standard

This standard separates concerns into a router file and a context directory.

1.  **`AGENTS.md` (Router):** A minimal root file acting as an index and behavioral gatekeeper.
2.  **`.agents/` (Context):** A structured, hidden directory for deep context, retrieved only when referenced.

### Directory structure

```text
.
├── AGENTS.md             # Entry point & router
└── .agents/              # Context directory
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
    ├── personas/         # specialized agent profiles
    │   └── qa.md         # e.g. "QA Engineer" hat
    ├── skills/           # Executable capabilities (agentskills.io compliant)
    │   └── database-migration/
    │       ├── SKILL.md
    │       └── scripts/
    │           └── migrate.sh
    └── specs/            # Current task requirements
        └── feature_x.md
```

### Relation to Agent Skills (agentskills.io)

**dotagents** and the **Agent Skills** standard are complementary, not competitive. Think of **Agent Skills** as the *format* (like MP3) and **dotagents** as the *architecture* (like your Music library folder).

| Feature | Agent Skills (agentskills.io) | dotagents |
| :--- | :--- | :--- |
| **Primary Goal** | **Standardize Behavior.** Defines the `SKILL.md` format (YAML+Markdown) for specific workflows. | **Standardize Organization.** Defines a unified directory structure for *all* agent data. |
| **Scope** | **Skill-Local.** References are specific to the skill (e.g., `git-deploy/references/flags.md`). | **Project-Wide.** Context is global to the project (e.g., `.agents/context/schema.sql`). |
| **Implementation** | **Vendor-Fragmented.** Often leads to duplication across `.claude/`, `.cursor/`, etc. | **Vendor-Agnostic.** A single `.agents/` folder acting as the unified source of truth. |

**Solving vendor folder sprawl**

Without `dotagents`, supporting multiple tools often requires duplicating skills:

```text
my-project/
├── .claude/skills/       # <--- Duplicate Skill A
├── .cursor/skills/       # <--- Duplicate Skill A
└── .vscode/skills/       # <--- Duplicate Skill A
```

With `dotagents`, you have a **Unified Source of Truth**:

```text
my-project/
├── AGENTS.md
└── .agents/
    ├── skills/           # <--- Unified library (fully compatible with agentskills.io)
    │   ├── deploy/
    │   │   ├── SKILL.md
    │   │   └── scripts/
    │   └── test/
    │       └── SKILL.md
    ├── context/          # (Project-wide context, distinct from skill-local refs)
    └── memory/
```

---

## Usage

### 1. The root file (`AGENTS.md`)

This file defines the persona and routes the agent to relevant sub-files in `.agents/`. It should be kept small to minimize token overhead.

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

### 2. The `.agents` directory

This directory organizes implementation details, allowing for progressive disclosure—loading only files necessary for the current task.

#### `.agents/personas/`

*Use for: Specialized roles.*
Switch between different agent "hats" (e.g., `qa.md`, `architect.md`) by instructing the agent to load a specific persona file.

#### `.agents/logs/`

*Use for: Audit & Debugging.*
A place to store session logs or agent thought traces for review, keeping the root clean.

#### `.agents/memory/`

*Use for: Long-term knowledge.*
Agents can update files like `.agents/memory/coding_preferences.md` to persist user corrections or preferences.

#### `.agents/skills/`

*Use for: Agent capabilities.*
This directory is fully compatible with the [agentskills.io](https://agentskills.io) standard. Place your `SKILL.md` folders here alongside verified scripts (MCP tools, shell scripts, Makefiles) that the agent is permitted to execute.

---

## FAQ

**Why not use `.github/`?**
`.github` is platform-specific. `dotagents` is designed to be platform-agnostic, usable by local LLMs, IDE agents, and CLI agents.

**Should `.agents/` be committed?**
Yes. This context is valuable for team alignment. Personal preferences (e.g., `.agents/memory/user.md`) should be gitignored.

**Why use this standard?**
1.  **Efficiency:** Encourages referencing files only when needed ("context routing") rather than loading everything at once.
2.  **Safety:** Standardizing a `skills/` folder provides a predictable location for executable scripts.