# dotagents

**A Directory-as-Context Standard for AI Agents.**

> **Status:** Proposal / Draft 1.0
> **Inspiration:** This standard synthesizes emerging patterns in agentic coding and is directly inspired by [Issue #71 in agentsmd/agents.md](https://github.com/agentsmd/agents.md/issues/71), which proposed moving from monolithic context files to structured directories.

---

## The Problem: Context Bloat

As AI agents (Claude Code, Gemini CLI, Cursor, Windsurf) become integral to development, the "Context File" (e.g., `AGENTS.md`, `CLAUDE.md`, `.cursorrules`) has become a dumping ground.

A single root file inevitably suffers from:
1.  **Token Waste:** Agents consume tokens reading database schemas when they are only working on CSS.
2.  **Cognitive Overload:** Mixing *Behavioral Rules* ("Always use TypeScript") with *Static Knowledge* ("Here is the API V1 Spec") confuses the model's priority.
3.  **Vendor Lock-in:** Creating `.claude/`, `.gemini/`, and `.cursor/` folders creates noise.

## The Solution: The `.agents/` Standard

The **dotagents** standard proposes a clean separation of concerns:

1.  **`AGENTS.md` (The Router):** A slim root file acting as an index and behavioral gatekeeper.
2.  **`.agents/` (The Database):** A structured, hidden directory for deep context, retrieved only when referenced.

### Directory Structure

```text
.
├── AGENTS.md             # The Entry Point & Router
└── .agents/              # The Context Directory
    ├── rules/            # Invariant behavioral guidelines
    │   ├── coding.md     # e.g. "No `any` types", "Use functional patterns"
    │   └── comms.md      # e.g. "Be concise", "No yapping"
    ├── context/          # Static reference data (Read-Only)
    │   ├── schema.sql    # Database structure
    │   └── api.ts        # API interfaces
    ├── memory/           # Persistent project knowledge (Read/Write)
    │   ├── decisions.md  # ADRs (Why we chose X over Y)
    │   └── user.md       # Learned user preferences
    ├── skills/           # Executable tools & scripts
    │   ├── db_migrate.sh
    │   └── test_suite.py
    └── specs/            # Current task requirements
        └── feature_x.md

```

---

## Usage

### 1. The Root File (`AGENTS.md`)

The root file should remain small (under 50 lines). Its primary job is to define the **Persona** and **Route** the agent to the correct sub-files in `.agents/`.

**Example `AGENTS.md`:**

```markdown
# AGENTS.md

## Identity
You are a Senior Rust Engineer focused on safety and performance.

## Context Routing
- **If working on Database:** READ `.agents/context/schema.sql`
- **If writing new features:** CHECK `.agents/specs/` for active PRDs.
- **If facing a decision:** CONSULT `.agents/memory/decisions.md` to ensure consistency.

## Capabilities
- You may execute scripts found in `.agents/skills/` to validate your work.

```

### 2. The `.agents` Folder

This folder holds the implementation details. By keeping them here, you allow the agent to use **Progressive Disclosure**—loading only the files strictly necessary for the current prompt.

#### `.agents/memory/`

*Recommended for: Long-term optimization.*
When the user corrects the agent ("Don't use `unwrap()`, use `expect()`"), the agent should be instructed to update `.agents/memory/coding_preferences.md` so the mistake is not repeated.

#### `.agents/skills/`

*Recommended for: Agentic Actions.*
Instead of halluncinating commands, the agent should look here for verified scripts (MCP tools, shell scripts, or Makefiles) that are safe to run in this specific environment.

---

## FAQ

**Why not just use `.github/`?**
`.github` is platform-specific. `dotagents` is designed to be platform-agnostic and usable by local LLMs, IDE agents (Cursor/VS Code), and CLI agents equally.

**Should I commit `.agents/`?**
Yes. This context is usually critical for team alignment. However, you should gitignore `.agents/memory/user.md` if it contains personal developer preferences.

### Why .agents/?
1.  **It helps solve the "Token Window" problem:** It explicitly encourages "Context Routing" (referencing files only when needed) rather than "Context Dumping."
2.  **It acknowledges "Skills":** By standardizing a `skills/` or `tools/` folder, it paves the way for agents to reliably find scripts they are allowed to run.
