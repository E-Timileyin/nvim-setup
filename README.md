# 🚀 Neovim Configuration

A vanilla Neovim configuration (no framework — managed directly with `lazy.nvim`), tailored for
Fullstack Development (Go, Next.js, React, TypeScript, and Tailwind CSS). Themed with
**Aura Dracula Spirit (Soft)**, unified across kitty + tmux + nvim.

## 🛠️ Features
- **Performance Optimized:** Uses `vim.loader` for fast startup.
- **Modern LSP:** Neovim 0.11+ `vim.lsp.config` and `vim.lsp.enable` APIs.
- **Fullstack Support:** Pre-configured for Go, TypeScript/JSX, Tailwind CSS, ESLint, Lua, HTML, and CSS.
- **Formatting:** Auto-format on save via `conform.nvim`.
  - **Frontend:** `prettier` (JS/TS/React, JSON, HTML, CSS)
  - **Lua:** `stylua`
  - **Go:** `goimports-reviser`, `gofumpt`, `golines`
- **Completion:** `nvim-cmp` (LSP, buffer, path, snippets via LuaSnip).
- **Syntax Highlighting:** Treesitter (`master` branch — legacy config API).
- **File explorer, fuzzy finder, statusline, buffer tabs:** `nvim-tree`, `telescope`, `lualine`, `bufferline`.
- **Seamless tmux navigation:** `Ctrl/Alt+hjkl` move across nvim splits and tmux panes as one grid.
- **Copilot** inline suggestions, **Harpoon** quick file switching, **Undotree**, **git hunks**.

---

## 📥 Installation

1. **Backup your current config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Launch Neovim.** `lazy.nvim` bootstraps itself and installs all plugins on first run;
   Treesitter parsers compile automatically (needs `cc`/`gcc` on `$PATH`).

4. **Install Language Servers & Formatters:**
   Open Neovim and run:
   ```vim
   :MasonInstallAll
   ```
   or manually:
   ```vim
   :MasonInstall lua-language-server html-lsp css-lsp typescript-language-server tailwindcss-language-server eslint-lsp gopls stylua prettier goimports-reviser gofumpt golines
   ```

---

## 🔌 Plugins

Configured in `lua/plugins/init.lua`:

| Plugin | Purpose |
| :--- | :--- |
| **stevearc/conform.nvim** | Formatting (auto-format on save) |
| **neovim/nvim-lspconfig** | LSP configurations |
| **williamboman/mason.nvim** | LSP/formatter installer |
| **nvim-treesitter/nvim-treesitter** (`master`) | Syntax highlighting |
| **hrsh7th/nvim-cmp** + LuaSnip | Completion |
| **nvim-tree/nvim-tree.lua** | File explorer |
| **nvim-telescope/telescope.nvim** | Fuzzy finder |
| **lewis6991/gitsigns.nvim** | Git hunks, blame, staging |
| **nvim-lualine/lualine.nvim** | Statusline |
| **akinsho/bufferline.nvim** | Buffer tabs |
| **lukas-reineke/indent-blankline.nvim** | Indent guides |
| **windwp/nvim-autopairs**, **nvim-ts-autotag** | Auto-closing pairs/tags |
| **mattn/emmet-vim** | HTML/JSX expansion |
| **folke/todo-comments.nvim** | TODO/FIXME highlighting & search |
| **ThePrimeagen/harpoon** (`harpoon2`) | Quick file switcher |
| **mbbill/undotree** | Visual undo history |
| **christoomey/vim-tmux-navigator** | Seamless nvim/tmux pane navigation |
| **zbirenbaum/copilot.lua** | Inline AI suggestions |

There is no dashboard/start screen — Neovim opens straight to an empty buffer.

---

## ⌨️ Keybindings & Cheat Sheet

The **Leader key** is set to `Space`.

### ⚡ Custom Essentials
| Key | Mode | Action |
| :--- | :--- | :--- |
| `;` | Normal | Enter Command Mode (replaces `:`) |
| `jk` | Insert | Exit Insert Mode (replaces `<Esc>`) |
| `Ctrl + s` | N/I/V | **Save File** |
| `<leader> + fm` | Normal | **Format Document** |
| `<Esc>` | Normal | Clear Search Highlights |
| `<leader> + b` | Normal | New Buffer |
| `<leader> + ya` | Normal | Yank Whole File |
| `gc` / `gcc` | N/V | Toggle Comment (native Neovim 0.10+) |

### 🪟 Window & Buffer Management
| Key | Action |
| :--- | :--- |
| `Ctrl/Alt + h` | Move to Left Window (crosses into tmux pane) |
| `Ctrl/Alt + l` | Move to Right Window (crosses into tmux pane) |
| `Ctrl/Alt + j` | Move to Bottom Window (crosses into tmux pane) |
| `Ctrl/Alt + k` | Move to Top Window (crosses into tmux pane) |
| `<leader> + x` | Close Current Buffer |
| `Tab` / `]b` | Next Buffer |
| `Shift + Tab` / `[b` | Previous Buffer |

### 📝 Editing & Visual Mode
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<` | Visual | Indent Left (stays in selection) |
| `>` | Visual | Indent Right (stays in selection) |
| `J` | Visual | Move selected block **Down** |
| `K` | Visual | Move selected block **Up** |

### 📂 File & Project Navigation
| Key | Action |
| :--- | :--- |
| `Ctrl + n` | Toggle File Tree (NvimTree) |
| `<leader> + e` | Focus File Tree |
| `<leader> + ff` | Find Files |
| `<leader> + fw` | Live Grep (Search text in project) |
| `<leader> + fb` | Find Buffers |
| `<leader> + fh` | Help Tags |
| `<leader> + fo` | Recent Files |
| `<leader> + ma` | Marks |

### 🔍 LSP & Diagnostics
| Key | Action |
| :--- | :--- |
| `[d` | Previous Diagnostic (Error/Warn) |
| `]d` | Next Diagnostic (Error/Warn) |
| `<leader> + q` | Open Diagnostic List (Loclist) |
| `gd` | Go to Definition |
| `gD` | Go to Declaration |
| `gr` | References |
| `K` | Hover Documentation |
| `gi` | Go to Implementation |
| `<leader> + rn` | Rename Symbol |
| `<leader> + ca` | Code Action |
| `<leader> + sh` | Signature Help |
| `<leader> + fs` | Document Symbols |
| `<leader> + fS` | Workspace Symbols |
| `<leader> + fd` | Telescope Diagnostics |

### 🗂 Harpoon / Undotree / TODO
| Key | Action |
| :--- | :--- |
| `<leader> + ha` | Harpoon: add file |
| `<leader> + hh` | Harpoon: toggle menu |
| `<leader> + 1..4` | Harpoon: jump to file 1-4 |
| `<leader> + u` | Toggle Undotree |
| `<leader> + ft` | Find TODOs (Telescope) |
| `]t` / `[t` | Next/Previous TODO |

### 🔀 Git (gitsigns)
| Key | Action |
| :--- | :--- |
| `<leader> + gp` | Preview Hunk |
| `<leader> + gb` | Blame Line |
| `<leader> + gs` | Stage Hunk |
| `<leader> + gr` | Reset Hunk |
| `<leader> + gt` | Git Status (Telescope) |
| `]h` / `[h` | Next/Previous Hunk |

### 🤖 Copilot (insert mode)
| Key | Action |
| :--- | :--- |
| `Ctrl + y` | Accept suggestion |
| `Ctrl + t` | Accept word |
| `Ctrl + ]` | Next suggestion |
| `Ctrl + \` | Previous suggestion |
| `Ctrl + e` | Dismiss |

---

## 📂 Project Structure

```text
~/.config/nvim/
├── init.lua                    # Bootstrap: lazy.nvim, options, plugins, colorscheme
├── colors/
│   └── aura.lua                # Aura Dracula Spirit (Soft) colorscheme (standalone)
├── lua/
│   ├── mappings.lua             # Custom keybindings
│   ├── options.lua              # Neovim options
│   ├── autocmds.lua             # Autocommands (single-buffer mode)
│   ├── configs/                 # Component configurations
│   │   ├── conform.lua          # Formatter settings
│   │   ├── lspconfig.lua        # LSP servers (Go, TS, HTML, etc.)
│   │   ├── treesitter.lua       # Treesitter setup
│   │   ├── cmp.lua               # Completion setup
│   │   ├── nvimtree.lua          # File explorer setup
│   │   ├── telescope.lua         # Fuzzy finder setup
│   │   ├── gitsigns.lua          # Git signs setup
│   │   ├── lualine.lua           # Statusline setup
│   │   ├── bufferline.lua        # Buffer tabs setup
│   │   └── lazy.lua              # lazy.nvim options (disabled built-ins)
│   └── plugins/
│       └── init.lua              # Plugin list
```
