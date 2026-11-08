---
name: memory-setup
description: How Claude's GitHub-backed memory works on the PC and phone, the Obsidian mirror, and the /save skill
type: reference
---

Set up on 2026-11-08.

- **PC (Windows):** the repo is cloned at `C:\Users\azzce\Documents\claude-memory`. The global `~/.claude/CLAUDE.md` tells every Claude Code session to read and update it.
- **Phone / web:** the user starts a Claude Code session (web or mobile app) with the `Claude-Memory` repo selected. Claude reads `README.md` and `MEMORY.md` from the repo and pushes changes back.
- The folder doubles as an Obsidian vault for browsing.
- Always `git pull` before reading on the PC, and push after writing, so both sides stay in sync.

## /save skill (added 2026-11-08)
- Lives at `C:\Users\azzce\.claude\skills\save\SKILL.md` (PC only).
- `/save <text>` saves that text; `/save` alone saves the lasting facts from the current chat.
- Writes each note to this repo (`notes/` + `MEMORY.md`), commits and pushes, and mirrors it into Obsidian at `C:\Users\azzce\OneDrive\Documents\Vault For Ai\AI Memory\Claude\` (index: `Claude Memory.md`), plus a dated entry in that folder's `Agent log.md`.

## The user's Obsidian vaults (all in `C:\Users\azzce\OneDrive\Documents\`)
- `Vault For Ai` — the AI workspace; its `AI Memory` folder is shared memory for all AI agents (start at `START HERE.md`). /save mirrors here.
- `Study` — personal study vault.
- `vault memory` — mostly copies of Claude skill folders.

Related: [[github-account]]
