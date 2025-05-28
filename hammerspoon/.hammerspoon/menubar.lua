local caffeine = require("caffeine")
local toggleTheme = require("toggleTheme")

local menubar = hs.menubar.new()
if not menubar then
	return
end

local function updateMenubarTitle()
	menubar:setTitle("⚙️")
end

local function createMenu()
	local caffeineStatus = caffeine.getStatus()
	local themeStatus = toggleTheme.getStatus()

	return {
		{
			title = "☕️ Caffeine: " .. caffeineStatus,
			fn = caffeine.toggle,
		},
		{
			title = toggleTheme.getIcon() .. " Theme: " .. themeStatus,
			fn = toggleTheme.toggle,
		},
	}
end

if menubar then
	menubar:setMenu(createMenu)
	updateMenubarTitle()
end

local M = {}
M.updateDisplay = updateMenubarTitle
return M
