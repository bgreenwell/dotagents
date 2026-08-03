# dotagents

**A directory-as-context convention for AI coding agents.**

> **Status:** Proposal / Draft 0.1.0 (see [CHANGELOG.md](CHANGELOG.md))

> **Inspiration:** Based on experience, emerging patterns in agentic coding, and [Issue #71 in agentsmd/agents.md](https://github.com/agentsmd/agents.md/issues/71).

## The problem

Single context files such as `AGENTS.md`, `CLAUDE.md`, and `.cursorrules` can become difficult to maintain as projects grow. Monolithic files make agents load irrelevant information, mix instructions with reference material, and encourage duplicate vendor-specific configuration.

## The proposal

Use a concise root `AGENTS.md` as a router. It should direct agents to existing human-facing project documentation and agent-specific resources only when a task requires them.

Shared project truth remains in visible, conventional locations such as `README.md`, `CONTRIBUTING.md`, and `docs/`. The hidden `.agents/` directory is reserved for resources whose format or purpose is specific to agents.

### Self-hosting example

This repository uses dotagents to maintain the proposal itself:

```text
.
├── AGENTS.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── README.md
├── docs/
│   ├── decisions.md
│   ├── terminology.md
│   └── specs/
│       └── README.md
└── .agents/
    ├── personas/
    │   └── standards-reviewer.md
    └── skills/
        └── validate-context-routes/
            ├── SKILL.md
            └── scripts/
                └── validate.sh
```

Every checked-in example supports this proposal. The repository does not include fictional application schemas, migrations, or other capabilities that it cannot genuinely exercise.

## Shared project context

Information useful to both humans and agents should keep its normal project location:

- **`README.md`** — Project purpose, setup, and primary documentation.
- **`CHANGELOG.md`** — Version history, release notes, and proposal revisions.
- **`CONTRIBUTING.md`** — Contribution workflow and shared coding or documentation rules.
- **`docs/`** — Architecture, terminology, decisions, specifications, and other durable knowledge.
- **Existing project conventions** — Tests, schemas, API definitions, and configuration should remain where the project and its human contributors expect them.

Do not duplicate this material under `.agents/`. Route agents to the canonical source.

## Agent-specific resources

The optional `.agents/` directory may contain resources designed specifically for agent workflows:

- **`personas/`** — Specialist perspectives an agent can adopt for a task.
- **`skills/`** — Task-specific Agent Skills and their bundled resources.
- **`settings/`** — Vendor-neutral agent configuration when a defined format exists.
- **`memory/` and `logs/`** — Optional generated local state or execution summaries. These should normally be ignored by version control and must not contain secrets, personal data, or hidden reasoning.

Directories do not load themselves. `AGENTS.md` must explain when an agent should read or use each resource.

## Root router example

```markdown
# AGENTS.md

## Context routing

- Before changing documentation, read `CONTRIBUTING.md`.
- When making a structural decision, consult `docs/decisions.md`.
- When reviewing the convention, adopt `.agents/personas/standards-reviewer.md`.
```

This is progressive disclosure: the router remains small while task-specific context is loaded only when relevant.

## Relation to Agent Skills

dotagents and [Agent Skills](https://agentskills.io) are complementary:

| | Agent Skills | dotagents |
| --- | --- | --- |
| Purpose | Defines the format of a task-specific skill | Proposes how project-wide agent context can be organized |
| Scope | A `SKILL.md` file and its bundled resources | A project router, existing shared documentation, and optional agent-specific resources |
| Location | Determined by supporting clients and projects | Recommends project-local skills under `.agents/skills/` |

A skill stored under `.agents/skills/` should still conform to the Agent Skills specification. The dotagents proposal does not redefine the `SKILL.md` format.

## FAQ

### Is `.agents/` required?

No. The root `AGENTS.md` is the entry point for this convention. `.agents/` is an optional location for agent-specific resources.

### Should `.agents/` be committed?

Agent-specific skills, personas, and reviewed configuration may be committed. Generated logs, personal preferences, credentials, secrets, and machine-local state should not be committed. Shared project documentation belongs in its normal visible location.

### Why not use `.github/`?

`.github/` is platform-specific. dotagents aims to remain usable by local models, IDE agents, and CLI agents.

### Is this related to `iannuttall/dotagents`?

They share a name but serve different purposes. [iannuttall/dotagents](https://github.com/iannuttall/dotagents) manages personal agent configurations across projects through symlinks. This proposal concerns project-specific context inside a repository.

### Is dotagents a client protocol?

Not in Draft 0.1.0. It is a proposed repository convention. Clients still need to support `AGENTS.md` and follow the routes it contains.
