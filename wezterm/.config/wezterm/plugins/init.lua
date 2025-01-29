local M = {}

M.setup_tabline = function(config)
	require("plugins.tabline").setup(config)
end

M.setup = function(config, plugin_opts)
	if plugin_opts.tabline_enabled then
		M.setup_tabline(config)
	end
end

return M
