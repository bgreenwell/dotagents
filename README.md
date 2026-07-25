# dotagents

**A directory-as-context convention for AI coding agents.**

> **Status:** Proposal / Draft 0.1.0

> **Inspiration:** Based on experience, emerging patterns in agentic coding, and [Issue #71 in agentsmd/agents.md](https://github.com/agentsmd/agents.md/issues/71).

## The problem

Single context files such as `AGENTS.md`, `CLAUDE.md`, and `.cursorrules` can become difficult to maintain as projects grow. Monolithic files make agents load irrelevant information, mix instructions with reference material, and encourage duplicate vendor-specific configuration.

## The proposal

Use a concise root `AGENTS.md` as a router. It should direct agents to deeper project context only when a task requires it.

The root file is the entry point. A hidden `.agents/` directory is the recommended home for routed context, but its categories are optional and projects may adapt them to their needs.

### Self-hosting example

This repository uses dotagents to maintain the proposal itself:

```text
.
├── AGENTS.md
└── .agents/
    ├── context/
    │   └── terminology.md
    ├── memory/
    │   └── decisions.md
    ├── personas/
    │   └── standards-reviewer.md
    ├── rules/
    │   └── documentation.md
    ├── skills/
    │   └── validate-context-routes/
    │       ├── SKILL.md
    │       └── scripts/
    │           └── validate.sh
    └── specs/
        └── README.md
```

Every checked-in example supports this proposal. The repository does not include fictional application schemas, migrations, or other capabilities that it cannot genuinely exercise.

## Suggested categories

- **`rules/`** — Project instructions that apply under conditions defined by the router.
- **`context/`** — Stable, read-only reference material such as terminology, architecture, schemas, or interfaces.
- **`memory/`** — Reviewed project decisions and durable knowledge.
- **`personas/`** — Optional specialist review perspectives.
- **`skills/`** — Task-specific Agent Skills and their bundled resources.
- **`specs/`** — Active requirements, proposals, and their index.
- **`logs/`** — Optional generated execution records or audit summaries. Do not store hidden reasoning, secrets, or personal data.

Categories do not load themselves. `AGENTS.md` must explain when an agent should read or use them.

## Root router example

```markdown
# AGENTS.md

## Context routing

- Before changing documentation, read `.agents/rules/documentation.md`.
- When making a structural decision, consult `.agents/memory/decisions.md`.
- When working on an active proposal, check `.agents/specs/README.md`.
```

This is progressive disclosure: the router remains small while task-specific context is loaded only when relevant.

## Relation to Agent Skills

dotagents and [Agent Skills](https://agentskills.io) are complementary:

| | Agent Skills | dotagents |
| --- | --- | --- |
| Purpose | Defines the format of a task-specific skill | Proposes how project-wide agent context can be organized |
| Scope | A `SKILL.md` file and its bundled resources | A project router and optional context categories |
| Location | Determined by supporting clients and projects | Recommends project-local skills under `.agents/skills/` |

A skill stored under `.agents/skills/` should still conform to the Agent Skills specification. The dotagents proposal does not redefine the `SKILL.md` format.

## FAQ

### Is `.agents/` required?

No. The root `AGENTS.md` is the entry point for this convention. `.agents/` is the recommended organization for deeper context.

### Should `.agents/` be committed?

Reviewed project context generally should be committed. Generated logs, personal preferences, credentials, secrets, and machine-local state should not be committed.

### Why not use `.github/`?

`.github/` is platform-specific. dotagents aims to remain usable by local models, IDE agents, and CLI agents.

### Is this related to `iannuttall/dotagents`?

They share a name but serve different purposes. [iannuttall/dotagents](https://github.com/iannuttall/dotagents) manages personal agent configurations across projects through symlinks. This proposal concerns project-specific context inside a repository.

### Is dotagents a client protocol?

Not in Draft 0.1.0. It is a proposed repository convention. Clients still need to support `AGENTS.md` and follow the routes it contains.
