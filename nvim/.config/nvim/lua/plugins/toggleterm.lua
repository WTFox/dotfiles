return {
    url = "https://github.com/akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-\>]],
            direction = "float",
            float_opts = {
                border = "curved",
                width = math.floor(vim.o.columns * 0.8),
                height = math.floor(vim.o.lines * 0.8),
                -- winblend = 3,
            },
        })

        -- Toggle between normal and maximized floating terminal
        local function toggle_terminal_size()
            local current_win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_win_get_buf(current_win)
            local buf_name = vim.api.nvim_buf_get_name(buf)

            -- Check if we're in a toggleterm buffer
            if string.match(buf_name, "toggleterm#") then
                local current_width = vim.api.nvim_win_get_width(current_win)
                local total_columns = vim.o.columns

                -- If currently at 80% width, maximize; otherwise go to 80%
                if current_width < total_columns - 2 then
                    -- Maximize
                    vim.api.nvim_win_set_width(current_win, total_columns)
                    vim.api.nvim_win_set_height(current_win, vim.o.lines - 2)
                else
                    -- Return to normal size
                    vim.api.nvim_win_set_width(
                        current_win,
                        math.floor(vim.o.columns * 0.8)
                    )
                    vim.api.nvim_win_set_height(
                        current_win,
                        math.floor(vim.o.lines * 0.8)
                    )
                end
            end
        end

        -- Set the keymap for terminal mode
        vim.keymap.set(
            "t",
            "<M-p>",
            toggle_terminal_size,
            { desc = "Toggle terminal size" }
        )

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

        vim.keymap.set("n", "<leader>td", function()
            terminal_cmd("lazydocker")()
        end, { desc = "Open Lazydocker" })

        vim.keymap.set("n", "<leader>tc", function()
            terminal_cmd("claude")()
        end, { desc = "Open Claude" })

        vim.keymap.set("n", "<leader>ty", function()
            terminal_cmd("btm")()
        end, { desc = "Open Yazi" })
    end,
}
