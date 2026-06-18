-- set common commands case insensitive
vim.api.nvim_create_user_command("W", "w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", "q", { nargs = 0 })
vim.api.nvim_create_user_command("WQ", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("Wq", "wq", { nargs = 0 })
vim.api.nvim_create_user_command("WA", "wa", { nargs = 0 })
vim.api.nvim_create_user_command("Wa", "wa", { nargs = 0 })

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

-- LSP Keymaps (These global keymaps are created unconditionally when nvim starts)
-- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
-- "gri" is mapped to vim.lsp.buf.implementation()
-- "grn" is mapped to vim.lsp.buf.rename()
-- "grr" is mapped to vim.lsp.buf.references()
-- "grt" is mapped to vim.lsp.buf.type_definition()
-- "gO" is mapped to vim.lsp.buf.document_symbol()
-- CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
-- "an" and "in" (Visual and Operator-pending mode) are mapped to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()

vim.keymap.set("n", "<leader><Tab>", function()
    local is_enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not is_enabled)
    print('Diagnostics Enabled: ' .. tostring(not is_enabled))
end, { desc = 'Toggle diagnostics' })

vim.keymap.set("n", "D", function()
    local funcOpts = {
        focusable = false,
        scope = 'cursor',
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
    }
    vim.diagnostic.open_float(nil, funcOpts)
end, { desc = 'Toggle floating diagnostics on cursor' })

-- Select all file
vim.keymap.set("n", "vga", "ggVG", opts)


-- Copy file path with line number into clipboard
vim.keymap.set('n', '<leader>n', function()
    local s = vim.fn.expand('%:p') .. ':' .. vim.fn.line('.')
    vim.fn.setreg('+', s)
    print('Copied: ' .. s)
end, { desc = 'Copy path:line' })

-- Open oil.nvim file explorer as floating window
vim.keymap.set("n", "`", function()
    require("oil").toggle_float()
end, { desc = "Toggle Oil floating window" })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({}) <CR>", opts)

vim.keymap.set("n", "<leader>x", "<cmd>%!bash<CR>", opts)

-- Center screen when vertical scroll and find
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)   -- vertical split
vim.keymap.set("n", "<leader>ss", ":close<CR>", opts)    -- close current split window
vim.keymap.set("n", "<leader>sr", ":wincmd R<CR>", opts) -- Shift vertical splits to left

-- Buffers
vim.keymap.set({ "n", "v" }, "<leader>b", ":bdelete<CR>", opts)

--- Navigate
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", opts)
--- Resize
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move line up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)     -- Move line down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)     -- Move line up

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts) -- Move selection down
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts) -- Move selection up

-- Better J Behaviour
vim.keymap.set({ "n", "v" }, "J", "mzJ`z", opts) -- Join lines and keep cursor position

-- Paste from unnamed register (only yanked)
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', opts)

-- Paste from + register (system clipboard)
vim.keymap.set({ "n", "v" }, "<A-p>", '"+p', opts)

-- Delete character into the blackhole register
vim.keymap.set({ "n", "v" }, "x", '"_x', opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
