---
name: dpq-workshop-website
description: DPQ Workshop website (wood interiors for yachts & hotels) — location, stack, current state, how to deploy
type: project
---

The user's website for **DPQ Workshop** (Công ty TNHH DPQ), a Vietnamese wood-interior fit-out company.
On their Windows PC: `C:\Users\azzce\OneDrive\Documents\dpq-workshop-website`; the site itself is in `dpq-workshop/`.
The site is for the user's parents' company. All site text is in Vietnamese.

State as of 2026-11-08: redesigned in plain HTML/CSS/JS (no build step) in an "American, Shopify Editions 2026" style:
- Libraries from CDNs: GSAP + ScrollTrigger + SplitText, Lenis smooth scroll, three.js.
- Hero: a 3D wood cabinet whose doors open as you scroll, with wood-tone swatches.
- Then: a yacht video that opens like a treasure chest, a curved infinite gallery of 8 real project photos, stacked process cards, reviews and Facebook, then contact with a map and a mailto form.
- Content focuses on **yachts (du thuyền) and hotels (khách sạn)**. The user removed Liền kề and Penthouse.
- Project photos came from the user (IMG_60xx.JPG in the project root) and were converted to `assets/projects/*.webp`.
- Deploy: build `dpq-workshop-deploy.zip` with Python zipfile, with index.html at the zip root, and upload it to EdgeOne Pages.
- Bump the `?v=N` cache-buster on local assets after changes; it was v=9.
- The user said "later we config all out", so expect more copy and photo tweaks.

**Why:** It is the user's main recent coding project.
**How to apply:** When the user mentions "my website" or "the workshop site", it is this one. Business facts are in [[dpq-company-facts]]; the user's design taste is in [[design-taste-american-editorial]].
