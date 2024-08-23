local wezterm = require("wezterm")
local utils = require("lib.utils")

local appearance = require("appearance")
local behavior = require("behavior")
local colors = require("colors")
local events = require("events")
local keys = require("keys")

local config = {}
for _, module in ipairs({
	appearance,
	behavior,
	colors,
	keys,
	events,
}) do
	utils.merge_tables(config, module)
end

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if is_windows then
	local windows_overrides = require("windows_overrides")
	utils.merge_tables(config, windows_overrides)
end

return config
