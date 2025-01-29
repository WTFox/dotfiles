local M = {}

M.setup_tabline = function(config, opts)
	require("plugins.tabline").setup(config, opts)
end

M.setup = function(config, opts)
	if opts.tabline.enabled then
		M.setup_tabline(config, opts)
	end
end

return M
