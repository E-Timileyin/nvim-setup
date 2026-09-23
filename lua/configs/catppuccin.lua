-- ============================================================
-- THEME — lua/configs/catppuccin.lua
-- Catppuccin Mocha (matches kitty: ~/.config/kitty/catppuccin-mocha.conf)
--
-- Full catppuccin syntax colors by default (pastel, no bold).
-- <leader>ts switches to muted: code plain text, keywords grey,
-- comments dim, strings the only accent.
-- ============================================================

-- Off by default; <leader>ts flips it for the session
if vim.g.muted_syntax == nil then
  vim.g.muted_syntax = false
end

require("catppuccin").setup {
  flavour = "mocha",
  -- Solid Mocha base (#1e1e2e), same as kitty's background, no glass
  transparent_background = false,
  term_colors = true,
  no_bold = true,
  styles = {
    comments = { "italic" },
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  custom_highlights = function(c)
    -- Dashboard banner: bold vertical gradient mauve → pink → flamingo → peach
    local stops = { c.mauve, c.pink, c.flamingo, c.peach }
    local function lerp(a, b, t)
      local function ch(hex, i) return tonumber(hex:sub(i, i + 1), 16) end
      local out = "#"
      for i = 2, 6, 2 do
        out = out .. string.format("%02x", math.floor(ch(a, i) + (ch(b, i) - ch(a, i)) * t + 0.5))
      end
      return out
    end
    local hl = {}
    for n = 1, 16 do
      local pos = (n - 1) / 15 * (#stops - 1)
      local i = math.min(math.floor(pos) + 1, #stops - 1)
      hl["AlphaHeader" .. n] = { fg = lerp(stops[i], stops[i + 1], pos - (i - 1)), bold = true }
    end
    return vim.tbl_extend("force", hl, {
      AlphaQuote = { fg = c.lavender, italic = true },
      AlphaHeader = { fg = c.mauve, bold = true },
      AlphaButton = { fg = c.text },
      WinBar = { fg = c.subtext0 },
      WinBarNC = { fg = c.overlay0 },
    })
  end,
}

-- ── Muted syntax ────────────────────────────────────────────
local legacy_plain = {
  "Identifier", "Function", "Type", "Constant", "Number", "Boolean", "Float",
  "Operator", "Special", "SpecialChar", "PreProc", "Define", "Macro", "Label",
  "Structure", "Typedef", "Tag", "Delimiter",
}
local legacy_keyword = {
  "Keyword", "Statement", "Conditional", "Repeat", "Include", "Exception", "StorageClass",
}

local function mute()
  if not vim.g.muted_syntax then
    return
  end
  local c = require("catppuccin.palettes").get_palette "mocha"
  local set = vim.api.nvim_set_hl
  local plain = { fg = c.text }
  local keyword = { fg = c.subtext0 }
  local punct = { fg = c.overlay2 }
  local str = { fg = c.green }
  local comment = { fg = c.overlay0, italic = true }

  for name in pairs(vim.api.nvim_get_hl(0, {})) do
    -- Treesitter + LSP semantic token groups; leave markdown/diff/comment/string alone
    if name:sub(1, 1) == "@" and not name:find "^@markup" and not name:find "^@diff" then
      if name:find "comment" then
        -- keep @comment.todo/.error/.warning colors, dim plain comments
        if name == "@comment" or name == "@lsp.type.comment" then
          set(0, name, comment)
        end
      elseif name:find "string" or name:find "character" then
        set(0, name, str)
      elseif name:find "keyword" or name:find "conditional" or name:find "repeat" then
        set(0, name, keyword)
      elseif name:find "punctuation" then
        set(0, name, punct)
      else
        set(0, name, plain)
      end
    end
  end

  for _, g in ipairs(legacy_plain) do
    set(0, g, plain)
  end
  for _, g in ipairs(legacy_keyword) do
    set(0, g, keyword)
  end
  set(0, "String", str)
  set(0, "Character", str)
  set(0, "Comment", comment)
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "catppuccin*",
  callback = mute,
})

vim.api.nvim_create_user_command("SyntaxToggle", function()
  vim.g.muted_syntax = not vim.g.muted_syntax
  vim.cmd.colorscheme "catppuccin-mocha"
  vim.notify("Syntax: " .. (vim.g.muted_syntax and "muted" or "full color"))
end, { desc = "Toggle muted / full-color syntax" })

vim.cmd.colorscheme "catppuccin-mocha"
