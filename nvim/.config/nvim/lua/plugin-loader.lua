local plugin_configs = {
    "plugin-config.colorscheme",
    "plugin-config.treesitter",
    "plugin-config.completion",
    "plugin-config.conform",
    "plugin-config.fzf",
    "plugin-config.git",
    "plugin-config.mini",
    "plugin-config.dial",
    "plugin-config.other",
}

for _, config in ipairs(plugin_configs) do
    require(config)
end

