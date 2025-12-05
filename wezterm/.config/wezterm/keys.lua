local utils = require("lib.utils")
local wezterm = require("wezterm") --[[@as Wezterm]]

local quick_select_patterns = {}
for _, pattern in ipairs(wezterm.default_hyperlink_rules()) do
    table.insert(quick_select_patterns, pattern.regex)
end

local act = wezterm.action
local key_mod_panes = "CTRL|SHIFT"
local NONE = "NONE"
local mods = {
    l = "LEADER",
    c = "CTRL",
    a = "ALT",
    s = "SHIFT",
    S = "SUPER",
}

---@type StrictConfig
return {
    -- leader = { key = "b", mods = mods.c },
    key_tables = {
        search_mode = {
            { key = "c", mods = mods.c, action = act.CopyMode("Close") },
            { key = "Enter", mods = NONE, action = act.CopyMode("PriorMatch") },
            { key = "Escape", mods = NONE, action = act.CopyMode("Close") },
            { key = "n", mods = mods.c, action = act.CopyMode("NextMatch") },
            { key = "p", mods = mods.c, action = act.CopyMode("PriorMatch") },
            { key = "r", mods = mods.c, action = act.CopyMode("CycleMatchType") },
            { key = "u", mods = mods.c, action = act.CopyMode("ClearPattern") },
            { key = "UpArrow", mods = NONE, action = act.CopyMode("PriorMatch") },
            { key = "DownArrow", mods = NONE, action = act.CopyMode("NextMatch") },
        },
    },
    keys = {
        { key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
        { key = ".", mods = mods.l, action = act.ActivateCommandPalette },
        { key = "Enter", mods = mods.l, action = act.ToggleFullScreen },
        -- { key = "f", mods = mods.l, action = act.Search({ CaseInSensitiveString = "" }) },
        -- { key = "n", mods = mods.l, action = act({ SpawnTab = "CurrentPaneDomain" }) },
        -- -- using "LEADER|SHIFT" here to handle windows differences
        -- { key = "|", mods = "LEADER|SHIFT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
        -- { key = "-", mods = mods.l, action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
        -- { key = "h", mods = mods.l, action = act({ ActivatePaneDirection = "Left" }) },
        -- { key = "j", mods = mods.l, action = act({ ActivatePaneDirection = "Down" }) },
        -- { key = "k", mods = mods.l, action = act({ ActivatePaneDirection = "Up" }) },
        -- { key = "l", mods = mods.l, action = act({ ActivatePaneDirection = "Right" }) },
        -- { key = "H", mods = mods.l, action = act({ ActivateTabRelative = -1 }) },
        -- { key = "L", mods = mods.l, action = act({ ActivateTabRelative = 1 }) },
        -- { key = "{", mods = key_mod_panes, action = act({ ActivateTabRelative = -1 }) },
        -- { key = "}", mods = key_mod_panes, action = act({ ActivateTabRelative = 1 }) },
        -- { key = "q", mods = mods.l, action = act({ CloseCurrentPane = { confirm = true } }) },
        -- { key = "x", mods = mods.l, action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
        -- { key = "z", mods = mods.l, action = act.TogglePaneZoomState },
        -- { key = "s", mods = mods.l, action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
        { key = "LeftArrow", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "RightArrow", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "DownArrow", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "UpArrow", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "UpArrow", mods = mods.a, action = act.ScrollByLine(-1) },
        { key = "DownArrow", mods = mods.a, action = act.ScrollByLine(1) },
        -- { key = "[", mods = mods.l, action = act.ActivateCopyMode },
        -- open url quick select
        -- {
        --     key = "i",
        --     mods = mods.l,
        --     action = wezterm.action({
        --         QuickSelectArgs = {
        --             patterns = quick_select_patterns,
        --             action = wezterm.action_callback(function(window, pane)
        --                 local url = window:get_selection_text_for_pane(pane)
        --                 wezterm.log_info("opening: " .. url)
        --                 wezterm.open_with(url)
        --             end),
        --         },
        --     }),
        -- },
        -- wezterm.nvim support
        -- {
        --     key = ";",
        --     mods = "CTRL",
        --     action = wezterm.action_callback(function(window, pane)
        --         local tab = window:active_tab()
        --         if utils.is_vim(pane) then
        --             if (#tab:panes()) == 1 then
        --                 pane:split({ direction = "Bottom", size = 0.3 })
        --             else
        --                 window:perform_action({
        --                     SendKey = { key = ";", mods = "CTRL" },
        --                 }, pane)
        --             end
        --         end
        --
        --         local vim_pane = utils.find_vim_pane(tab)
        --         print("finding vim pane", vim_pane)
        --         if vim_pane then
        --             vim_pane:activate()
        --             tab:set_zoomed(true)
        --         end
        --     end),
        -- },
        -- utilities
        -- {
        --     key = "d",
        --     mods = mods.l,
        --     action = act.SpawnCommandInNewTab({
        --         args = { utils.get_cmd("lazydocker") },
        --     }),
        -- },
        -- {
        --     key = "e",
        --     mods = mods.l,
        --     action = act.SpawnCommandInNewTab({
        --         args = { utils.get_cmd("nvim") },
        --     }),
        -- },
        -- {
        --     key = "g",
        --     mods = mods.l,
        --     action = act.SpawnCommandInNewTab({
        --         args = { utils.get_cmd("lazygit") },
        --     }),
        -- },
        -- {
        --     key = "m",
        --     mods = mods.l,
        --     action = act.SpawnCommandInNewTab({
        --         args = { utils.get_cmd("screensaver.sh") },
        --     }),
        -- },
        -- {
        --     key = "c",
        --     mods = mods.l,
        --     action = act.SpawnCommandInNewTab({
        --         args = { utils.get_cmd("claude") },
        --     }),
        -- },
    },
    mouse_bindings = {
        {
            event = { Down = { streak = 1, button = "Right" } },
            mods = "SHIFT",
            action = wezterm.action_callback(function(window, pane)
                local has_selection = window:get_selection_text_for_pane(pane) ~= ""
                if has_selection then
                    window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                    window:perform_action(act.ClearSelection, pane)
                else
                    window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
                end
            end),
        },
    },
}
