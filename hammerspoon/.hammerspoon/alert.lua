local utils = require("utils")

hs.hotkey.bind(utils.MASH, "n", function()
	hs.execute("~/bin/alert")
end)
