---
name: validate-context-routes
description: Validate that literal .agents paths referenced by a project's root AGENTS.md exist. Use when changing AGENTS.md routing, reorganizing .agents content, or checking a dotagents example.
---

# Validate context routes

Run the bundled validator from the project root:

```bash
.agents/skills/validate-context-routes/scripts/validate.sh
```

Pass another project root as the first argument when needed.

Review every reported missing path. Treat dynamic paths, globs, and external references as requiring manual review because the script validates only literal `.agents/...` routes.

Do not modify files during validation.
