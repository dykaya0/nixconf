return {
    cmd = {
        vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid()),
    },

    filetypes = { "cs" },

    root_markers = {
        "*.sln",
        "*.csproj",
        ".git"
    },
}
