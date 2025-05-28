local M = {}

local function getIcon()
	return hs.caffeinate.get("displayIdle") and "☕️" or "🥱"
end

local function getStatus()
	return hs.caffeinate.get("displayIdle") and "On" or "Off"
end

local function toggle()
	hs.caffeinate.toggle("displayIdle")
end

M.getIcon = getIcon
M.getStatus = getStatus
M.toggle = toggle

return M
