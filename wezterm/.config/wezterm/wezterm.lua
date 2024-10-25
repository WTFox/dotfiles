local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

local appearance = require("appearance")
local behavior = require("behavior")
local colors = require("colors")
local events = require("events")
local keys = require("keys")
local plugins = require("plugins")

local config = {}
for _, module in ipairs({
	appearance,
	behavior,
	colors,
	events,
	keys,
}) do
	utils.merge_tables(config, module)
end

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if is_windows then
	local windows_overrides = require("windows_overrides")
	utils.merge_tables(config, windows_overrides)
end

plugins.tabline.apply_to_config(config)

return config
