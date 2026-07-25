# Architecture decision records

## 001. Use `AGENTS.md` as the entry point

Status: Accepted

Recorded: 2026-07-24

Use the established root `AGENTS.md` file as the only required entry point. It routes agents to deeper context instead of requiring clients to load the entire `.agents/` tree.

## 002. Recommend `.agents/` for routed project context

Status: Accepted

Recorded: 2026-07-24

Recommend the plural `.agents/` directory to group project context while keeping its categories optional. The router, rather than directory presence alone, determines when context applies.

## 003. Keep canonical examples self-hosting

Status: Accepted

Recorded: 2026-07-24

Examples in this repository must help maintain or validate the dotagents proposal. Avoid fictional application capabilities that cannot be exercised truthfully.
