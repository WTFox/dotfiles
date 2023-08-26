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

local main_branch = get_main_branch()
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
      { "<leader>gdm", "<cmd>DiffviewOpen " .. main_branch .. "<CR>", desc = "DiffView (" .. main_branch .. ")" },
    },
  },
}
