if not vim.g.copilot then
    return {}
end

return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
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
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { { "zbirenbaum/copilot.lua" } },
        cmd = {
            "CopilotChat",
            "CopilotChatOpen",
            "CopilotChatToggle",
            "CopilotChatReset",
        },
        keys = {
            {
                "<leader>aa",
                function()
                    require("CopilotChat").toggle()
                end,
                desc = "Toggle",
                mode = { "n", "v" },
            },
            {
                "<leader>ax",
                function()
                    require("CopilotChat").reset()
                end,
                desc = "Clear",
            },
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        local select = require("CopilotChat.select")
                        require("CopilotChat").ask(input, { selection = select.buffer })
                    end
                end,
                desc = "Quick Chat",
            },
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        local select = require("CopilotChat.select")
                        require("CopilotChat").ask(input, { selection = select.visual })
                    end
                end,
                mode = "v",
                desc = "Quick Chat",
            },
            {
                "<leader>ap",
                function()
                    require("CopilotChat").select_prompt()
                end,
                desc = "CopilotChat - Prompt actions",
                mode = { "n", "v" },
            },
        },
        opts = {
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
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)

            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-chat",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                end,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "copilot-chat",
                callback = function()
                    vim.keymap.set("i", "<C-s>", "<CR>", { buffer = true, desc = "Submit", remap = true })
                end,
            })
        end,
    },
    { "giuxtaposition/blink-cmp-copilot" },
    {
        "saghen/blink.cmp",
        optional = true,
        opts = function(_, opts)
            table.insert(opts.sources.default, 1, "copilot")

            opts.sources.providers["copilot"] = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
            }
            return opts
        end,
    },
}
