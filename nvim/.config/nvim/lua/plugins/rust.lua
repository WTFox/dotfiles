return {
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        inlay_hints = {
          auto = true,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          highlight = "Comment",
        },
        hover_actions = {
          border = "none",
          max_width = nil,
          max_height = nil,
          auto_focus = false,
        },
      },
    },
  },
}
