-- ============================================================
-- COLORSCHEME — colors/akaza.lua
-- Akaza — Demon Slayer Inspired Neovim Colorscheme
--
-- Vibrant Neon Palette derived directly from the Akaza wallpaper:
--   Hot Neon Pink / Magenta  → Hair & Glowing Flame Aura
--   Electric Cyan / Ice Blue → Body Tattoo Markings & Blue Flames
--   Golden Yellow / Amber    → Demon Eyes & Search Highlights
--   Violet / Purple / Red    → Keywords, Operators, Diagnostics
--   Transparent ("NONE")     → Native Glass / Terminal Transparency
-- ============================================================

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "akaza"

local c = {
	-- Backgrounds & Glass Surface (fully transparent — wallpaper shows through)
	bg = "NONE",
	bg_dark = "NONE",
	bg_glass = "NONE",
	bg_float = "NONE",
	bg_select = "#3D1A35",
	bg_hover  = "#4D1F42",

	-- Akaza Hair & Glowing Pink Flame Aura
	pink = "#FF2A8A",
	magenta = "#E6007E",
	crimson = "#B81C4C",

	-- Akaza Blue Tattoos & Cyan Flame Aura
	cyan = "#00E5FF",
	blue = "#38BDF8",

	-- Akaza Demon Eyes & Flame Highlights
	yellow = "#FFD166",
	orange = "#FF9F1C",

	-- Text / Neutral Syntax  (bright whites for readability over glass)
	fg = "#FFFFFF",        -- pure white — maximum contrast on glass
	fg_light = "#FFFFFF",
	fg_dark = "#CBD5E1",   -- light slate — was too dark over wallpaper
	comment = "#7C8FA6",

	-- Borders & Guides
	border = "#FF2A8A",
	border_dim = "#3D2440",
	bg_indent = "#1A1D27",

	-- Syntax Accents
	green = "#34D399",
	purple = "#A855F7",
	red = "#F43F5E",

	none = "NONE",
}

local hl = function(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================
-- EDITOR UI (Full Transparency Support)
-- ============================================================

hl("Normal", { fg = c.fg, bg = c.none })
hl("NormalNC", { fg = c.fg, bg = c.none })

hl("NormalFloat", { fg = c.fg, bg = c.bg_float })
hl("FloatBorder", { fg = c.border, bg = c.bg_float })
hl("FloatTitle", { fg = c.pink, bg = c.bg_float, bold = true })

hl("SignColumn", { bg = c.none })
hl("FoldColumn", { fg = c.comment, bg = c.none })
hl("EndOfBuffer", { fg = c.none, bg = c.none })

hl("ColorColumn", { bg = c.none })
hl("Cursor", { fg = "#0D0F14", bg = c.pink })
hl("TermCursor", { fg = "#0D0F14", bg = c.pink })
hl("TermCursorNC", { fg = "#0D0F14", bg = c.pink })
hl("CursorLine", { bg = c.none })
hl("CursorLineNr", { fg = c.pink, bg = c.none, bold = true })
hl("LineNr", { fg = c.comment, bg = c.none })

hl("Visual", { bg = c.bg_select })
hl("VisualNOS", { bg = c.bg_select })

-- Search uses Akaza's glowing gold eyes
hl("Search", { fg = "#000000", bg = c.yellow, bold = true })
hl("IncSearch", { fg = "#000000", bg = c.orange, bold = true })
hl("CurSearch", { link = "IncSearch" })
hl("Substitute", { fg = c.fg_light, bg = c.magenta })

hl("MatchParen", { fg = c.cyan, bold = true, underline = true })

-- Completion popup menu
hl("Pmenu", { fg = c.fg, bg = c.bg_float })
hl("PmenuSel", { fg = c.fg_light, bg = c.pink, bold = true })
hl("PmenuSbar", { bg = c.bg_select })
hl("PmenuThumb", { bg = c.bg_hover })

-- Separators
hl("WinSeparator", { fg = c.border_dim })
hl("VertSplit", { fg = c.border_dim })

-- Status line
hl("StatusLine", { fg = c.fg, bg = c.none })
hl("StatusLineNC", { fg = c.fg_dark, bg = c.none })

-- Tabs
hl("TabLine", { fg = c.fg_dark, bg = c.none })
hl("TabLineFill", { bg = c.none })
hl("TabLineSel", { fg = c.pink, bg = c.bg_select, bold = true })

-- Folding
hl("Folded", { fg = c.comment, bg = c.none })

-- Invisible characters
hl("NonText", { fg = "#262938" })
hl("Whitespace", { fg = "#262938" })

hl("Directory", { fg = c.cyan, bold = true })
hl("Title", { fg = c.pink, bold = true })
hl("WinBar", { fg = c.fg_dark, bg = c.none })
hl("WinBarNC", { fg = c.comment, bg = c.none })

-- ============================================================
-- DIAGNOSTICS
-- ============================================================

hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.cyan })
hl("DiagnosticHint", { fg = c.green })

hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.cyan })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })

hl("DiagnosticVirtualTextError", { fg = c.red, bg = c.none })
hl("DiagnosticVirtualTextWarn", { fg = c.yellow, bg = c.none })
hl("DiagnosticVirtualTextInfo", { fg = c.cyan, bg = c.none })
hl("DiagnosticVirtualTextHint", { fg = c.green, bg = c.none })

-- ============================================================
-- BASE SYNTAX
-- ============================================================
-- BASE SYNTAX (Multi-Color Vibrant Palette)
-- ============================================================

hl("Comment", { fg = c.comment, italic = true })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.green })
hl("Character", { fg = c.green })
hl("Number", { fg = c.orange })
hl("Boolean", { fg = c.orange, bold = true })
hl("Float", { fg = c.orange })

hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.pink, bold = true })
hl("Statement", { fg = c.purple })
hl("Conditional", { fg = c.yellow, bold = true })
hl("Repeat", { fg = c.yellow, bold = true })
hl("Label", { fg = c.purple })
hl("Operator", { fg = c.cyan })
hl("Keyword", { fg = c.purple, italic = true })
hl("Exception", { fg = c.red, bold = true })

hl("PreProc", { fg = c.magenta })
hl("Include", { fg = c.magenta, bold = true })
hl("Define", { fg = c.magenta })
hl("Macro", { fg = c.purple })

hl("Type", { fg = c.blue })
hl("StorageClass", { fg = c.purple })
hl("Structure", { fg = c.blue })
hl("Typedef", { fg = c.cyan })

hl("Special", { fg = c.cyan })
hl("Delimiter", { fg = c.fg_dark })
hl("Underlined", { underline = true })
hl("Error", { fg = c.red, bold = true })
hl("Todo", { fg = "#000000", bg = c.yellow, bold = true })

-- ============================================================
-- TREESITTER (Balanced Syntax Distribution)
-- ============================================================

hl("@comment", { fg = c.comment, italic = true })
hl("@keyword", { fg = c.purple, italic = true })
hl("@keyword.function", { fg = c.pink, bold = true })
hl("@keyword.return", { fg = c.red, bold = true })
hl("@keyword.operator", { fg = c.cyan })
hl("@keyword.import", { fg = c.magenta, bold = true })
hl("@keyword.export", { fg = c.magenta, bold = true })
hl("@keyword.coroutine", { fg = c.orange, italic = true })
hl("@keyword.modifier", { fg = c.cyan, italic = true })

hl("@conditional", { fg = c.yellow, bold = true })
hl("@repeat", { fg = c.yellow, bold = true })
hl("@operator", { fg = c.cyan })

hl("@string", { fg = c.green })
hl("@string.escape", { fg = c.orange })
hl("@string.regex", { fg = c.orange })

hl("@constant", { fg = c.yellow })
hl("@constant.builtin", { fg = c.orange, bold = true })
hl("@boolean", { fg = c.orange, bold = true })
hl("@number", { fg = c.orange })

hl("@function", { fg = c.pink, bold = true })
hl("@function.call", { fg = c.cyan })
hl("@function.builtin", { fg = c.cyan, bold = true })
hl("@method", { fg = c.blue })
hl("@method.call", { fg = c.blue })

hl("@type", { fg = c.blue })
hl("@type.builtin", { fg = c.blue })
hl("@type.definition", { fg = c.blue })
hl("@constructor", { fg = c.pink, bold = true })

hl("@property", { fg = c.fg_light })
hl("@field", { fg = c.fg })
hl("@attribute", { fg = c.purple })
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.yellow, bold = true })
hl("@parameter", { fg = c.fg_dark })

hl("@tag", { fg = c.pink })
hl("@tag.builtin", { fg = c.magenta })
hl("@tag.delimiter", { fg = c.fg_dark })
hl("@tag.attribute", { fg = c.cyan })

hl("@punctuation.bracket", { fg = c.fg_dark })
hl("@punctuation.delimiter", { fg = c.fg_dark })
hl("@punctuation.special", { fg = c.cyan })

hl("@markup.heading", { fg = c.pink, bold = true })
hl("@markup.link", { fg = c.cyan })
hl("@markup.raw", { fg = c.green })
hl("@markup.italic", { italic = true })
hl("@markup.bold", { bold = true })
hl("@markup.list", { fg = c.pink })

-- ============================================================
-- LSP SEMANTIC TOKENS
-- ============================================================

hl("@lsp.type.function", { fg = c.cyan })
hl("@lsp.type.method", { fg = c.blue })
hl("@lsp.type.type", { fg = c.blue })
hl("@lsp.type.class", { fg = c.blue })
hl("@lsp.type.interface", { fg = c.blue, italic = true })
hl("@lsp.type.variable", { fg = c.fg })
hl("@lsp.type.parameter", { fg = c.fg_dark })
hl("@lsp.type.keyword", { fg = c.purple })
hl("@lsp.type.string", { fg = c.green })
hl("@lsp.type.number", { fg = c.orange })
hl("@lsp.type.enum", { fg = c.cyan })
hl("@lsp.type.enumMember", { fg = c.orange })
hl("@lsp.type.namespace", { fg = c.blue })
hl("@lsp.type.property", { fg = c.fg_light })

-- ============================================================
-- GIT / DIFF / GITSIGNS
-- ============================================================

hl("DiffAdd", { fg = c.green, bg = c.none })
hl("DiffChange", { fg = c.yellow, bg = c.none })
hl("DiffDelete", { fg = c.red, bg = c.none })
hl("DiffText", { fg = c.cyan, bg = c.none })

hl("GitSignsAdd", { fg = c.green })
hl("GitSignsChange", { fg = c.yellow })
hl("GitSignsDelete", { fg = c.red })

-- ============================================================
-- NVIMTREE (Transparent Background)
-- ============================================================

hl("NvimTreeNormal", { fg = c.fg, bg = c.none })
hl("NvimTreeNormalNC", { fg = c.fg, bg = c.none })
hl("NvimTreeWinSeparator", { fg = c.border_dim, bg = c.none })
hl("NvimTreeFolderIcon", { fg = c.cyan })
hl("NvimTreeFolderName", { fg = c.fg })
hl("NvimTreeOpenedFolderName", { fg = c.pink, bold = true })
hl("NvimTreeIndentMarker", { fg = "#262938" })

hl("NvimTreeGitDirty", { fg = c.yellow })
hl("NvimTreeGitNew", { fg = c.green })
hl("NvimTreeGitDeleted", { fg = c.red })

-- ============================================================
-- TELESCOPE — Fully Transparent
-- ============================================================

hl("TelescopeNormal",        { fg = c.fg_light, bg = c.none })
hl("TelescopeBorder",        { fg = c.border,   bg = c.none })
hl("TelescopePromptNormal",  { fg = c.fg_light, bg = c.none })
hl("TelescopePromptBorder",  { fg = c.border,   bg = c.none })
hl("TelescopePreviewNormal", { fg = c.fg_light, bg = c.none })
hl("TelescopePreviewBorder", { fg = c.border,   bg = c.none })
hl("TelescopeResultsNormal", { fg = c.fg_light, bg = c.none })
hl("TelescopeResultsBorder", { fg = c.border,   bg = c.none })
hl("TelescopeTitle",         { fg = c.pink,     bg = c.none, bold = true })
hl("TelescopeSelection",     { fg = c.fg_light, bg = c.bg_select, bold = true })
hl("TelescopeSelectionCaret",{ fg = c.pink,     bg = c.bg_select })
hl("TelescopeMatching",      { fg = c.yellow,   bold = true })
hl("TelescopePromptPrefix",  { fg = c.pink })

-- ============================================================
-- CMP / WHICH-KEY
-- ============================================================

hl("CmpItemAbbrMatch", { fg = c.pink, bold = true })
hl("CmpItemKind", { fg = c.cyan })
hl("CmpItemMenu", { fg = c.comment, italic = true })

-- WhichKey — fully transparent, white text
hl("WhichKey",          { fg = c.pink,    bold = true })
hl("WhichKeyGroup",     { fg = c.cyan,    bold = true })
hl("WhichKeyDesc",      { fg = c.fg_light })
hl("WhichKeySeparator", { fg = c.comment })
hl("WhichKeyValue",     { fg = c.fg_dark, italic = true })
hl("WhichKeyIcon",      { fg = c.cyan })
hl("WhichKeyFloat",     { bg = c.none })
hl("WhichKeyNormal",    { fg = c.fg_light, bg = c.none })
hl("WhichKeyBorder",    { fg = c.border,   bg = c.none })
hl("WhichKeyTitle",     { fg = c.pink,     bg = c.none, bold = true })

-- Extra Floating Popups — fully transparent, white text
hl("HarpoonWindow", { fg = c.fg_light, bg = c.none })
hl("HarpoonBorder", { fg = c.border,   bg = c.none })
hl("SnacksNormal",  { fg = c.fg_light, bg = c.none })
hl("LazyNormal",    { fg = c.fg_light, bg = c.none })
hl("MasonNormal",   { fg = c.fg_light, bg = c.none })

-- ============================================================
-- ALPHA DASHBOARD
-- ============================================================

hl("AlphaHeader", { fg = c.pink, bold = true })
hl("AlphaButton", { fg = c.fg })
hl("AlphaShortcut", { fg = c.cyan, bold = true })
hl("AlphaFooter", { fg = c.comment, italic = true })

-- ============================================================
-- INDENT GUIDES (IBL)
-- ============================================================

hl("IblIndent", { fg = "#262938", bg = c.none })
hl("IblScope", { fg = c.pink, bg = c.none })
