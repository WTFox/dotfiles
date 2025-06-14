return {
  cmd = {
    "lua-language-server",
  },
  filetypes = {
    "lua",
  },
  root_markers = {
    ".git",
    ".luacheckrc",
    ".luarc.json",
    ".luarc.jsonc",
    ".stylua.toml",
    "selene.toml",
    "selene.yml",
    "stylua.toml",
  },
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = true,
        library = {
          vim.env.VIMRUNTIME,
          -- Add paths for better workspace detection
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
      format = { enable = true },
      diagnostics = {
        globals = { "vim" }, -- Recognize vim global
        disable = { "missing-parameters", "missing-fields" },
      },
      semantic = {
        enable = true,
        keyword = false,
      },
    },
  },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}
