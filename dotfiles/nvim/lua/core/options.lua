-- General Settings
vim.o.title = true
vim.o.titlestring = "NVIM - %f"
vim.opt.number = true         -- line numbers
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.cursorline = true     -- highlight the current line
vim.opt.wrap = false          -- display lines as one long line
vim.opt.scrolloff = 10        -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8     -- minimal number of screen columns on the side of the cursor
vim.o.showtabline = 1         -- Show tab line(or buffers with mini-tabline plugin)

-- Indentation
vim.opt.tabstop = 4        -- Tab width
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 4    -- Number of spaces that a tab counts for while performing editing operations
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.autoindent = true  -- copy indent from current line when starting new one

-- Search Settings
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true  -- smart case
vim.opt.hlsearch = true   -- Set highlight on search
vim.opt.incsearch = true  -- Show matches as you type

-- Visual Settings
vim.opt.winborder = 'rounded'                     -- Borders of floating windows
vim.opt.termguicolors = true                      -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                        -- Keep signcolumn on by default
vim.opt.cmdheight = 1                             -- more space in the neovim command line for displaying messages
vim.opt.completeopt = "menuone,noinsert,noselect" -- Set completeopt to have a better completion experience
vim.opt.showmode = false                          -- we don't need to see things like -- INSERT -- anymore
vim.opt.pumheight = 10                            -- pop up menu height
vim.opt.pumblend = 10                             -- pop up menu transparency
vim.opt.winblend = 10                             -- floating window transparency
vim.opt.conceallevel = 0                          -- so that `` is visible in markdown files
-- File Handling
vim.opt.backup = false                            -- creates a backup file
vim.opt.writebackup = false                       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false                          -- creates a swapfile
vim.opt.undofile = true                           -- Save undo history
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 250                          -- Decrease update time
vim.opt.timeoutlen = 300                          -- time to wait for a mapped sequence to complete (in milliseconds)
-- Behaviour Settings
vim.opt.backspace = "indent,eol,start"            -- allow backspace on
vim.opt.iskeyword:append("-")                     -- hyphenated words recognized by searches
vim.opt.mouse = "a"                               -- Enable mouse mode
vim.opt.clipboard:append("unnamedplus")           -- Use system clipboard
vim.opt.fileencoding = "UTF-8"                    -- the encoding written to a file
vim.o.breakindent = true                          -- Enable break indent
vim.o.splitright = true                           -- Open new split on right
vim.o.splitbelow = true                           -- Open new split on below
-- Diagnostics
local diagnostics_signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostics_signs.Error,
            [vim.diagnostic.severity.WARN] = diagnostics_signs.Warn,
            [vim.diagnostic.severity.HINT] = diagnostics_signs.Hint,
            [vim.diagnostic.severity.INFO] = diagnostics_signs.Info,
        },
    },
})
