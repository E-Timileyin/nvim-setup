-- ============================================================
-- TREESITTER CONFIGURATION — lua/configs/treesitter.lua
-- Syntax highlighting, indentation, and language parsing
-- ============================================================

local options = {
	ensure_installed = {
		-- Shell & config
		"bash",
		"toml",
		"yaml",
		"json",
		-- Lua / Vim
		"lua",
		"luadoc",
		"vim",
		"vimdoc",
		-- Web
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"svelte",
		-- PHP (blade = Laravel .blade.php templates)
		"php",
		"php_only",
		"blade",
		-- Go
		"go",
		"gomod",
		"gosum",
		-- Rust / Java (backend, systems)
		"rust",
		"java",
		-- Python / data
		"python",
		"sql",
		-- Cloud / infra
		"dockerfile",
		"terraform",
		"hcl",
		"proto",
		"make",
		"ini",
		"gitignore",
		-- Docs
		"markdown",
		"markdown_inline",
		"printf",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},
}

-- Map .zsh files to use bash parser
vim.filetype.add({
	extension = {
		zsh = "bash",
	},
})

require("nvim-treesitter.configs").setup(options)

-- ============================================================
-- Compat fix: Neovim's treesitter query engine now always hands
-- predicate/directive handlers a list of nodes per capture
-- (table<integer, TSNode[]>), but nvim-treesitter's own
-- query_predicates.lua (as of 2026-03, master) still assumes a
-- single node and indexes `match[capture_id]` directly. That
-- returns the list itself, so calling `:range()`/`:type()`/
-- `:parent()` on it fails with "attempt to call method ... (a nil
-- value)" — breaking markdown fenced-code injection, `is?`,
-- `kind-eq?`, `nth?`, `downcase!`, and `set-lang-from-mimetype!`.
-- Re-register those handlers here, unwrapping the list first.
-- Upstream: https://github.com/nvim-treesitter/nvim-treesitter/issues/8618
-- Safe to remove once nvim-treesitter ships a fix.
-- ============================================================
do
	local query = vim.treesitter.query
	local force = { force = true }

	local function first(v)
		if type(v) == "table" then
			return v[1]
		end
		return v
	end

	local function valid_args(name, pred, count, strict_count)
		local arg_count = #pred - 1
		if strict_count and arg_count ~= count then
			vim.api.nvim_err_writeln(string.format("%s must have exactly %d arguments", name, count))
			return false
		elseif not strict_count and arg_count < count then
			vim.api.nvim_err_writeln(string.format("%s must have at least %d arguments", name, count))
			return false
		end
		return true
	end

	query.add_predicate("nth?", function(match, _pattern, _bufnr, pred)
		if not valid_args("nth?", pred, 2, true) then
			return
		end
		local node = first(match[pred[2]])
		local n = tonumber(pred[3])
		if node and node:parent() and node:parent():named_child_count() > n then
			return node:parent():named_child(n) == node
		end
		return false
	end, force)

	query.add_predicate("is?", function(match, _pattern, bufnr, pred)
		if not valid_args("is?", pred, 2) then
			return
		end
		local locals = require("nvim-treesitter.locals")
		local node = first(match[pred[2]])
		local types = { unpack(pred, 3) }
		if not node then
			return true
		end
		local _, _, kind = locals.find_definition(node, bufnr)
		return vim.tbl_contains(types, kind)
	end, force)

	query.add_predicate("kind-eq?", function(match, _pattern, _bufnr, pred)
		if not valid_args(pred[1], pred, 2) then
			return
		end
		local node = first(match[pred[2]])
		local types = { unpack(pred, 3) }
		if not node then
			return true
		end
		return vim.tbl_contains(types, node:type())
	end, force)

	local html_script_type_languages = {
		["importmap"] = "json",
		["module"] = "javascript",
		["application/ecmascript"] = "javascript",
		["text/ecmascript"] = "javascript",
	}

	query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
		local node = first(match[pred[2]])
		if not node then
			return
		end
		local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
		local configured = html_script_type_languages[type_attr_value]
		if configured then
			metadata["injection.language"] = configured
		else
			local parts = vim.split(type_attr_value, "/", {})
			metadata["injection.language"] = parts[#parts]
		end
	end, force)

	local non_filetype_match_injection_language_aliases = {
		ex = "elixir",
		pl = "perl",
		sh = "bash",
		uxn = "uxntal",
		ts = "typescript",
	}

	local function get_parser_from_markdown_info_string(injection_alias)
		local match = vim.filetype.match({ filename = "a." .. injection_alias })
		return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
	end

	query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
		local node = first(match[pred[2]])
		if not node then
			return
		end
		local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
		metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
	end, force)

	query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
		local id = pred[2]
		local node = first(match[id])
		if not node then
			return
		end
		local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
		metadata[id] = metadata[id] or {}
		metadata[id].text = string.lower(text)
	end, force)
end
