require("grapple").setup({
    icons = false,
})

require("grug-far").setup({
    -- Whether to show the prompt when picking a file
    show_prompt = true,
    -- Whether to open the file in a new tab
    open_in_new_tab = false,
})

require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 3,
    },
})

local terminal_cmd = function(cmd)
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = true,
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            winblend = 3,
        },
    })
    return function()
        term:toggle()
    end
end

vim.keymap.set("n", "<leader>gg", function()
    terminal_cmd("lazygit")()
end, { desc = "Open Lazygit" })

vim.keymap.set("n", "<leader>dd", function()
    terminal_cmd("lazydocker")()
end, { desc = "Open Lazydocker" })
