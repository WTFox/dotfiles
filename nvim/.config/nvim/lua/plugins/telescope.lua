return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
        },
        n = {
          ["j"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["k"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
    },
  },
}
