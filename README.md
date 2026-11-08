# Claude Memory

Long-term memory for Claude, shared across every device and session.
This folder is also an Obsidian vault: open it in Obsidian to browse notes and the graph view.

## How Claude uses this repo

1. **At the start of a task**, read `MEMORY.md` (the index), then open any note in `notes/` that looks relevant.
2. **Save a memory** when you learn something that will still matter in a future session:
   who the user is, how they like to work, ongoing projects, useful links.
   Don't save things that only matter to the current conversation, or anything already recorded in a project's own code or docs.
3. **One fact per note** in `notes/`, named with a short kebab-case slug, e.g. `notes/prefers-short-answers.md`.
4. **Check before writing**: if a note already covers it, update that note instead of making a duplicate. Delete notes that turn out to be wrong.
5. **Add a one-line pointer** to `MEMORY.md` for every new note.
6. **Commit and push** after changing memory, so other devices see it:
   `git pull --rebase && git add -A && git commit -m "memory: <what changed>" && git push`
7. **Never store** passwords, API keys, tokens, or other secrets here.

## Note format

```markdown
---
name: kebab-case-slug
description: one-line summary used to decide relevance
type: user | feedback | project | reference
---

The fact itself.
For feedback/project notes, add:
**Why:** the reason
**How to apply:** when and how it matters

Related: [[other-note-slug]]
```

Types:
- `user`: who the user is, their background and preferences
- `feedback`: corrections and guidance on how Claude should work, with the reason
- `project`: ongoing work, goals, deadlines (always use absolute dates like 2026-11-08)
- `reference`: links to external resources, dashboards, accounts
