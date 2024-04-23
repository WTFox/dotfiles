local utils = require("utils")

local prefix = { "ctrl" }
local mappings = {
	{ key = "`", app = "wezterm" },
}

if utils.on_personal_laptop() then
	table.insert(mappings, { key = "1", app = "Firefox" })
	table.insert(mappings, { key = "2", app = "Discord" })
	table.insert(mappings, { key = "3", app = "Spotify" })
else
	table.insert(mappings, { key = "1", app = "Google Chrome" })
	table.insert(mappings, { key = "2", app = "Slack" })
	table.insert(mappings, { key = "3", app = "Microsoft Outlook" })
	table.insert(mappings, { key = "4", app = "zoom.us" })
end

local function toggleApplication(name)
	local app = hs.application.find(name)
	if not app or app:isHidden() then
		hs.application.launchOrFocus(name)
	elseif hs.application.frontmostApplication() ~= app then
		app:activate()
	else
		app:hide()
	end
end

hs.application.enableSpotlightForNameSearches(true)
for _, value in ipairs(mappings) do
	hs.hotkey.bind(prefix, value.key, function()
		toggleApplication(value.app)
	end)
end
