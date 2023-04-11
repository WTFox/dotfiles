return {
  "nvim-neotest/neotest",
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
      summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "o",
          mark = { "m", "<space>" },
          next_failed = "J",
          output = "O",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
        },
        open = "botright vsplit | vertical resize 50",
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test file" },
    { "<leader>tl", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
    { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
    -- { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
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
    {
      "<leader>tNF",
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      desc = "Debug File",
    },
    { "<leader>tNa", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
    { "<leader>tNs", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
  },
}
