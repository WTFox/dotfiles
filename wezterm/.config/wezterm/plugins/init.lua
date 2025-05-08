local M = {}

M.setup = function(config)
	require("plugins.tabline").setup(config)
	require("plugins.sessionizer").setup(config)
end

return M
