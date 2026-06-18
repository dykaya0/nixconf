return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
    },
    settings = {
        typescript = {
            indentStyle = "space",
            indentSize = 2,
        },
    },
}
