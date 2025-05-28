hs.loadSpoon("EmmyLua") -- loads autocomplete info for editors

require("apps")
require("caffeine")
require("spongebob")
require("toggleTheme")
require("alert")
require("menubar")

local utils = require("utils")

hs.hotkey.bind(utils.MASH, "r", function()
	hs.reload()
	local notify = hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" })
	if not notify then
		return
	end
	notify:send()
end)

-- cmd + escape to lock screen
hs.hotkey.bind("cmd", "escape", function()
	hs.caffeinate.lockScreen()
end)
