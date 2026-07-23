# Neovim Configuration Documentation

> NvChad v2.5 on Neovim 0.11+ | Theme: catppuccin (customized to Aura Dracula Spirit)

---

## First-Time Setup

```bash
# 1. Open nvim — Lazy will auto-install all plugins on first launch
nvim

# 2. Install all LSP servers and formatters
:MasonInstallAll

# 3. Authenticate GitHub Copilot
:Copilot auth

# 4. Verify LSP servers are running (open a .ts or .go file, then)
:LspInfo

# 5. Verify treesitter parsers
:TSInstallInfo
```

---

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point: bootstraps lazy.nvim, loads NvChad + plugins
├── lua/
│   ├── options.lua             # Vim options (clipboard, line numbers, undo, etc.)
│   ├── autocmds.lua            # Auto-commands (single-tab buffer behavior)
│   ├── mappings.lua            # All custom keybindings
│   ├── chadrc.lua              # NvChad UI config (theme, dashboard, tabufline)
│   ├── plugins/
│   │   └── init.lua            # All plugin declarations (lazy.nvim specs)
│   └── configs/
│       ├── lazy.lua            # Lazy.nvim options (icons, disabled vim plugins)
│       ├── lspconfig.lua       # LSP server configurations
│       ├── conform.lua         # Formatter config (format on save)
│       └── treesitter.lua      # Treesitter parser config
```

---

## Plugins

| Plugin | Purpose | Loads on |
|--------|---------|----------|
| **NvChad** | Base framework (UI, statusline, tabufline, nvim-tree, telescope, which-key, gitsigns, nvim-cmp) | Startup |
| **nvim-lspconfig** | LSP server management | Opening a file |
| **mason.nvim** | Auto-install LSP servers, formatters, linters | `:Mason` command |
| **conform.nvim** | Format on save | Saving a file |
| **nvim-treesitter** | Syntax highlighting + indentation | Opening a file |
| **nvim-autopairs** | Auto-close `()`, `{}`, `[]`, `""`, `''` | Entering insert mode |
| **nvim-ts-autotag** | Auto-close + rename HTML/JSX tags | Opening a file |
| **emmet-vim** | Fast HTML/JSX expansion (`div>ul>li*3`) | HTML/CSS/JSX/TSX/Vue/Svelte files |
| **todo-comments.nvim** | Highlight + search TODO/FIXME/HACK | Opening a file |
| **harpoon** | Pin and quick-switch between files | On demand |
| **undotree** | Visual undo history tree | `:UndotreeToggle` |
| **copilot.lua** | GitHub Copilot inline ghost text | Entering insert mode |

---

## Language Support

### Frontend
| Language | LSP | Formatter | Treesitter |
|----------|-----|-----------|------------|
| HTML | html-lsp | prettier | html |
| CSS | css-lsp | prettier | css |
| JavaScript | ts_ls, eslint | prettier | javascript |
| TypeScript | ts_ls, eslint | prettier | typescript |
| JSX/TSX | ts_ls, eslint | prettier | tsx |
| Tailwind | tailwindcss | — | — |
| JSON | — | prettier | json |

### Backend
| Language | LSP | Formatter | Treesitter |
|----------|-----|-----------|------------|
| Go | gopls | goimports-reviser, gofumpt, golines | go, gomod, gosum |
| Lua | lua_ls | stylua | lua, luadoc |

---

## Keybindings

> Leader key is `Space`. All keybindings below are in Normal mode unless noted.

### General

| Key | Mode | Action |
|-----|------|--------|
| `;` | Normal | Enter command mode (same as `:`) |
| `jk` | Insert | Escape to normal mode |
| `Ctrl+s` | Normal/Insert/Visual | Save file |
| `Esc` | Normal | Clear search highlights |

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h` | Move to left window |
| `Ctrl+j` | Move to lower window |
| `Ctrl+k` | Move to upper window |
| `Ctrl+l` | Move to right window |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `<` | Visual | Indent left (stays in visual) |
| `>` | Visual | Indent right (stays in visual) |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |

### LSP (works in any file with an active language server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `K` | Hover info (docs, types) |
| `Space rn` | Rename symbol across project |
| `Space ca` | Code action (quick fixes, refactors) |
| `Space sh` | Show function signature help |

### Diagnostics (errors, warnings)

| Key | Action |
|-----|--------|
| `[d` | Jump to previous diagnostic |
| `]d` | Jump to next diagnostic |
| `Space q` | Send diagnostics to location list |
| `Space fd` | Browse all diagnostics in Telescope |

### Formatting

| Key | Action |
|-----|--------|
| `Space fm` | Format current file |
| *(auto)* | Format on save is enabled by default |

### Telescope (fuzzy finder — provided by NvChad)

| Key | Action |
|-----|--------|
| `Space ff` | Find files |
| `Space fw` | Live grep (search text in project) |
| `Space fb` | Browse open buffers |
| `Space fh` | Help tags |
| `Space fo` | Recently opened files |
| `Space fs` | LSP document symbols (functions, classes) |
| `Space fS` | LSP workspace symbols |
| `Space fd` | All diagnostics |
| `Space ft` | Find all TODO/FIXME/HACK comments |

### File Explorer (nvim-tree — provided by NvChad)

| Key | Action |
|-----|--------|
| `Ctrl+n` | Toggle file tree |
| `Space e` | Focus file tree |

### Harpoon (pin files for quick access)

| Key | Action |
|-----|--------|
| `Space ha` | Add current file to harpoon |
| `Space hh` | Open harpoon menu (see all pinned files) |
| `Space 1` | Jump to harpoon file 1 |
| `Space 2` | Jump to harpoon file 2 |
| `Space 3` | Jump to harpoon file 3 |
| `Space 4` | Jump to harpoon file 4 |

### TODO Comments

| Key | Action |
|-----|--------|
| `Space ft` | Search all TODOs in Telescope |
| `]t` | Jump to next TODO comment |
| `[t` | Jump to previous TODO comment |

Write these in your code to highlight them:
```
-- TODO: something to do
-- FIXME: broken thing
-- HACK: ugly workaround
-- NOTE: important info
-- WARN: be careful
```

### Undotree

| Key | Action |
|-----|--------|
| `Space u` | Toggle undo history tree |

In the undotree panel: `j`/`k` to navigate, `Enter` to restore that state.

### Git (gitsigns — provided by NvChad)

| Key | Action |
|-----|--------|
| `Space gp` | Preview hunk (see what changed) |
| `Space gb` | Blame current line (who wrote it) |
| `Space gs` | Stage hunk |
| `Space gr` | Reset hunk (undo changes) |
| `]h` | Jump to next git change |
| `[h` | Jump to previous git change |

### Copilot (AI inline suggestions)

| Key | Action |
|-----|--------|
| *(auto)* | Ghost text appears as you type |
| `Ctrl+y` | Accept full suggestion |
| `Ctrl+t` | Accept next word only |
| `Ctrl+]` | Next suggestion |
| `Ctrl+\` | Previous suggestion |
| `Ctrl+e` | Dismiss suggestion |

### Emmet (HTML/JSX expansion)

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+y ,` | Insert | Expand emmet abbreviation |

Examples (type then press `Ctrl+y ,`):
```
div.container>ul>li*3          → nested div with 3 list items
.card>h2+p+a.btn               → card with heading, paragraph, button
table>tr*3>td*2                 → 3x2 table
```

### NvChad Defaults (most useful)

| Key | Action |
|-----|--------|
| `Space th` | Change colorscheme |
| `Space ch` | Cheatsheet (all keybindings) |
| `Tab` | Next buffer tab |
| `Shift+Tab` | Previous buffer tab |
| `Space x` | Close current buffer |

---

## Behavior

### Single-Tab Mode
Opening a file automatically closes all other unmodified buffers. Only one file is visible in the tab bar at a time. Files with unsaved changes are protected.

### Format on Save
Every file save auto-formats using the configured formatter for that filetype. To skip formatting once, use `:noa w`.

### Clipboard Sync
Every yank (`y`) and delete (`d`) goes to the system clipboard. No need for `"+y`.

### Persistent Undo
Undo history survives across sessions. You can close a file, reopen it later, and still undo. Powered by `undofile`. Browse the full history with `Space u` (undotree).

---

## Common Tasks

### "I want to rename a variable across the project"
1. Place cursor on the variable
2. Press `Space rn`
3. Type new name, press Enter

### "I want to see all places a function is used"
1. Place cursor on the function name
2. Press `gr`

### "I want to quickly switch between 2-3 files"
1. Open file A, press `Space ha` to pin it
2. Open file B, press `Space ha` to pin it
3. Press `Space 1` for file A, `Space 2` for file B

### "I want to find a file by name"
1. Press `Space ff`
2. Start typing the filename

### "I want to search text across the project"
1. Press `Space fw`
2. Type your search term

### "I want to see what changed in git"
1. `]h` / `[h` to jump between changes
2. `Space gp` to preview what changed
3. `Space gs` to stage, `Space gr` to revert

### "I want to fix a lint error"
1. `]d` to jump to the error
2. `Space ca` to see available fixes
3. Select a fix from the list

### "I want AI help while coding"
Use Copilot for inline suggestions (auto). For bigger tasks, open a tmux pane and use `claude` CLI:
```bash
# Split tmux pane
Ctrl+b %

# Run Claude Code
claude
```

---

## Maintenance

```vim
" Update all plugins
:Lazy update

" Update all LSP servers / formatters
:MasonUpdate

" Check plugin status
:Lazy

" Check LSP server status
:LspInfo

" Check Mason installations
:Mason

" Health check
:checkhealth
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Autocomplete not working | `:LspInfo` — check if server is attached. Run `:MasonInstallAll` if server missing |
| Formatter not working | `:ConformInfo` — check if formatter is found. Mason should install it |
| Treesitter highlighting broken | `:TSUpdate` to update parsers |
| Copilot not suggesting | `:Copilot status` — may need `:Copilot auth` |
| Plugin errors after update | `:Lazy restore` to rollback. Check `lazy-lock.json` in git |
| Slow startup | `:Lazy profile` to see what's slow |
