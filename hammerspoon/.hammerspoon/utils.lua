local M = {}

M.MASH = { "⌥", "⌃" }

M.onPersonalLaptop = function()
	return hs.host.localizedName() == "majora"
end

return M
