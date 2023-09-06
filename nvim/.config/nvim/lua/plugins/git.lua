local get_main_branch = function()
  local handle = io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'")
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then
    return ""
  end

  return result:gsub("\n", "")
end

return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = { "tpope/vim-rhubarb" },
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "blame" },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gdd", "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
      {
        "<leader>gdm",
        function()
          local branch = get_main_branch()
          if branch == "" then
            print("Could not get main branch")
            return
          end
          vim.cmd("DiffviewOpen " .. branch)
        end,
        desc = "DiffView main branch",
      },
    },
  },
}
