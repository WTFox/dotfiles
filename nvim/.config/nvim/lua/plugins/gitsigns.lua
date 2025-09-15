return {
    src = "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
        })
    end,
}
