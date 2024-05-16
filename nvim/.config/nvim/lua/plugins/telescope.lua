return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git", "**/migrations/*" },
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
      vimgrep_arguments = {
        "rg",
        "-L",
        -- "--color=never",
        "--follow", -- Follow symbolic links
        "--hidden", -- Search for hidden files
        "--no-heading", -- Don't group matches by each file
        "--with-filename", -- Print the file path with the matched lines
        "--line-number", -- Show line numbers
        "--column", -- Show column numbers
        "--smart-case", -- Smart case search

        -- Exclude some patterns from search
        "--glob=!**/node_modules/*",
        "--glob=!**/*venv/*",
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      path_display = {
        "filename_first",
        "truncate",
      },
      winblend = 0,
      -- border = {},
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  },
}
