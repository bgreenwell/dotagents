# Changelog

All notable changes to the **dotagents** proposal and repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-07-25

### Added
- Root `AGENTS.md` context router specification and self-hosting example.
- Convention for separating shared project truth (`README.md`, `CONTRIBUTING.md`, `docs/`, `CHANGELOG.md`) from agent-specific resources (`.agents/`).
- Architecture Decision Records (`docs/decisions.md`) defining router precedence and directory boundaries.
- Terminology specification (`docs/terminology.md`) defining routes, rules, personas, skills, and progressive disclosure.
- `.agents/personas/standards-reviewer.md` persona for reviewing compliance with the dotagents specification.
- `.agents/skills/validate-context-routes/` skill for automated route verification.
- Frequently Asked Questions section distinguishing dotagents from `iannuttall/dotagents` and platform-specific `.github/` configurations.
