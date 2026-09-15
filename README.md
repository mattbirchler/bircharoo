# Bircharoo

A macOS-native Obsidian theme built for writing.

![Bircharoo in light mode](teaser.png)

Bircharoo treats the page as the product and keeps everything else out of the way.
It respects the fonts you set in Appearance and tunes size, weight, and spacing so
they read well, with a restrained heading scale where the document title is only a
touch larger than body text.

## What you get

- **A calm writing surface.** Generous line height, a readable measure, links and
  tags in your accent color, headings that stay neutral.
- **macOS-native chrome.** The note sits as a rounded card inside a soft gray
  frame. Tabs, buttons, dropdowns, and the file explorer follow modern macOS
  conventions, including Finder-style selection that takes the accent while the
  sidebar has focus.
- **Glass where it counts.** Menus, the command palette, suggestions, modals,
  hover previews, and notices are frosted. Chrome that never moves stays solid.
- **Tactile controls.** Buttons press, icons respond, toggles ease, checkboxes
  spring. Motion is short and switches off under Reduce Motion.
- **Phosphor icons** in place of the stock set, drawn in your accent and text
  colors.
- **Light and dark**, designed as equals. Dark is a warm neutral gray, never pure
  black.
- **iPhone and iPad** carry the same type scale and glass surfaces.

## Tips

- Set your accent color in Settings > Appearance. The theme follows it everywhere:
  links, tags, selection, focus rings, the selected file.
- Bircharoo ships no fonts. Pick any interface and text font you like.

## Development

Symlinked theme folders are ignored by Obsidian, so use the install script, which
copies the files into a vault and reloads the theme through the Obsidian CLI:

```sh
scripts/install.sh            # installs into ~/Obsidian/Birchler
scripts/install.sh /path/to/vault
scripts/watch.sh              # reinstall on every save
```

- `theme.css`: the whole theme. Variables first, then component rules, then mobile,
  then a generated block that swaps Obsidian's Lucide icons for Phosphor.
- `scripts/icons.json` and `scripts/build-icons.py`: the icon mapping and the
  generator. Phosphor glyphs used are vendored in `assets/phosphor/`.
- `test/Bircharoo Test.md`: a kitchen-sink note for checking every element.
- [DESIGN.md](DESIGN.md): the brief and the reasoning behind the choices.

## Credits and license

Bircharoo is MIT licensed. Icons are [Phosphor Icons](https://phosphoricons.com),
also MIT licensed.
