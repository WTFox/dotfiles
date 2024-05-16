local Utils = require("utils")

local model = "gpt-4-1106-preview"

local api_key_cmd = ""
if Utils.is_executable("op") then
  api_key_cmd = "op read op://Personal/OpenAI/apikey --no-newline"
else
  api_key_cmd = ""
end

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  enabled = false,
  opts = {
    api_key_cmd = api_key_cmd,
    openai_params = {
      model = model,
      max_tokens = 1000,
    },
    openai_edit_params = {
      model = model,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>oc", "<cmd>ChatGPT<CR>", desc = "ChatGPT", mode = { "n", "v", "x" } },
    { "<leader>oa", "<cmd>ChatGPTActAs<CR>", desc = "ChatGPT Act As", mode = { "n", "v", "x" } },
    { "<leader>oC", "<cmd>ChatGPTCompleteCode<CR>", desc = "ChatGPT Complete Code", mode = { "n", "v", "x" } },
    { "<leader>oe", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v", "x" } },
    { "<leader>og", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v", "x" } },
    { "<leader>ot", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v", "x" } },
    { "<leader>ok", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v", "x" } },
    { "<leader>od", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v", "x" } },
    { "<leader>oA", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v", "x" } },
    { "<leader>oo", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v", "x" } },
    { "<leader>os", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v", "x" } },
    { "<leader>ob", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v", "x" } },
    { "<leader>ox", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v", "x" } },
    {
      "<leader>ol",
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      desc = "Code Readability Analysis",
      mode = { "n", "v", "x" },
    },
  },
}
