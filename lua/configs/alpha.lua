local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ============================================================
-- ASCII ART HEADER — motivational banners from headers.txt
-- ------------------------------------------------------------
-- headers.txt holds several banners (figlet "nscript" font), each
-- followed by a line containing only %%. On startup a random banner
-- that fits the window width is shown, colored with a bold
-- catppuccin gradient, plus a random one-line quote under it.
--
--   Add your own banner (needs figlet or pyfiglet):
--     figlet -f nscript "Your Words" >> lua/configs/headers.txt
--     echo "%%" >> lua/configs/headers.txt
-- ============================================================

local headers_path = vim.fn.stdpath("config") .. "/lua/configs/headers.txt"

local quotes = {
	"small commits, every day — that's how systems get built",
	"read the error message. then read it again.",
	"think first. type second.",
	"you don't rise to the level of your goals, you fall to the level of your systems",
	"make it work, make it right, make it fast",
	"the best time to learn it was yesterday. the next best is now.",
	"consistency beats intensity",
	"no zero days",
	"understand it before you automate it",
	"every expert was once a beginner who didn't quit",
	"hard things become easy by doing them often",
	"one more rep. one more commit. one more page.",
}

local function read_headers()
	if vim.fn.filereadable(headers_path) == 0 then
		return {}
	end
	local banners, cur = {}, {}
	for _, line in ipairs(vim.fn.readfile(headers_path)) do
		if line == "%%" then
			if #cur > 0 then
				table.insert(banners, cur)
			end
			cur = {}
		else
			table.insert(cur, line)
		end
	end
	if #cur > 0 then
		table.insert(banners, cur)
	end
	return banners
end

local function width(lines)
	local w = 0
	for _, l in ipairs(lines) do
		w = math.max(w, vim.fn.strdisplaywidth(l))
	end
	return w
end

local function pick_header()
	math.randomseed(os.time())
	local fits = {}
	for _, b in ipairs(read_headers()) do
		if width(b) <= vim.o.columns - 4 then
			table.insert(fits, b)
		end
	end
	local banner = #fits > 0 and fits[math.random(#fits)] or { "keep grinding" }
	local lines = vim.deepcopy(banner)
	table.insert(lines, "")
	local quote = quotes[math.random(#quotes)]
	local pad = math.max(0, math.floor((width(banner) - vim.fn.strdisplaywidth(quote)) / 2))
	table.insert(lines, string.rep(" ", pad) .. quote)
	return lines
end

-- Vertical gradient: each banner line gets its own AlphaHeaderN group
-- (defined in lua/configs/catppuccin.lua); the quote uses AlphaQuote.
local header_lines = pick_header()
local header_hl = {}
for i = 1, #header_lines do
	local group = (i == #header_lines) and "AlphaQuote" or ("AlphaHeader" .. math.min(i, 16))
	header_hl[i] = { { group, 0, -1 } }
end

dashboard.section.header.val = header_lines
dashboard.section.header.opts.hl = header_hl

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
	dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

for _, button in ipairs(dashboard.section.buttons.val) do
	button.opts.hl = "AlphaButton"
	button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.buttons.opts.spacing = 1

dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.section.footer.val = function()
	local ok, stats = pcall(function()
		return require("lazy").stats()
	end)
	if not ok then
		return "󰄛 Neovim Loaded"
	end
	local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
	return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms"
end

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.opt_local.foldenable = false
	end,
})
