# Contributing

This repository develops a draft convention. Keep changes small, reviewable, and consistent with the distinction between shared project truth and agent-specific resources.

## Documentation rules

- Clearly distinguish requirements, recommendations, and informative examples.
- Keep terminology and directory names consistent across the router, proposal, and fixtures.
- Use vendor-neutral language unless documenting a deliberate integration.
- Do not claim that an example performs an action unless it can be safely exercised and verified.
- Update the documented tree whenever tracked examples move.
- Verify externally maintained standards before asserting compatibility.
- Do not place secrets, personal data, or hidden reasoning in project context.

## Validation

After changing `AGENTS.md` or any routed file, run:

```bash
.agents/skills/validate-context-routes/scripts/validate.sh
```
