return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = {
      enabled = true,
    },
    filetypes = {
      markdown = true,
      help = true,
      text = false,
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          return false
        end
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.envrc.*") then
          return false
        end
        return true
      end,
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "no", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      allow_insecure = false,
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
      temperature = 0.1,
    },
    event = "VeryLazy",
    keys = {
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>ap",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = { "n", "v", "x" } },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code", mode = { "n", "v", "x" } },
      {
        "<F1>",
        "<cmd>CopilotChatToggle<cr>",
        desc = "CopilotChat - Open in vertical split",
      },
      -- Custom input for CopilotChat
      {
        "<leader>ai",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Debug
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
  },
}
