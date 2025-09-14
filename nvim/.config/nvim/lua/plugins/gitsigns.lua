if true then
    return {}
end
return {
    url = "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signcolumn = false,
        })
    end,
}

