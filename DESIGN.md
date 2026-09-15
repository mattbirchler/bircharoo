# Bircharoo design brief

An Obsidian theme that feels native to macOS and treats writing as the main event.

## Who it's for

Matt's personal vault. It's a long-term store for things worth keeping, but first and
foremost it's a writing app. Everything else in the UI is in service of the page.

## Direction in one line

iA Writer's calm, premium writing surface, wrapped in chrome that behaves like a
modern macOS app: glass, soft depth, and controls that feel tactile.

## Principles

1. **The page is the product.** Editor and reading view get the most care. Chrome
   recedes: fewer borders, quieter backgrounds, nothing that competes with text.
2. **Respect the user's font.** The theme never ships a typeface. It tunes size,
   weight, line height, and measure so whatever font is set in Appearance looks its
   best. Matt currently uses MonoLisa at 15px, so the scale must work for a
   monospaced body font too.
3. **Color is information.** Links and tags carry the accent. Headings do not.
   Chrome is neutral. The accent comes from Obsidian's Appearance setting so the
   theme adapts when it changes.
4. **A restrained type scale.** The inline document title is only marginally larger
   than body text. Headings step up gradually toward H1 and none of them shout.
   Weight and spacing do more work than size.
5. **Light and dark are equals.** Both modes are designed on purpose, not derived.
   Dark is warm-neutral gray, not pure black. Light is white on a soft system gray.
6. **Premium, tactile UI.** Glass (backdrop blur) on floating surfaces: menus,
   command palette, suggestions, modals, hover previews, tooltips. Hover states that
   answer immediately and press states that give a little. Motion is short and
   eased, never bouncy.
7. **Mobile is a first-class target.** Everything above should hold on iPhone.
   Touch targets stay Obsidian-sized, glass carries over to mobile sheets and
   sidebars, and the type scale is the same.

## Type scale (relative to body size)

| Element | Size | Weight | Notes |
| --- | --- | --- | --- |
| Body | 1em | normal | line-height 1.65 |
| Inline title | 1.45em | 600 | tight line-height, small gap below |
| H1 | 1.36em | 600 | |
| H2 | 1.24em | 600 | |
| H3 | 1.14em | 600 | |
| H4 | 1.06em | 600 | |
| H5 | 1em | 600 | muted color |
| H6 | 0.95em | 600 | muted color, letter-spaced |

Headings inherit the body color. Heading spacing above is generous so structure is
visible without size doing the work.

## Palette

- Neutrals only in chrome. Light: white page, #f5f5f7 sidebars (macOS system gray).
  Dark: #1e1e20 page, #19191b sidebars.
- Accent: Obsidian's `--accent-h/s/l`. Used for links, tags, selection, focus rings,
  active toggles, checkboxes. Matt can set this to macOS system blue in Appearance
  for the most native look.
- Semantic colors (red, orange, and so on) tuned to sit comfortably on both grounds.

## Decisions made along the way

- **Buttons (2026-09-14):** flat rounded rectangles, 6px corners, 28px tall, white
  fill in light and a raised gray in dark, one solid 1px border, no shadow, no
  gradient. Chosen over
  capsule glass and tinted ghost after comparing all three live in Settings.
  Dropdowns share the same surface. Primary (CTA) buttons are a solid accent fill.

- **Page as a card (2026-09-14):** on desktop the note pane is a rounded card (14px
  corners, hairline border) set into the gray chrome, with an 8px gutter on the
  sides and bottom. Mobile keeps the full-bleed page.

- **Icons (2026-09-14):** Phosphor (regular weight) replaces Obsidian's Lucide set.
  Done in CSS by masking each icon's box with a Phosphor glyph, keyed by the
  Lucide class Obsidian emits. The mapping lives in `scripts/icons.json`; run
  `scripts/build-icons.py` after editing it. Unmapped icons fall back to Lucide.

## Out of scope for the first pass

- Style Settings plugin options. The theme is opinionated first; knobs can come
  later if a choice turns out to be contentious.
- Custom fonts of any kind.
- Focus or zen mode.

## Things to check against real notes

- Long-form posts in `birchtree/` (headings, links, quotes, images)
- Highlights folders (long lists, callouts)
- Kanban and Projects plugin views (make sure chrome changes don't break them)
- iPhone: inline title, sidebars, command palette
