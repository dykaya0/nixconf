local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
--     desc = "Open diagnostic floating window on cursor hold",
--     callback = function()
--         local opts = {
--             focusable = false,
--             scope = 'cursor',
--             close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
--         }
--         vim.diagnostic.open_float(nil, opts)
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     callback = function()
--         -- vim.diagnostic.enable(false)
--         vim.diagnostic.config({
--             virtual_text = false,
--             signs = false,
--             underline = false,
--         })
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     callback = function()
--         -- vim.diagnostic.enable(true)
--         vim.diagnostic.config({
--             virtual_text = true,
--             signs = true,
--             underline = true,
--         })
--     end,
-- })

vim.api.nvim_create_autocmd('FileType', {
    desc = "Autostart treesitter",
    pattern = { '<filetype>' },
    callback = function()
        vim.treesitter.start()
    end,
})


vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    desc = "Auto-close terminal when process exits",
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

-- local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 	group = highlight_augroup,
-- 	callback = function()
--         vim.lsp.buf.document_highlight
--     end,
-- })

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 	group = highlight_augroup,
-- 	callback = vim.lsp.buf.clear_references,
-- })

vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Return to last edit position when opening files",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        local line = mark[1]
        local ft = vim.bo.filetype
        if
            line > 0
            and line <= lcount
            and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1
            and not vim.o.diff
        then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false,
}

local function FloatingTerminal()
    -- If terminal is already open, close it (toggle behavior)
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    -- Create buffer if it doesn't exist or is invalid
    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        -- Set buffer options for better terminal experience
        vim.api.nvim_buf_set_option(terminal_state.buf, "bufhidden", "hide")
    end

    -- Calculate window dimensions
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    -- Set transparency for the floating window
    vim.api.nvim_win_set_option(terminal_state.win, "winblend", 0)

    -- Set transparent background for the window
    vim.api.nvim_win_set_option(
        terminal_state.win,
        "winhighlight",
        "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
    )

    -- Define highlight groups for transparency
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    -- Start terminal if not already running
    local has_terminal = false
    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    for _, line in ipairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    -- Set up auto-close on buffer leave
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true,
    })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
    if terminal_state.is_open then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })
