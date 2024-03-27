hs.loadSpoon("EmmyLua") -- loads autocomplete info for editors
-- hs.loadSpoon("ControlEscape"):start() -- remaps caps lock to escape when pressed alone, control when pressed with another key

require("apps")
require("spongebob")
require("toggleTheme")

local utils = require("utils")

-- MASH + r to reload config
hs.hotkey.bind(utils.MASH, "r", function()
	hs.reload()
	local notify = hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" })
	if not notify then
		return
	end
	notify:send()
end)

-- MASH + backspace to lock screen
hs.hotkey.bind(utils.MASH, "delete", function()
	hs.caffeinate.lockScreen()
end)
