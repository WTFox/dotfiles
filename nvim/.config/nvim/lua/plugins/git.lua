_G.get_main_branch = function()
  local handle = io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'")
  if not handle then
    return nil
  end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then
    return nil
  end

  return result:gsub("\n", "")
end

return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "blame" },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gdd", "<cmd>DiffviewOpen<CR>", desc = "DiffView" },
      { "<leader>gdm", "<cmd>DiffviewOpen " .. _G.get_main_branch() .. "<CR>", desc = "DiffView (main)" },
    },
  },
}
