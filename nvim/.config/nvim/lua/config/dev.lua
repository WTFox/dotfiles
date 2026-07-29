local map = vim.keymap.set

map("n", "<leader>R", function()
    -- Clear only our custom lua modules
    for name, _ in pairs(package.loaded) do
        if name:match("^config%.") or name:match("^plugins%.") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    -- Force colorscheme reload
    if vim.g.colors_name then
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end
    print("Config reloaded!")
end, { desc = "Reload config", silent = true })

map("n", "<leader>up", function()
    local plugins = {}
    for name in pairs(package.loaded) do
        if not name:match("^_") and not name:match("^vim") and not name:match("^nvim") then
            table.insert(plugins, name)
        end
    end
    table.sort(plugins)

    local lines = { "Loaded Plugins:" }
    for _, plugin in ipairs(plugins) do
        table.insert(lines, "  " .. plugin)
    end

    vim.api.nvim_echo({ { table.concat(lines, "\n"), "Normal" } }, true, {})
end, { desc = "Show loaded plugins", silent = true })
