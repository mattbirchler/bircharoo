# Bircharoo

A macOS-native Obsidian theme built for writing. Calm page, restrained type scale,
informational color, glass chrome, and controls that feel tactile. Light and dark,
desktop and iPhone.

See [DESIGN.md](DESIGN.md) for the brief and the reasoning behind the choices.

## Install for development

Symlink this folder into a vault's themes directory and pick it in Settings >
Appearance, or use the Obsidian CLI:

```sh
ln -s "$(pwd)" ~/Obsidian/Birchler/.obsidian/themes/Bircharoo
obsidian theme:set name=Bircharoo
```

Obsidian reloads `theme.css` when the file changes, so edits show up live.

## Files

- `manifest.json`: theme metadata Obsidian reads.
- `theme.css`: the whole theme. Variables first, then component rules, then mobile.
