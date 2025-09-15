return {
    src = "https://github.com/cbochs/grapple.nvim",
    config = function()
        require("grapple").setup({
            icons = false,
        })

        for i = 1, 9 do
            vim.keymap.set(
                "n",
                "<leader>" .. i,
                "<cmd>Grapple select index=" .. i .. "<cr>",
                { desc = "Grapple select " .. i }
            )
        end
    end,
}
