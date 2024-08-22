---@type Wezterm
local wezterm = require("wezterm")

local config = {
	automatically_reload_config = true,
}

local appearance = require("appearance")
local colors = require("colors")
local font = require("font")
local keys = require("keys")
local windows_overrides = require("windows_overrides")

for _, module in ipairs({
	appearance,
	colors,
	font,
	keys,
	windows_overrides,
}) do
	for k, v in pairs(module) do
		config[k] = v
	end
end

return config
