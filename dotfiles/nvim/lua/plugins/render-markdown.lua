return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        enabled = true,
        render_modes = { 'n', 'c', 't' },
        -- Milliseconds that must pass before updating marks, updates occur.
        -- within the context of the visible window, not the entire buffer.
        debounce = 100,
        -- Pre configured settings that will attempt to mimic various target user experiences.
        -- User provided settings will take precedence.
        -- | obsidian | mimic Obsidian UI                                          |
        -- | lazy     | will attempt to stay up to date with LazyVim configuration |
        -- | none     | does nothing                                               |
        preset = 'none',
        -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'.
        -- Only intended to be used for plugin development / debugging.
        log_level = 'error',
        -- Print runtime of main update method.
        -- Only intended to be used for plugin development / debugging.
        log_runtime = false,
        -- Filetypes this plugin will run on.
        file_types = { 'markdown' },
        -- Maximum file size (in MB) that this plugin will attempt to render.
        -- File larger than this will effectively be ignored.
        max_file_size = 10.0,
        -- Takes buffer as input, if it returns true this plugin will not attach to the buffer.
        ignore = function()
            return false
        end,
        -- Whether markdown should be rendered when nested inside markdown, i.e. markdown code block
        -- inside markdown file.
        nested = true,
        -- Additional events that will trigger this plugin's render loop.
        change_events = {},
        -- Whether the treesitter highlighter should be restarted after this plugin attaches to its
        -- first buffer for the first time. May be necessary if this plugin is lazy loaded to clear
        -- highlights that have been dynamically disabled.
        restart_highlighter = false,
        injections = {
            -- Out of the box language injections for known filetypes that allow markdown to be interpreted
            -- in specified locations, see :h treesitter-language-injections.
            -- Set enabled to false in order to disable.

            gitcommit = {
                enabled = true,
                query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
            },
        },
        patterns = {
            -- Highlight patterns to disable for filetypes, i.e. lines concealed around code blocks

            markdown = {
                disable = true,
                directives = {
                    { id = 17, name = 'conceal_lines' },
                    { id = 18, name = 'conceal_lines' },
                },
            },
        },
        anti_conceal = {
            -- This enables hiding added text on the line the cursor is on.
            enabled = true,
            -- Modes to disable anti conceal feature.
            disabled_modes = false,
            -- Number of lines above cursor to show.
            above = 3,
            -- Number of lines below cursor to show.
            below = 3,
            -- Which elements to always show, ignoring anti conceal behavior. Values can either be
            -- booleans to fix the behavior or string lists representing modes where anti conceal
            -- behavior will be ignored. Valid values are:
            --   bullet
            --   callout
            --   check_icon, check_scope
            --   code_background, code_border, code_language
            --   dash
            --   head_background, head_border, head_icon
            --   indent
            --   latex
            --   link
            --   quote
            --   sign
            --   table_border
            --   virtual_lines
            ignore = {
                code_background = true,
            },
        },
        padding = {
            -- Highlight to use when adding whitespace, should match background.
            highlight = 'Normal',
        },
    },
}
