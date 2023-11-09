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
      {
        "<leader>gB",
        function()
          if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
            vim.cmd("'<,'>GBrowse")
          else
            vim.cmd("GBrowse")
          end
        end,
        mode = { "n", "v" },
        desc = "Open on Github",
      },
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
    {
      "pwntester/octo.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      event = "BufRead",
      config = true,
      keys = {
        { "<leader>gpc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
        { "<leader>gpo", "<cmd>!gh pr view --web<cr>", desc = "Open on github" },
      },
    },
  },
}
