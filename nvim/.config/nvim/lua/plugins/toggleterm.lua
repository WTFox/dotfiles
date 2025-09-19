local function toggle_terminal_size()
    local current_win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(current_win)
    local buf_name = vim.api.nvim_buf_get_name(buf)

    if string.match(buf_name, "toggleterm#") then
        local current_width = vim.api.nvim_win_get_width(current_win)
        local total_columns = vim.o.columns

        if current_width < total_columns - 2 then
            vim.api.nvim_win_set_width(current_win, total_columns)
            vim.api.nvim_win_set_height(current_win, vim.o.lines - 2)
        else
            vim.api.nvim_win_set_width(current_win, math.floor(vim.o.columns * 0.8))
            vim.api.nvim_win_set_height(current_win, math.floor(vim.o.lines * 0.8))
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
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            winblend = 3,
        },
    })
    return function()
        term:toggle()
    end
end

return {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
        { [[<c-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
        { "<M-p>", toggle_terminal_size, mode = "t", desc = "Toggle terminal size" },
        {
            "<leader>gg",
            function()
                terminal_cmd("lazygit")()
            end,
            desc = "Open Lazygit",
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
        {
            "<leader>cc",
            function()
                local buf = vim.api.nvim_get_current_buf()
                local filepath = vim.api.nvim_buf_get_name(buf)
                local start_line = vim.fn.line("'<")
                local end_line = vim.fn.line("'>")
                local selected_text =
                    table.concat(vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false), "\n")
                local ctx = string.format(
                    "File: %s\nLines: %d-%d\nSelection:\n%s",
                    filepath,
                    start_line,
                    end_line,
                    selected_text
                )
                vim.ui.input({ prompt = "Enter Claude prompt: " }, function(input)
                    if input then
                        local prompt = ctx .. "\n\n-----\n\nQuestion: " .. input
                        local temp_file = vim.fn.tempname() .. ".md"
                        local cmd = string.format(
                            "echo %s | claude -p > %s && nvim -c 'nnoremap <buffer> q :q!<CR>' %s",
                            vim.fn.shellescape(prompt),
                            temp_file,
                            temp_file
                        )
                        terminal_cmd(cmd)()
                    end
                end)
            end,
            mode = { "x", "v", "n" },
        },
    },
    opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
        },
    },
}
