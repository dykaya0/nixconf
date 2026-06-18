return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },

        appearance = {
            nerd_font_variant = 'mono',
            kind_icons = {
                Text = '󰉿',
                Method = '󰊕',
                Function = '󰊕',
                Constructor = '󰒓',

                Field = '󰜢',
                Variable = '󰆦',
                Property = '󰖷',

                Class = '󱡠',
                Interface = '󱡠',
                Struct = '󱡠',
                Module = '󰅩',

                Unit = '󰪚',
                Value = '󰦨',
                Enum = '󰦨',
                EnumMember = '󰦨',

                Keyword = '󰻾',
                Constant = '󰏿',

                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },

        signature = {
            enabled = true,
            trigger = {
                -- Show the signature help automatically
                enabled = true,
                -- Show the signature help window after typing any of alphanumerics, `-` or `_`
                show_on_keyword = false,
                blocked_trigger_characters = {},
                blocked_retrigger_characters = {},
                -- Show the signature help window after typing a trigger character
                show_on_trigger_character = true,
                -- Show the signature help window when entering insert mode
                show_on_insert = false,
                -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
                show_on_insert_on_trigger_character = true,
            },
            window = {
                min_width = 1,
                max_width = 100,
                max_height = 10,
                border = nil,
                winblend = 0,
                winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
                scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
                -- Which directions to show the window,
                -- falling back to the next direction when there's not enough space,
                -- or another window is in the way
                direction_priority = { 'n', 's' },
                -- Can accept a function if you need more control
                -- direction_priority = function()
                --   if condition then return { 'n', 's' } end
                --   return { 's', 'n' }
                -- end,

                -- Disable if you run into performance issues
                treesitter_highlighting = true,
                show_documentation = true,
            },
        },

        completion = {
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 500
            },
            ghost_text = { enabled = false },
            -- example: 'foo_<CURSOR>_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
            keyword = { range = 'full' },
            -- Select by default, auto insert on selection
            list = {
                selection = {
                    preselect = true, auto_insert = true
                }
            },
            menu = {
                -- Automatically show the completion menu
                auto_show = true,

                -- nvim-cmp style menu
                draw = {
                    columns = {
                        { "label",      "label_description", gap = 1 },
                        { "kind_icon",  "kind" },
                        { "source_name" }
                    },
                }
            },
        },
        sources = {
            providers = {
                lsp = {
                    enabled = true, -- Whether or not to enable the provider
                    name = 'LSP',
                    module = 'blink.cmp.sources.lsp',
                    fallbacks = { 'BUFFER' },
                    score_offset = 10,        -- Boost/penalize the score of the items

                    async = true,             -- Whether we should show the completions before this provider returns, without waiting for it
                    timeout_ms = 5000,        -- How long to wait for the provider to return before showing completions and treating it as asynchronous
                    transform_items = nil,    -- Function to transform the items before they're returned
                    should_show_items = true, -- Whether or not to show the items
                    max_items = nil,          -- Maximum number of items to display in the menu
                    min_keyword_length = 0,   -- Minimum number of characters in the keyword to trigger the provider
                    override = nil,           -- Override the source's functions

                    opts = { tailwind_color_icon = '██' },
                },

                path = {
                    enabled = true,
                    name = 'PATH',
                    module = 'blink.cmp.sources.path',
                    fallbacks = { 'BUFFER' },
                    score_offset = 3,
                    opts = {
                        trailing_slash = true,
                        label_trailing_slash = true,
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                        show_hidden_files_by_default = true,
                        -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
                        ignore_root_slash = false,
                        -- Maximum number of files/directories to return. This limits memory use and responsiveness for very large folders.
                        max_entries = 10000,
                    }
                },

                snippets = {
                    enabled = true,
                    name = 'SNIPPETS',
                    module = 'blink.cmp.sources.snippets',
                    score_offset = 7,

                    opts = {
                        friendly_snippets = true,
                        search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                        global_snippets = { 'all' },
                        extended_filetypes = {},
                        filter_snippets = function(filetype, file) return true end,
                        get_filetype = function(context)
                            return vim.bo.filetype
                        end,
                        -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
                        clipboard_register = nil,
                        -- Whether to put the snippet description in the label description
                        use_label_description = false,
                    }

                },

                buffer = {
                    enabled = true,
                    name = 'BUFFER',
                    module = 'blink.cmp.sources.buffer',
                    score_offset = 5,
                    opts = {
                        -- default to all visible buffers
                        get_bufnrs = function()
                            return vim
                                .iter(vim.api.nvim_list_wins())
                                :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                                :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                                :totable()
                        end,
                        -- buffers when searching with `/` or `?`
                        get_search_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
                        -- Maximum total number of characters (in an individual buffer) for which buffer completion runs synchronously. Above this, asynchronous processing is used.
                        max_sync_buffer_size = 20000,
                        -- Maximum total number of characters (in an individual buffer) for which buffer completion runs asynchronously. Above this, the buffer will be skipped.
                        max_async_buffer_size = 200000,
                        -- Maximum text size across all buffers (default: 500KB)
                        max_total_buffer_size = 500000,
                        -- Order in which buffers are retained for completion, up to the max total size limit (see above)
                        retention_order = { 'focused', 'visible', 'recency', 'largest' },
                        -- Cache words for each buffer which increases memory usage but drastically reduces cpu usage. Memory usage depends on the size of the buffers from `get_bufnrs`. For 100k items, it will use ~20MBs of memory. Invalidated and refreshed whenever the buffer content is modified.
                        use_cache = true,
                        -- Whether to enable buffer source in substitute (:s), global (:g) and grep commands (:grep, :vimgrep, etc.).
                        -- Note: Enabling this option will temporarily disable Neovim's 'inccommand' feature
                        -- while editing Ex commands, due to a known redraw issue (see neovim/neovim#9783).
                        -- This means you will lose live substitution previews when using :s, :smagic, or :snomagic
                        -- while buffer completions are active.
                        enable_in_ex_commands = false,
                    }
                },

                cmdline = {
                    enabled = true,
                    name = 'cmdline',
                    module = 'blink.cmp.sources.cmdline',
                    score_offset = 1,
                },
            },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
    }
}
