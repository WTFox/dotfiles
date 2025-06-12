local Config = require("noice.config")

return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = false,
    },
    cmdline = {
      view = "cmdline",
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          find = "Toggling hidden files",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
      {
        view = "notify",
        filter = {
          event = "msg_show",
          kind = { "", "echo", "echomsg", "lua_print", "list_cmd", "shell_out", "shell_err", "shell_ret" },
        },
        opts = { replace = true, merge = true, title = "Messages" },
      },
    },
  },
}
