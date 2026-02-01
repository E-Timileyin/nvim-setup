-- ~/.config/nvim/lua/configs/treesitter.lua

local options = {
    ensure_installed = {
        "bash",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
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
vim.filetype.add {
    extension = {
        zsh = "bash",
    },
}

-- Setup Treesitter with options
require("nvim-treesitter.configs").setup(options)