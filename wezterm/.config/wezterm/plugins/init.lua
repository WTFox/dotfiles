local M = {}

M.setup = function(config)
	if config.tabline_enabled then
		require("plugins.tabline").setup(config)
	end
end

return M
