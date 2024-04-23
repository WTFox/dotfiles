local M = {}

M.MASH = { "⌥", "⌃" }

M.on_personal_laptop = function()
	return hs.host.localizedName() == "majora"
end

M.trim_string = function(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

return M
