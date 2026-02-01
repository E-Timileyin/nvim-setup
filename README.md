# 🚀 NvChad Custom Configuration

A highly optimized Neovim configuration built on top of **NvChad v2.5**, tailored for Fullstack Development (Go, Next.js, React, TypeScript, and Tailwind CSS).

## 🛠️ Features
- **Performance Optimized:** Uses `vim.loader` for fast startup.
- **Modern LSP:** Fully migrated to Neovim 0.11+ `vim.lsp.config` and `vim.lsp.enable` APIs.
- **Fullstack Support:** Pre-configured for Go, TypeScript/JSX, Tailwind CSS, ESLint, Lua, HTML, and CSS.
- **Formatting:** Auto-format on save via `conform.nvim`.
  - **Frontend:** `prettier` (JS/TS/React, JSON, HTML, CSS)
  - **Lua:** `stylua`
  - **Go:** `goimports-reviser`, `gofumpt`, `golines`
- **Syntax Highlighting:** Enhanced treesitter configurations.

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

3. **Install Language Servers & Formatters:**
   Open Neovim and run:
   ```vim
   :MasonInstall ts_ls tailwindcss-language-server eslint-lsp prettier gopls goimports-reviser stylua html-lsp css-lsp
   ```

---

## 🔌 Plugins

Core plugins configured in `lua/plugins/init.lua`:

| Plugin | Purpose |
| :--- | :--- |
| **stevearc/conform.nvim** | formatting (Auto-format on save enabled) |
| **neovim/nvim-lspconfig** | LSP configurations |
| **nvim-treesitter/nvim-treesitter** | Syntax highlighting |

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

### 🪟 Window Management
| Key | Action |
| :--- | :--- |
| `Ctrl + h` | Move to Left Window |
| `Ctrl + l` | Move to Right Window |
| `Ctrl + j` | Move to Bottom Window |
| `Ctrl + k` | Move to Top Window |
| `<leader> + x` | Close Current Buffer |
| `Tab` | Next Buffer |
| `Shift + Tab` | Previous Buffer |

### 📝 Editing & Visual Mode
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<` | Visual | Indent Left (stays in selection) |
| `>` | Visual | Indent Right (stays in selection) |
| `J` | Visual | Move selected block **Down** |
| `K` | Visual | Move selected block **Up** |
| `<leader> + /` | N/V | Toggle Comment |

### 📂 File & Project Navigation (Standard NvChad)
| Key | Action |
| :--- | :--- |
| `Ctrl + n` | Toggle File Tree (NvimTree) |
| `<leader> + e` | Focus File Tree |
| `<leader> + ff` | Find Files |
| `<leader> + fw` | Live Grep (Search text in project) |
| `<leader> + fb` | Find Buffers |
| `<leader> + fh` | Help Tags |
| `<leader> + fo` | Find Old History |
| `<leader> + fz` | Find in Current Buffer |
| `<leader> + fa` | Find All (Hidden Files) |

### 🔍 LSP & Diagnostics
| Key | Action |
| :--- | :--- |
| `[d` | Previous Diagnostic (Error/Warn) |
| `]d` | Next Diagnostic (Error/Warn) |
| `<leader> + q` | Open Diagnostic List (Loclist) |
| `gd` | Go to Definition |
| `gD` | Go to Declaration |
| `K` | Hover Documentation |
| `gi` | Go to Implementation |
| `<leader> + ra` | Rename Symbol |
| `<leader> + ca` | Code Action |
| `<leader> + wa` | Add Workspace Folder |
| `<leader> + wr` | Remove Workspace Folder |
| `<leader> + wl` | List Workspace Folders |

### 💻 Terminal
| Key | Mode | Action |
| :--- | :--- | :--- |
| `<leader> + h` | Normal | Toggle Horizontal Terminal |
| `<leader> + v` | Normal | Toggle Vertical Terminal |
| `<Alt> + i` | Normal | Toggle Floating Terminal |
| `<Alt> + h` | Terminal | Toggle Horizontal Terminal |
| `<Alt> + v` | Terminal | Toggle Vertical Terminal |
| `<Alt> + i` | Terminal | Toggle Floating Terminal |

---

## 📂 Project Structure

```text
/home/eyiowuawi/.config/nvim/
├── init.lua              # Bootstrap
├── lua/
│   ├── chadrc.lua        # UI/Theme overrides
│   ├── mappings.lua      # Custom Keybindings
│   ├── options.lua       # Neovim options
│   ├── configs/          # Component Configurations
│   │   ├── conform.lua   # Formatter settings
│   │   ├── lspconfig.lua # LSP servers (Go, TS, HTML, etc.)
│   │   └── treesitter.lua
│   └── plugins/          # Plugin Management
│       └── init.lua      # Plugin List
```
