return { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({
            -- Language parsers
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                "lua",
                "luadoc",
                "query",
                "vim",
                "vimdoc",
                "java",
                "go",
                "javascript",
                "jsx",
                "typescript",
                "tsx",
                "rust"
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            sync_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },


        })
    end
}
