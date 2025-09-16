local utils = require("lib.utils")
local wezterm = require("wezterm") --[[@as Wezterm]]

---@class (exact) StrictConfig : Config
---@field [any] 'never'
local config = {}

local appearance = require("appearance")
local behavior = require("behavior")
local colors = require("colors")
local events = require("events")
local keys = require("keys")
local plugins = require("plugins")

for _, module in ipairs({
    appearance,
    behavior,
    colors,
    events,
    keys,
}) do
    utils.merge_tables(config, module)
end

if utils.is_windows() then
    utils.merge_tables(config, require("windows_overrides"))
end

plugins.setup(config)

return config
