local M = {}

M.onPersonalLaptop = function()
	return hs.host.localizedName() == "majora"
end

return M
