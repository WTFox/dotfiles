local api_key_cmd = "op read op://Personal/OpenAI/apikey --no-newline"
if vim.fn.executable("wsl.exe") == 1 then
  api_key_cmd = ""
end

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  opts = {
    api_key_cmd = api_key_cmd,
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
  },
}
