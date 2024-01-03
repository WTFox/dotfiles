hs.loadSpoon("EmmyLua") -- loads autocomplete info for editors
hs.loadSpoon("ControlEscape"):start() -- remaps caps lock to escape when pressed alone, control when pressed with another key

require("apps")

local utils = require("utils")

hs.hotkey.bind(utils.MASH, "r", function()
	hs.reload()
	hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()
end)
