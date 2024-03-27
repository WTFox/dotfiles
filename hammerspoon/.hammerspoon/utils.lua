local M = {}

M.MASH = { "⌥", "⌃" }

M.onPersonalLaptop = function()
	return hs.host.localizedName() == "majora"
end

M.trimString = function(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

return M
