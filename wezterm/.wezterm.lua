local wezterm = require("wezterm")

local act = wezterm.action
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local key_mod_panes = "CTRL|SHIFT"

local config = wezterm.config_builder()
local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["psql"] = "󱤢",
	["usql"] = "󱤢",
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["ssh"] = wezterm.nerdfonts.fa_exchange,
	["ssh-add"] = wezterm.nerdfonts.fa_exchange,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["nvim"] = wezterm.nerdfonts.custom_neovim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["go"] = wezterm.nerdfonts.seti_go,
	["python3"] = wezterm.nerdfonts.dev_python,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
}
-- Functions
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "catppuccin-mocha"
	else
		return "Gruvbox (Gogh)"
	end
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return "[?]"
	end

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	end

	return process_icons[process_name] or string.format("[%s]", process_name)
end

-- Behavior
config.automatically_reload_config = true
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	local cwd = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = get_current_working_dir(tab) },
	})

	local title = string.format(" %s  %s  ", get_process(tab), cwd)

	if has_unseen_output then
		return {
			{ Foreground = { Color = "#28719c" } },
			{ Text = title },
		}
	end

	return {
		{ Text = title },
	}
end)

-- UI
config.front_end = "WebGpu"
config.custom_block_glyphs = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.default_cursor_style = "BlinkingBlock"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.initial_cols = 120
config.initial_rows = 30
-- config.window_background_opacity = 0.3
-- config.macos_window_background_blur = 20
-- config.tab_bar_at_bottom = true

-- Font
config.font_size = 16
config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt=1",
		"clig=1",
		"liga=1",
		"zero=1",
		-- "ss01=1",
		"ss02=1",
		"ss20=1",
		"cv03=1",
		"cv06=1",
		"cv15=1",
		"cv16=1",
		"cv18=1",
		"cv19=1",
	},
})

-- Colors
local catppuccin_mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin_mocha.background = "#11111b"
config.color_schemes = {
	["catppuccin-mocha"] = catppuccin_mocha,
}

local solarized_light = wezterm.color.get_builtin_schemes()["Solarized Light (Gogh)"]
solarized_light.background = "#faf5d4"
config.color_schemes["solarized-light"] = solarized_light

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Keys
config.keys = {
	-- unmap alt-enter
	{
		key = "Enter",
		mods = "ALT",
		action = act.DisableDefaultAssignment,
	},
	-- super-shift-v to paste from clipboard
	{
		key = "v",
		mods = key_mod_panes,
		action = act({ PasteFrom = "Clipboard" }),
	},
	-- shift + right click to paste from clipboard
	-- {
	-- 	button = "Right",
	-- 	mods = "SHIFT",
	-- 	action = act({ PasteFrom = "Clipboard" }),
	-- },
	-- super-shift-c to copy to clipboard
	{
		key = "c",
		mods = key_mod_panes,
		action = act({ CopyTo = "Clipboard" }),
	},
	-- split vertical with ctrl-\
	{
		key = "|",
		mods = key_mod_panes,
		action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	-- split horizontal with ctrl-shift-enter
	{
		key = "_",
		mods = key_mod_panes,
		action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	-- map pane switching to super-hjkl
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
		key = "f",
		mods = key_mod_panes,
		action = act.ToggleFullScreen,
	},
	-- backsapce to close pane
	{
		key = "Backspace",
		mods = key_mod_panes,
		action = act({ CloseCurrentPane = { confirm = true } }),
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
	-- shift + page up/down to scroll
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
	-- super + p shows launcher
	{
		key = "p",
		mods = key_mod_panes,
		action = act.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
	},
	-- super + . shows command palette
	{
		key = ".",
		mods = key_mod_panes,
		action = act.ActivateCommandPalette,
	},
}

config.mouse_bindings = {
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
}

if is_windows then
	config.default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" }
	config.wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	}
end

return config
