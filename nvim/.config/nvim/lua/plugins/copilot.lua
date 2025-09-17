---@type PluginSpec[]
return {
    {
        src = "zbirenbaum/copilot.lua",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                filetypes = {
                    markdown = true,
                    help = true,
                    text = false,
                    zsh = false,
                    sh = function()
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
                            return false
                        end
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.envrc.*") then
                            return false
                        end
                        return true
                    end,
                },
            })
        end,
    },
    {
        src = "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        event = "InsertEnter",
        depencies = { { src = "zbirenbaum/copilot.lua" } },
        config = function()
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")

            chat.setup({
                model = "gpt-4o",
                auto_insert_mode = true,
                show_help = false,
                window = {
                    layout = "vertical",
                    width = 0.4,
                },
                chat_autocomplete = true,
                context = "buffers",
                chat_headers = {
                    system = "System",
                    user = vim.env.USER or "User",
                    assistant = "Copilot",
                },
            })

            -- Keymaps
            vim.keymap.set("n", "<leader>aa", function()
                chat.toggle()
            end, { desc = "Toggle" })

            vim.keymap.set("n", "<leader>ax", function()
                chat.reset()
            end, { desc = "Clear" })

            vim.keymap.set("n", "<leader>aq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    chat.ask(input, { selection = select.buffer })
                end
            end, { desc = "Quick Chat" })

            vim.keymap.set({ "n", "v" }, "<leader>ap", function()
                require("CopilotChat").select_prompt()
            end, { desc = "CopilotChat - Prompt actions" })

            -- Visual mode keymaps
            vim.keymap.set("v", "<leader>aa", function()
                chat.toggle({ selection = select.visual })
            end, { desc = "Toggle" })

            vim.keymap.set("v", "<leader>aq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    chat.ask(input, { selection = select.visual })
                end
            end, { desc = "Quick Chat" })

            -- Buffer-specific setup for Copilot Chat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-chat",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                end,
            })

            -- Set up <C-s> keymap for copilot-chat filetype
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "copilot-chat",
                callback = function()
                    vim.keymap.set("i", "<C-s>", "<CR>", { buffer = true, desc = "Submit", remap = true })
                end,
            })
        end,
    },
}
