-- ============================================================
-- NVCHAD UI CONFIGURATION — lua/chadrc.lua
-- Theme: Aura Dracula Spirit (Soft) by JoseMurilloc
-- Base: chadracula-evondev (overridden to match exact VS Code colors)
-- ============================================================
--
-- This file overrides NvChad's default UI settings.
-- Structure mirrors: https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
--
-- Color Palette Reference (exact from VS Code extension):
--   bg        = #191521    fg       = #edecee
--   purple    = #a277ff    green    = #61ffca
--   orange    = #ffca85    pink     = #f694ff
--   red       = #ff6767    cyan     = #82e2ff
--   comment   = #64548E    select   = #3d375e7f
--   cursor    = #a277ff    sidebar  = #14111b
--   widget    = #140e1a    deep bg  = #100b15
-- ============================================================

---@type ChadrcConfig
local M = {}

-- ── Theme & Highlight Overrides ─────────────────────────────
M.base46 = {
  theme = "catppuccin",

  -- Override chadracula palette to match Aura Dracula Spirit (Soft) exactly
  -- Source: github.com/JoseMurilloc/aura-spirit-dracula
  changed_themes = {
    ["catppuccin"] = {
      base_16 = {
        base00 = "#191521", -- Editor background
        base01 = "#14111b", -- Sidebar / tab bar background
        base02 = "#2e2b38", -- Selection background (solid)
        base03 = "#64548E", -- Comments (muted purple)
        base04 = "#adacae", -- Dark foreground (status bar text)
        base05 = "#edecee", -- Default foreground
        base06 = "#cdccce", -- Light foreground (secondary text)
        base07 = "#ffffff", -- Brightest foreground
        base08 = "#ff6767", -- Red — errors, deletes, invalid
        base09 = "#ffca85", -- Orange — functions, entities, constants
        base0A = "#82e2ff", -- Cyan — types, classes, template expressions
        base0B = "#61ffca", -- Green — strings, inserted, constants
        base0C = "#f694ff", -- Pink — properties, attributes, separators
        base0D = "#a277ff", -- Purple — keywords, storage, operators, tags
        base0E = "#f694ff", -- Pink — import/export, async, control flow
        base0F = "#ff6767", -- Red — deprecated
      },

      base_30 = {
        white = "#edecee",
        darker_black = "#100b15",  -- Deepest background (widgets)
        black = "#191521",         -- Editor background
        black2 = "#14111b",        -- Sidebar / tab bar background
        one_bg = "#140e1a",        -- Popup / float background
        one_bg2 = "#2e2b38",      -- List selection background
        one_bg3 = "#3b334b",      -- Borders, hover background
        grey = "#64548E",          -- Comments (muted purple)
        grey_fg = "#776882",       -- Inactive icons (activity bar)
        grey_fg2 = "#6d6d6d",     -- Tab inactive foreground
        light_grey = "#adacae",    -- Status bar / secondary foreground
        red = "#ff6767",
        baby_pink = "#f694ff",
        pink = "#f694ff",
        line = "#2d2d2d",          -- Indent guides, whitespace
        green = "#61ffca",
        vibrant_green = "#8EFFD9", -- Terminal bright green
        nord_blue = "#82e2ff",
        blue = "#82e2ff",
        yellow = "#ffca85",
        sun = "#ffca85",
        purple = "#a277ff",
        dark_purple = "#8F5BFF",   -- Active link purple
        teal = "#82e2ff",
        orange = "#ffca85",
        cyan = "#82e2ff",
        statusline_bg = "#14111b", -- Status line background
        lightbg = "#2e2b38",       -- Light background (selections)
        pmenu_bg = "#a277ff",      -- Popup menu accent (purple)
        folder_bg = "#a277ff",     -- File tree folder icon color
      },
    },
  },

  -- ── Syntax Highlight Overrides ────────────────────────────
  -- Exact token colors from Aura Dracula Spirit (Soft) VS Code theme
  hl_override = {
    -- ── Comments (muted purple, italic) ─────────────────────
    Comment = { italic = true, fg = "#64548E" },
    ["@comment"] = { italic = true, fg = "#64548E" },

    -- ── Keywords, storage, operators (purple) ───────────────
    ["@keyword"] = { fg = "#a277ff" },
    ["@keyword.function"] = { fg = "#a277ff" },
    ["@keyword.return"] = { fg = "#a277ff" },
    ["@keyword.operator"] = { fg = "#a277ff" },
    ["@keyword.import"] = { fg = "#f694ff" },
    ["@keyword.export"] = { fg = "#f694ff" },
    ["@keyword.coroutine"] = { fg = "#f694ff", italic = true },
    ["@conditional"] = { fg = "#a277ff" },
    ["@repeat"] = { fg = "#f694ff" },
    ["@operator"] = { fg = "#a277ff" },
    StorageClass = { fg = "#a277ff" },
    ["@keyword.modifier"] = { fg = "#a277ff" },

    -- ── Strings, constants (green) ──────────────────────────
    String = { fg = "#61ffca" },
    ["@string"] = { fg = "#61ffca" },
    ["@string.escape"] = { fg = "#61ffca" },
    ["@string.regex"] = { fg = "#61ffca" },
    ["@constant"] = { fg = "#61ffca" },
    ["@constant.builtin"] = { fg = "#61ffca" },
    ["@boolean"] = { fg = "#61ffca" },
    ["@number"] = { fg = "#61ffca" },
    Character = { fg = "#61ffca" },

    -- ── Functions, methods (orange) ─────────────────────────
    ["@function"] = { fg = "#ffca85" },
    ["@function.call"] = { fg = "#ffca85" },
    ["@function.builtin"] = { fg = "#ffca85" },
    ["@method"] = { fg = "#ffca85" },
    ["@method.call"] = { fg = "#ffca85" },
    Function = { fg = "#ffca85" },

    -- ── Types, classes (cyan) ───────────────────────────────
    ["@type"] = { fg = "#82e2ff" },
    ["@type.builtin"] = { fg = "#82e2ff" },
    ["@type.definition"] = { fg = "#82e2ff" },
    ["@constructor"] = { fg = "#82e2ff" },
    Type = { fg = "#82e2ff" },

    -- ── Properties, attributes (pink) ───────────────────────
    ["@property"] = { fg = "#f694ff" },
    ["@field"] = { fg = "#f694ff" },
    ["@attribute"] = { fg = "#f694ff" },
    ["@lsp.type.property"] = { fg = "#f694ff" },

    -- ── Variables, parameters (white foreground) ────────────
    ["@variable"] = { fg = "#edecee" },
    ["@variable.builtin"] = { fg = "#edecee" },
    ["@parameter"] = { fg = "#edecee" },
    Identifier = { fg = "#edecee" },

    -- ── Tags (purple — HTML/JSX) ────────────────────────────
    ["@tag"] = { fg = "#a277ff" },
    ["@tag.builtin"] = { fg = "#a277ff" },
    ["@tag.delimiter"] = { fg = "#edecee" },
    ["@tag.attribute"] = { fg = "#f694ff" },

    -- ── Punctuation ─────────────────────────────────────────
    ["@punctuation.bracket"] = { fg = "#edecee" },
    ["@punctuation.delimiter"] = { fg = "#f694ff" },
    ["@punctuation.special"] = { fg = "#82e2ff" },

    -- ── Errors / diagnostics (red, orange) ──────────────────
    Error = { fg = "#ff6767" },
    DiagnosticError = { fg = "#ff6767" },
    DiagnosticWarn = { fg = "#ffca85" },

    -- ── Markup / markdown ───────────────────────────────────
    ["@markup.heading"] = { fg = "#a277ff", bold = true },
    ["@markup.link"] = { fg = "#a277ff" },
    ["@markup.raw"] = { fg = "#61ffca" },
    ["@markup.italic"] = { italic = true },
    ["@markup.bold"] = { bold = true },
    ["@markup.list"] = { fg = "#edecee" },

    -- ── LSP semantic tokens ─────────────────────────────────
    ["@lsp.type.function"] = { fg = "#ffca85" },
    ["@lsp.type.method"] = { fg = "#ffca85" },
    ["@lsp.type.type"] = { fg = "#82e2ff" },
    ["@lsp.type.class"] = { fg = "#82e2ff" },
    ["@lsp.type.interface"] = { fg = "#82e2ff", italic = true },
    ["@lsp.type.variable"] = { fg = "#edecee" },
    ["@lsp.type.parameter"] = { fg = "#edecee" },
    ["@lsp.type.keyword"] = { fg = "#a277ff" },
    ["@lsp.type.string"] = { fg = "#61ffca" },
    ["@lsp.type.number"] = { fg = "#61ffca" },
    ["@lsp.type.enum"] = { fg = "#82e2ff" },
    ["@lsp.type.enumMember"] = { fg = "#61ffca" },
    ["@lsp.type.namespace"] = { fg = "#82e2ff" },

    -- ── CSS (italic properties, like VS Code) ───────────────
    ["@property.css"] = { fg = "#a277ff", italic = true },
    ["@type.css"] = { fg = "#a277ff", italic = true },

    -- ── Cursor ──────────────────────────────────────────────
    Cursor = { bg = "#a277ff", fg = "#191521" },

    -- ── NvimTree: disable git color tracking on filenames ───
    NvimTreeGitDirty = { fg = "#edecee" },
    NvimTreeGitNew = { fg = "#edecee" },
    NvimTreeGitDeleted = { fg = "#edecee" },
    NvimTreeGitMerge = { fg = "#edecee" },
    NvimTreeGitRenamed = { fg = "#edecee" },
    NvimTreeGitStaged = { fg = "#edecee" },
    NvimTreeGitStagedIcon = { fg = "#edecee" },
  },
}

-- ── Dashboard ───────────────────────────────────────────────
M.nvdash = { load_on_startup = true }

-- ── Tabufline (buffer tabs) ─────────────────────────────────
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
