-- return {
--   "echasnovski/mini.surround",
--   opts = {
--     mappings = {
--       add = "gsa",
--       delete = "gsd",
--       find = "gsf",
--       find_left = "gsF",
--       highlight = "gsh",
--       replace = "gsr",
--       update_n_lines = "gsn",
--     },
--   },
-- }

return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  opts = {
    mappings = {
      replace = "cs",
      add = "ys",
      delete = "ds",
      highlight = "vs",
      find = "yf",
      find_left = "yF",
      update_n_lines = "",
    },
    search_method = "cover_or_next",
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)
  end,
}
