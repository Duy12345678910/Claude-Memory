---
name: memory-setup
description: How Claude's GitHub-backed memory works on the PC and on the phone
type: reference
---

Set up on 2026-11-08.

- **PC (Windows):** the repo is cloned at `C:\Users\azzce\Documents\claude-memory`. The global `~/.claude/CLAUDE.md` tells every Claude Code session to read and update it.
- **Phone / web:** the user starts a Claude Code session (web or mobile app) with the `Claude-Memory` repo selected. Claude reads `README.md` and `MEMORY.md` from the repo and pushes changes back.
- The folder doubles as an Obsidian vault for browsing.
- Always `git pull` before reading on the PC, and push after writing, so both sides stay in sync.

Related: [[github-account]]
