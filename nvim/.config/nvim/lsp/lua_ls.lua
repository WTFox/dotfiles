---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.4",
            },
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
                severity = {
                    ["inject-field"] = "Error",
                    ["missing-fields"] = "Error",
                },
                neededFileStatus = {
                    ["inject-field"] = "Opened",
                    ["missing-fields"] = "Opened",
                    ["type-check"] = "Opened",
                },
            },
            type = {
                checkTableShape = true,
                weakNilCheck = false,
                weakUnionCheck = false,
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },
}
