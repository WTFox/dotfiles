local utils = require("utils")

local M = {}

local function darkModeEnabled()
	local value = hs.execute("defaults read -g AppleInterfaceStyle")
	if not value then
		return false
	end
	return utils.trim_string(value) == "Dark"
end

local function getIcon()
	return darkModeEnabled() and "🌙" or "☀️"
end

local function getStatus()
	return darkModeEnabled() and "Dark" or "Light"
end

local function toggle()
	hs.execute(
		"osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
	)
end

M.getIcon = getIcon
M.getStatus = getStatus
M.toggle = toggle

hs.hotkey.bind(utils.MASH, "b", function()
	toggle()
end)

return M
