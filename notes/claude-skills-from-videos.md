---
name: claude-skills-from-videos
description: Skills/tools the user saw in two videos, what is installed, the /check and /teach skills built here, and what is still missing
type: reference
---

Session 2026-11-08 (cloud session). Installs in a cloud container are temporary: redo them on the PC/phone.

## Video 1 (Vietnamese, 5 plugins) — all installed in the cloud container, vetted first
- Find Skills: `npx skills add vercel-labs/skills --skill find-skills -a claude-code` (CLI: `npm i -g skills`)
- Ponytail: `/plugin marketplace add DietrichGebert/ponytail`, `/plugin install ponytail@ponytail`
- Superpowers: `/plugin marketplace add obra/superpowers-marketplace`, `/plugin install superpowers@superpowers-marketplace` (not in the official marketplace here)
- Headroom: `pip install "headroom-ai[all]"` — a proxy that sees all prompts; also reads Copilot OAuth token
- OmniRoute: `npm i -g omniroute` — holds provider API keys; keep it local only; postinstall may download a prebuilt binary
- Static scan found no malware in any of them.

## Video 2 (nocode.joshua, "5 Claude skills") — only 1 of 5 done
1. chief-of-staff — source unknown, not installed
2. anatomy — source unknown, not installed
3. **teach** — priority. No published version found (skills.sh search is empty), so a `/teach` skill was written from the video
4. marketing-psychology — several repos share the name, not installed
5. last30days — likely `mvanhorn/last30days-skill`, not installed yet (run /check first)
- The original links are probably in the video's comments. Paste them to install.

## Skills built in this repo (`.claude/skills/`)
- `check` — `/check <npm|pip|repo|path>`: fetches inert, runs `scripts/scan.sh`, gives SAFE/CAUTION/DANGEROUS. Use before installing anything.
- `teach` — `/teach <topic>`: lesson plan, one lesson at a time, cheat sheet per lesson, progress saved in `teach/<topic>.md`.
- To use on the PC, copy them to `~/.claude/skills/`.

Related: [[memory-setup]]
