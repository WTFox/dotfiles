return {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signcolumn = false,
            numhl = true,
            linehl = false,
            word_diff = false,
        })
    end,
}
