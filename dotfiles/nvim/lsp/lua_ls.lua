return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        '.git',
    },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            hover = {
                previewFieldsMax = 1000, -- default is 20; this is what's truncating your table
                enumParamsMax = 1000, -- similar cap for enum-like unions
                viewNumber = true,
                viewString = true,
                viewStringMax = 1000,
            },
            diagnostics = {
                -- so it doesn't complain about `vim` global etc. when no .luarc.json overrides it
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
                -- only needed as a fallback; .luarc.json per-project should define its own library
                library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
        },
    },
}
