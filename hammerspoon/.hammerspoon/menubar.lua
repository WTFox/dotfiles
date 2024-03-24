local utils = require("utils")

local darkMode = hs.menubar.new()
if not darkMode then
	return
end

local function darkModeEnabled()
	local value = hs.execute("defaults read -g AppleInterfaceStyle")
	if not value then
		return false
	end
	-- this trims the whitespace lol
	value = value:gsub("^%s*(.-)%s*$", "%1")
	return value == "Dark"
end

local function toggleDarkModeClicked()
	hs.execute(
		"osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
	)
	darkMode:setTitle(darkModeEnabled() and "🌙" or "☀️")
end

darkMode:setTitle(darkModeEnabled() and "🌙" or "☀️")
darkMode:setClickCallback(toggleDarkModeClicked)

hs.hotkey.bind(utils.MASH, "b", function()
	toggleDarkModeClicked()
end)
