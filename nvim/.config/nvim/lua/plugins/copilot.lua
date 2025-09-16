return {
    src = "https://github.com/zbirenbaum/copilot.lua",
    config = function()
        vim.api.nvim_create_autocmd("InsertEnter", {
            once = true, -- only run once, not every InsertEnter
            callback = function()
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
        })
    end,
}
