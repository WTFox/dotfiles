---@class (exact) PluginSpec
---@field src string The plugin source URL
---@field version? string The plugin version
---@field build? string|function The build command or function
---@field config? function The configuration function

---@class (exact) PackSpec
---@field src string The source URL for vim.pack.add
---@field version? string The plugin version
---@field build? string|function The build command or function
---@field config_fns function[] The configuration functions to call after loading

local M = {}

---@param spec PluginSpec
---@param plugin_map table<string, PackSpec>
local function merge_plugin_spec(spec, plugin_map)
    local src = spec.src

    if plugin_map[src] then
        -- Plugin already exists, merge config function
        if spec.config and type(spec.config) == "function" then
            table.insert(plugin_map[src].config_fns, spec.config)
        end

        -- Update version/build if provided (last one wins)
        if spec.version then
            plugin_map[src].version = spec.version
        end
        if spec.build then
            plugin_map[src].build = spec.build
        end
    else
        -- New plugin
        local pack_spec = {
            src = src,
            config_fns = {},
        }

        -- Add optional fields
        if spec.version then
            pack_spec.version = spec.version
        end
        if spec.build then
            pack_spec.build = spec.build
        end

        -- Add config function if present
        if spec.config and type(spec.config) == "function" then
            table.insert(pack_spec.config_fns, spec.config)
        end

        plugin_map[src] = pack_spec
    end
end

---@param spec PluginSpec|PluginSpec[]
---@param plugin_map table<string, PackSpec>
local function process_plugin_spec(spec, plugin_map)
    if type(spec) == "table" then
        -- Check if it's a single plugin spec or an array of specs
        if spec.src then
            -- Single plugin spec
            merge_plugin_spec(spec, plugin_map)
        elseif #spec > 0 then
            -- Array of plugin specs
            for _, plugin_spec in ipairs(spec) do
                if type(plugin_spec) == "table" and plugin_spec.src then
                    merge_plugin_spec(plugin_spec, plugin_map)
                end
            end
        end
    end
end

function M.load_plugins()
    local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
    local plugin_map = {}

    -- Scan for .lua files in plugins directory
    local handle = vim.loop.fs_scandir(plugin_dir)
    if not handle then
        return
    end

    while true do
        local name, file_type = vim.loop.fs_scandir_next(handle)
        if not name then
            break
        end

        if file_type == "file" and name:match("%.lua$") then
            local plugin_name = name:gsub("%.lua$", "")
            local ok, spec = pcall(require, "plugins." .. plugin_name)

            if ok then
                process_plugin_spec(spec, plugin_map)
            end
        end
    end

    -- Convert plugin map to array for vim.pack.add
    local plugins = {}
    for _, pack_spec in pairs(plugin_map) do
        table.insert(plugins, pack_spec)
    end

    -- Add all plugins to vim.pack
    vim.pack.add(plugins)

    -- Call all config functions for each plugin
    for _, plugin in ipairs(plugins) do
        for _, config_fn in ipairs(plugin.config_fns) do
            config_fn()
        end
    end
end

return M
