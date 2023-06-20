hs.hotkey.bind(MASH, "r", function()
	hs.reload()
	hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()
end)

local prefix = { "ctrl" }
local mappings = {
	{ key = "1", app = "Brave Browser" },
	{ key = "2", app = "Microsoft Outlook" },
	{ key = "3", app = "zoom.us" },
	{ key = "`", app = "kitty" },
}

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

for _, value in ipairs(mappings) do
	hs.hotkey.bind(prefix, value.key, function()
		toggleApplication(value.app)
	end)
end
