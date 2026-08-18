-- ============================================================
-- COLORSCHEME — colors/aura.lua
-- Aura Dracula Spirit (Soft) by JoseMurilloc
-- github.com/JoseMurilloc/aura-spirit-dracula
-- Standalone colorscheme, no framework dependency.
-- ============================================================

vim.cmd "hi clear"
if vim.fn.exists "syntax_on" == 1 then
  vim.cmd "syntax reset"
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "aura"

local c = {
  bg = "#191521",
  bg_dark = "#14111b",
  bg_darker = "#100b15",
  bg_float = "#140e1a",
  bg_select = "#2e2b38",
  bg_hover = "#3b334b",
  fg = "#edecee",
  fg_dark = "#adacae",
  fg_light = "#cdccce",
  white = "#ffffff",
  comment = "#64548E",
  red = "#ff6767",
  orange = "#ffca85",
  yellow = "#ffca85",
  green = "#61ffca",
  cyan = "#82e2ff",
  purple = "#a277ff",
  pink = "#f694ff",
  border = "#3b334b",
  none = "NONE",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ──────────────────────────────────────────────
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg_float })
hl("FloatBorder", { fg = c.border, bg = c.bg_float })
hl("FloatTitle", { fg = c.purple, bg = c.bg_float, bold = true })
hl("SignColumn", { bg = c.bg })
hl("ColorColumn", { bg = c.bg_select })
hl("Cursor", { fg = c.bg, bg = c.purple })
hl("CursorLine", { bg = c.bg_dark })
hl("CursorLineNr", { fg = c.purple, bold = true })
hl("LineNr", { fg = c.comment })
hl("Visual", { bg = c.bg_select })
hl("VisualNOS", { bg = c.bg_select })
hl("Search", { fg = c.bg, bg = c.yellow })
hl("IncSearch", { fg = c.bg, bg = c.orange })
hl("CurSearch", { link = "IncSearch" })
hl("Substitute", { fg = c.bg, bg = c.pink })
hl("MatchParen", { fg = c.pink, bold = true })
hl("Pmenu", { fg = c.fg, bg = c.bg_float })
hl("PmenuSel", { fg = c.bg, bg = c.purple })
hl("PmenuSbar", { bg = c.bg_select })
hl("PmenuThumb", { bg = c.bg_hover })
hl("WinSeparator", { fg = c.border })
hl("VertSplit", { fg = c.border })
hl("StatusLine", { fg = c.fg, bg = c.bg_dark })
hl("StatusLineNC", { fg = c.fg_dark, bg = c.bg_dark })
hl("TabLine", { fg = c.fg_dark, bg = c.bg_dark })
hl("TabLineFill", { bg = c.bg_dark })
hl("TabLineSel", { fg = c.fg, bg = c.bg_select })
hl("Folded", { fg = c.comment, bg = c.bg_dark })
hl("FoldColumn", { fg = c.comment, bg = c.bg })
hl("NonText", { fg = c.bg_hover })
hl("Whitespace", { fg = c.bg_hover })
hl("EndOfBuffer", { fg = c.bg })
hl("Directory", { fg = c.purple })
hl("Title", { fg = c.purple, bold = true })
hl("WinBar", { fg = c.fg_dark, bg = c.bg })
hl("WinBarNC", { fg = c.comment, bg = c.bg })

-- ── Diagnostics ────────────────────────────────────────────
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.orange })
hl("DiagnosticInfo", { fg = c.cyan })
hl("DiagnosticHint", { fg = c.green })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.orange })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.cyan })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })
hl("DiagnosticVirtualTextError", { fg = c.red, bg = c.none })
hl("DiagnosticVirtualTextWarn", { fg = c.orange, bg = c.none })
hl("DiagnosticVirtualTextInfo", { fg = c.cyan, bg = c.none })
hl("DiagnosticVirtualTextHint", { fg = c.green, bg = c.none })

-- ── Syntax (base) ──────────────────────────────────────────
hl("Comment", { fg = c.comment, italic = true })
hl("Constant", { fg = c.green })
hl("String", { fg = c.green })
hl("Character", { fg = c.green })
hl("Number", { fg = c.green })
hl("Boolean", { fg = c.green })
hl("Float", { fg = c.green })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.orange })
hl("Statement", { fg = c.purple })
hl("Conditional", { fg = c.purple })
hl("Repeat", { fg = c.pink })
hl("Label", { fg = c.pink })
hl("Operator", { fg = c.purple })
hl("Keyword", { fg = c.purple })
hl("Exception", { fg = c.pink })
hl("PreProc", { fg = c.pink })
hl("Include", { fg = c.pink })
hl("Define", { fg = c.pink })
hl("Macro", { fg = c.pink })
hl("Type", { fg = c.cyan })
hl("StorageClass", { fg = c.purple })
hl("Structure", { fg = c.cyan })
hl("Typedef", { fg = c.cyan })
hl("Special", { fg = c.cyan })
hl("Delimiter", { fg = c.fg })
hl("Underlined", { underline = true })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.bg, bg = c.yellow, bold = true })

-- ── Treesitter ─────────────────────────────────────────────
hl("@comment", { fg = c.comment, italic = true })
hl("@keyword", { fg = c.purple })
hl("@keyword.function", { fg = c.purple })
hl("@keyword.return", { fg = c.purple })
hl("@keyword.operator", { fg = c.purple })
hl("@keyword.import", { fg = c.pink })
hl("@keyword.export", { fg = c.pink })
hl("@keyword.coroutine", { fg = c.pink, italic = true })
hl("@keyword.modifier", { fg = c.purple })
hl("@conditional", { fg = c.purple })
hl("@repeat", { fg = c.pink })
hl("@operator", { fg = c.purple })
hl("@string", { fg = c.green })
hl("@string.escape", { fg = c.green })
hl("@string.regex", { fg = c.green })
hl("@constant", { fg = c.green })
hl("@constant.builtin", { fg = c.green })
hl("@boolean", { fg = c.green })
hl("@number", { fg = c.green })
hl("@function", { fg = c.orange })
hl("@function.call", { fg = c.orange })
hl("@function.builtin", { fg = c.orange })
hl("@method", { fg = c.orange })
hl("@method.call", { fg = c.orange })
hl("@type", { fg = c.cyan })
hl("@type.builtin", { fg = c.cyan })
hl("@type.definition", { fg = c.cyan })
hl("@constructor", { fg = c.cyan })
hl("@property", { fg = c.pink })
hl("@field", { fg = c.pink })
hl("@attribute", { fg = c.pink })
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.fg })
hl("@parameter", { fg = c.fg })
hl("@tag", { fg = c.purple })
hl("@tag.builtin", { fg = c.purple })
hl("@tag.delimiter", { fg = c.fg })
hl("@tag.attribute", { fg = c.pink })
hl("@punctuation.bracket", { fg = c.fg })
hl("@punctuation.delimiter", { fg = c.pink })
hl("@punctuation.special", { fg = c.cyan })
hl("@markup.heading", { fg = c.purple, bold = true })
hl("@markup.link", { fg = c.purple })
hl("@markup.raw", { fg = c.green })
hl("@markup.italic", { italic = true })
hl("@markup.bold", { bold = true })
hl("@markup.list", { fg = c.fg })
hl("@property.css", { fg = c.purple, italic = true })
hl("@type.css", { fg = c.purple, italic = true })

-- ── LSP semantic tokens ────────────────────────────────────
hl("@lsp.type.function", { fg = c.orange })
hl("@lsp.type.method", { fg = c.orange })
hl("@lsp.type.type", { fg = c.cyan })
hl("@lsp.type.class", { fg = c.cyan })
hl("@lsp.type.interface", { fg = c.cyan, italic = true })
hl("@lsp.type.variable", { fg = c.fg })
hl("@lsp.type.parameter", { fg = c.fg })
hl("@lsp.type.keyword", { fg = c.purple })
hl("@lsp.type.string", { fg = c.green })
hl("@lsp.type.number", { fg = c.green })
hl("@lsp.type.enum", { fg = c.cyan })
hl("@lsp.type.enumMember", { fg = c.green })
hl("@lsp.type.namespace", { fg = c.cyan })
hl("@lsp.type.property", { fg = c.pink })

-- ── Git (diff / gitsigns) ──────────────────────────────────
hl("DiffAdd", { fg = c.green, bg = c.none })
hl("DiffChange", { fg = c.orange, bg = c.none })
hl("DiffDelete", { fg = c.red, bg = c.none })
hl("DiffText", { fg = c.cyan, bg = c.none })
hl("GitSignsAdd", { fg = c.green })
hl("GitSignsChange", { fg = c.orange })
hl("GitSignsDelete", { fg = c.red })

-- ── NvimTree (git colors neutralized, matches original config) ─
hl("NvimTreeNormal", { fg = c.fg, bg = c.bg_dark })
hl("NvimTreeNormalNC", { fg = c.fg, bg = c.bg_dark })
hl("NvimTreeWinSeparator", { fg = c.bg_dark, bg = c.bg_dark })
hl("NvimTreeFolderIcon", { fg = c.purple })
hl("NvimTreeFolderName", { fg = c.fg })
hl("NvimTreeOpenedFolderName", { fg = c.purple })
hl("NvimTreeIndentMarker", { fg = c.bg_hover })
hl("NvimTreeGitDirty", { fg = c.fg })
hl("NvimTreeGitNew", { fg = c.fg })
hl("NvimTreeGitDeleted", { fg = c.fg })
hl("NvimTreeGitMerge", { fg = c.fg })
hl("NvimTreeGitRenamed", { fg = c.fg })
hl("NvimTreeGitStaged", { fg = c.fg })
hl("NvimTreeGitStagedIcon", { fg = c.fg })

-- ── Telescope ──────────────────────────────────────────────
hl("TelescopeNormal", { fg = c.fg, bg = c.bg_float })
hl("TelescopeBorder", { fg = c.border, bg = c.bg_float })
hl("TelescopePromptNormal", { fg = c.fg, bg = c.bg_select })
hl("TelescopePromptBorder", { fg = c.border, bg = c.bg_select })
hl("TelescopeTitle", { fg = c.purple, bold = true })
hl("TelescopeSelection", { bg = c.bg_select })
hl("TelescopeMatching", { fg = c.orange, bold = true })

-- ── Which-key / Cmp ────────────────────────────────────────
hl("CmpItemAbbrMatch", { fg = c.orange, bold = true })
hl("CmpItemKind", { fg = c.cyan })
hl("CmpItemMenu", { fg = c.comment, italic = true })
