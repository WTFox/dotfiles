local get_main_branch = function()
    local handle = io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'")
    if not handle then
        return ""
    end

    local result = handle:read("*a")
    handle:close()

    if not result or result == "" then
        return ""
    end

    return result:gsub("\n", "")
end

---@type PluginSpec[]
return {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    {
        src = "https://github.com/sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({
                use_icons = false,
            })

            vim.keymap.set("n", "<leader>gdd", "<cmd>DiffviewOpen<CR>", { desc = "DiffView" })
            vim.keymap.set("n", "<leader>gdm", function()
                local branch = get_main_branch()
                if branch == "" then
                    print("Could not get main branch")
                    return
                end
                vim.cmd("DiffviewOpen " .. branch)
            end, { desc = "DiffView main branch", noremap = true, silent = true })
        end,
    },
}
