local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
local utils = require("lib.utils")

local key_mod_panes = "CTRL|SHIFT"

return {
	keys = {
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
		{
			key = "Enter",
			mods = "ALT",
			action = act.DisableDefaultAssignment,
		},
		{
			key = "v",
			mods = key_mod_panes,
			action = act({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = key_mod_panes,
			action = act({ CopyTo = "Clipboard" }),
		},
		{
			key = "|",
			mods = key_mod_panes,
			action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "_",
			mods = key_mod_panes,
			action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "h",
			mods = key_mod_panes,
			action = act({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "j",
			mods = key_mod_panes,
			action = act({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "k",
			mods = key_mod_panes,
			action = act({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "l",
			mods = key_mod_panes,
			action = act({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "h",
			mods = "SUPER",
			action = act({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "j",
			mods = "SUPER",
			action = act({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "k",
			mods = "SUPER",
			action = act({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "l",
			mods = "SUPER",
			action = act({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "{",
			mods = key_mod_panes,
			action = act({ ActivateTabRelative = -1 }),
		},
		{
			key = "}",
			mods = key_mod_panes,
			action = act({ ActivateTabRelative = 1 }),
		},
		{
			key = "f",
			mods = key_mod_panes,
			action = act.ToggleFullScreen,
		},
		{
			key = "Backspace",
			mods = key_mod_panes,
			action = act({ CloseCurrentPane = { confirm = true } }),
		},
		{
			key = "n",
			mods = key_mod_panes,
			action = act({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "LeftArrow",
			mods = "ALT",
			action = act({ SendString = "\x1bb" }),
		},
		{
			key = "RightArrow",
			mods = "ALT",
			action = act({ SendString = "\4bf" }),
		},
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
		{
			key = "p",
			mods = key_mod_panes,
			action = act.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
		},
		{
			key = ".",
			mods = "CTRL",
			action = act.ActivateCommandPalette,
		},
		-- This could be useful to swap panes
		-- {
		-- 	key = "\\",
		-- 	mods = "CTRL",
		-- 	action = act.PaneSelect({
		-- 		mode = "SwapWithActiveKeepFocus",
		-- 	}),
		-- },
		{
			key = "Enter",
			mods = key_mod_panes,
			action = act.TogglePaneZoomState,
		},
		{
			key = ";",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				local tab = window:active_tab()
				if utils.is_vim(pane) then
					if (#tab:panes()) == 1 then
						pane:split({ direction = "Bottom", size = 0.3 })
					else
						window:perform_action({
							SendKey = { key = ";", mods = "CTRL" },
						}, pane)
					end
				end

				local vim_pane = utils.find_vim_pane(tab)
				print("finding vim pane", vim_pane)
				if vim_pane then
					vim_pane:activate()
					tab:set_zoomed(true)
				end
			end),
		},
		{
			key = "P",
			mods = key_mod_panes,
			action = wezterm.action({
				QuickSelectArgs = {
					patterns = {
						"https?://\\S+",
					},
					action = wezterm.action_callback(function(window, pane)
						local url = window:get_selection_text_for_pane(pane)
						wezterm.log_info("opening: " .. url)
						wezterm.open_with(url)
					end),
				},
			}),
		},
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
