---@class (exact) PluginSpec
---@field src string The plugin source URL
---@field dev? boolean Is this plugin locally loaded?
---@field lazy? boolean Is this plugin lazy-loaded?
---@field event? string|string[] The event(s) that trigger loading
---@field version? string|vim.VersionRange The plugin version
---@field config? function The configuration function
---@field dependencies? string[] List of plugin sources this plugin depends on
---@field [any] 'never'

---@class (exact) PackSpec
---@field src string The source URL for vim.pack.add
---@field lazy? boolean Is this plugin lazy-loaded?
---@field event? string|string[] The event(s) that trigger loading
---@field version? string|vim.VersionRange The plugin version
---@field config_fns function[] The configuration functions to call after loading
---@field dependencies? string[] List of plugin sources this plugin depends on

local M = {}

local gr = vim.api.nvim_create_augroup("LazyLoad", { clear = true })
local function lazy_load(callback, event)
    if event then
        vim.api.nvim_create_autocmd(event, {
            pattern = "*",
            once = true,
            group = gr,
            callback = callback,
        })
        return
    end
    vim.api.nvim_create_autocmd("UIEnter", {
        pattern = "*",
        once = true,
        group = gr,
        callback = function()
            vim.defer_fn(callback, 0)
        end,
    })
end

---if spec.src is not a full URL and spec.dev is not true, prepend
---https://github.com/
---
---if spec.src is already a full URL or spec.dev is true, return as is
---supports urls and absolute file paths.
---@param spec PluginSpec
---@return string
local function get_src(spec)
    local src = spec.src
    if string.sub(src, 1, 5) ~= "https" and (spec.dev == nil or spec.dev == false) then
        return "https://github.com/" .. src
    end
    return src
end

---@param spec PluginSpec
---@param plugin_map table<string, PackSpec>
local function merge_plugin_spec(spec, plugin_map)
    local src = get_src(spec)

    if plugin_map[src] then
        -- Plugin already exists, merge config function
        if spec.config and type(spec.config) == "function" then
            table.insert(plugin_map[src].config_fns, spec.config)
        end

        -- Update version/build if provided (last one wins)
        if spec.version then
            plugin_map[src].version = spec.version
        end

        -- Update lazy loading settings if provided
        if spec.lazy ~= nil then
            plugin_map[src].lazy = spec.lazy
        end
        if spec.event then
            plugin_map[src].event = spec.event
        end

        -- Merge dependencies
        if spec.dependencies then
            plugin_map[src].dependencies = plugin_map[src].dependencies or {}
            for _, dep in ipairs(spec.dependencies) do
                if not vim.tbl_contains(plugin_map[src].dependencies, dep) then
                    table.insert(plugin_map[src].dependencies, dep)
                end
            end
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
        if spec.lazy ~= nil then
            pack_spec.lazy = spec.lazy
        end
        if spec.event then
            pack_spec.event = spec.event
        end
        if spec.dependencies then
            pack_spec.dependencies = vim.deepcopy(spec.dependencies)
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

    -- Load plugins with dependency resolution
    local loaded = {}
    local loading = {}

    local function load_plugin(pack_spec)
        if loaded[pack_spec.src] or loading[pack_spec.src] then
            return
        end

        loading[pack_spec.src] = true

        -- Load dependencies first
        if pack_spec.dependencies then
            for _, dep_src in ipairs(pack_spec.dependencies) do
                -- Convert dependency source to full URL format
                local dep_full_src = dep_src
                if string.sub(dep_src, 1, 5) ~= "https" then
                    dep_full_src = "https://github.com/" .. dep_src
                end

                local dep_spec = plugin_map[dep_full_src]
                if dep_spec then
                    -- Force synchronous loading of dependencies
                    if not loaded[dep_spec.src] and not loading[dep_spec.src] then
                        loading[dep_spec.src] = true

                        -- Recursively load dependency's dependencies first
                        if dep_spec.dependencies then
                            for _, nested_dep_src in ipairs(dep_spec.dependencies) do
                                local nested_dep_full_src = nested_dep_src
                                if string.sub(nested_dep_src, 1, 5) ~= "https" then
                                    nested_dep_full_src = "https://github.com/" .. nested_dep_src
                                end
                                local nested_dep_spec = plugin_map[nested_dep_full_src]
                                if nested_dep_spec then
                                    load_plugin(nested_dep_spec)
                                end
                            end
                        end

                        -- Load dependency synchronously regardless of lazy flag
                        vim.pack.add({ dep_spec }, { confirm = false })
                        for _, config_fn in ipairs(dep_spec.config_fns) do
                            config_fn()
                        end
                        loaded[dep_spec.src] = true
                        loading[dep_spec.src] = false
                    end
                end
            end
        end

        -- Load the plugin
        if pack_spec.lazy and pack_spec.lazy == true then
            lazy_load(function()
                vim.pack.add({ pack_spec }, { confirm = false })
                for _, config_fn in ipairs(pack_spec.config_fns) do
                    config_fn()
                end
                loaded[pack_spec.src] = true
            end, pack_spec.event)
        else
            vim.pack.add({ pack_spec }, { confirm = false })
            for _, config_fn in ipairs(pack_spec.config_fns) do
                config_fn()
            end
            loaded[pack_spec.src] = true
        end

        loading[pack_spec.src] = false
    end

    -- Load all plugins
    for _, pack_spec in pairs(plugin_map) do
        load_plugin(pack_spec)
    end

    -- -- Add all plugins to vim.pack
    -- vim.pack.add(plugins)
    --
    -- -- Call all config functions for each plugin
    -- for _, plugin in ipairs(plugins) do
    --     for _, config_fn in ipairs(plugin.config_fns) do
    --         config_fn()
    --     end
    -- end
end

local function exec_installation(opts)
    -- if opts.dependencies then
    -- 	vim.pack.add(opts.dependencies)
    -- end

    vim.pack.add({
        src = opts.src,
        -- name = opts.name,
        version = opts.version,
    })
    if opts.config then
        opts.config()
    end
end

return M
