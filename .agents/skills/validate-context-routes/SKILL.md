---
name: validate-context-routes
description: Validate that literal project-relative paths referenced by a project's root AGENTS.md exist. Use when changing AGENTS.md routing, moving shared documentation or .agents resources, or checking a dotagents example.
---

# Validate context routes

Run the bundled validator from the project root:

```bash
.agents/skills/validate-context-routes/scripts/validate.sh
```

Pass another project root as the first argument when needed.

Review every reported missing path. Treat dynamic paths, globs, URLs, and references without backticks as requiring manual review because the script validates only literal project-relative paths enclosed in backticks.

Do not modify files during validation.
