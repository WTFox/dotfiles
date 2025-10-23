local function toggle_terminal_size()
    local current_win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(current_win)
    local buf_name = vim.api.nvim_buf_get_name(buf)

    if string.match(buf_name, "toggleterm#") then
        local current_width = vim.api.nvim_win_get_width(current_win)
        local total_columns = vim.o.columns
        local win_config = vim.api.nvim_win_get_config(current_win)

        if current_width < total_columns - 2 then
            -- Maximize: remove border and go full size
            win_config.width = total_columns
            win_config.height = vim.o.lines - 1
            win_config.border = "none"
            vim.api.nvim_win_set_config(current_win, win_config)
        else
            -- Restore: add border back and resize
            -- Use the curved border characters array
            win_config.width = math.floor(vim.o.columns * 0.8)
            win_config.height = math.floor(vim.o.lines * 0.8)
            win_config.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
            vim.api.nvim_win_set_config(current_win, win_config)
        end
    end
end

local terminal_cmd = function(cmd)
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = true,
        float_opts = {
            border = "curved",
            width = function()
                return math.floor(vim.o.columns * 0.9)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.9)
            end,
            winblend = 3,
        },
    })
    return function()
        term:toggle()
    end
end

return {
    "akinsho/toggleterm.nvim",
    enabled = false,
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
        { [[<c-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
        { "<M-p>", toggle_terminal_size, mode = "t", desc = "Toggle terminal size" },
        { "<C-[><C-[>", [[<C-\><C-n>]], desc = "Exit terminal mode", mode = "t" },
        {
            "<leader>gg",
            function()
                terminal_cmd("lazygit")()
            end,
            desc = "Open Lazygit",
        },
        {
            "<leader>gf",
            function()
                local file = vim.fn.expand("%")
                if file == "" then
                    print("No file open")
                    return
                end
                terminal_cmd("lazygit -f " .. file)()
            end,
            desc = "File history (lazygit)",
        },
        {
            "<leader>td",
            function()
                terminal_cmd("lazydocker")()
            end,
            desc = "Open Lazydocker",
        },
        {
            "<leader>tc",
            function()
                terminal_cmd("claude")()
            end,
            desc = "Open Claude",
        },
        {
            "<leader>ty",
            function()
                terminal_cmd("btm")()
            end,
            desc = "Open Yazi",
        },
    },
    opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
            border = "curved",
            width = function()
                return math.floor(vim.o.columns * 0.8)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.8)
            end,
        },
    },
}
