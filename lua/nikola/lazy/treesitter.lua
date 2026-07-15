return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            require("nvim-treesitter").install({
                "lua",
                "c",
                "haskell",
                "typescript",
                "javascript",
                "vimdoc",
                "jsdoc",
                "bash",
                "templ",
            })

            -- Enable treesitter highlighting
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ok, lang = pcall(vim.treesitter.language.get_lang, args.match)

                    if ok and lang then
                        pcall(vim.treesitter.start, args.buf, lang)
                    end
                end,
            })

            -- Custom templ filetype mapping
            vim.treesitter.language.register("templ", "templ")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
            })
        end,
    },
}
