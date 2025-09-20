return {
    "wtfox/claude-chat.nvim",
    config = true,
    dev = true,
    keys = {
        { "<leader>cc", ":ClaudeChat<CR>", desc = "Claude Chat", mode = { "n", "v" } },
        { "<leader>cq", ":ClaudeChat explain this code<CR>", mode = { "n", "v" }, desc = "Quick Claude explanation" },
    },
}
