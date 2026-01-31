---
name: database-migration
description: Safely runs database migrations using the project's established script.
compatibility:
  os: [linux, darwin]
  dependencies: [psql]
---

# Database Migration Skill

This skill handles the execution of database migrations.

## Usage

1.  **Pre-check:** Ensure the database container is running.
2.  **Execute:** Run the migration script located at `scripts/migrate.sh`.
3.  **Verify:** Check the output for "Migration Successful".

## Constraints

-   NEVER run this on production without explicit user confirmation.
-   If the migration fails, capture the error log.
