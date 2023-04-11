return {
  "nvim-neotest/neotest",
  enabled = true,
  dependencies = {
    "nvim-neotest/neotest-python",
    "haydenmeade/neotest-jest",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-go",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
  config = function()
    ---@ neotest.Config
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
        require("neotest-jest"),
        require("neotest-rust"),
        require("neotest-go"),
      },
      quickfix = {
        enabled = false,
      },
      output = {
        enabled = true,
        open_on_run = true,
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test file" },
    { "<leader>tl", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
        local win = vim.fn.bufwinid("Neotest Summary")
        if win > -1 then
          vim.api.nvim_set_current_win(win)
        end
      end,
      desc = "Summary",
    },
  },
}
