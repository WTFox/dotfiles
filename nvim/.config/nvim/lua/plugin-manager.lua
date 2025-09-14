local M = {}

function M.load_plugins()
    local plugin_dir = vim.fn.stdpath('config') .. '/lua/plugins'
    local plugins = {}

    -- Scan for .lua files in plugins directory
    local handle = vim.loop.fs_scandir(plugin_dir)
    if not handle then
        return
    end

    while true do
        local name, file_type = vim.loop.fs_scandir_next(handle)
        if not name then break end

        if file_type == 'file' and name:match('%.lua$') then
            local plugin_name = name:gsub('%.lua$', '')
            local ok, spec = pcall(require, 'plugins.' .. plugin_name)

            if ok and type(spec) == 'table' and spec.url then
                -- Prepare vim.pack.add options
                local pack_opts = {
                    src = spec.url
                }

                -- Add optional fields
                if spec.version then pack_opts.version = spec.version end
                if spec.build then pack_opts.build = spec.build end

                table.insert(plugins, pack_opts)

                -- Store config function to call after pack.add
                if spec.config and type(spec.config) == 'function' then
                    plugins[#plugins].config_fn = spec.config
                end
            end
        end
    end

    -- Add all plugins to vim.pack
    vim.pack.add(plugins)

    -- Call config functions
    for _, plugin in ipairs(plugins) do
        if plugin.config_fn then
            plugin.config_fn()
        end
    end
end

return M