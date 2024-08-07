---@type Wezterm
local wezterm = require("wezterm")

---@class Config
local config = {}

-- if wezterm.config_builder then
config = wezterm.config_builder()
-- end

-- local DARK_THEME = "Kanagawa (Gogh)"
-- local DARK_THEME = "nordic-dark"
-- local DARK_THEME = "GitHub Dark"
-- local DARK_THEME = "zenbones_dark"
-- local DARK_THEME = "kanagawa-dragon"
-- local DARK_THEME = "tokyonight_night"
-- local DARK_THEME = "vscode-dark"
local DARK_THEME = "catppuccin-mocha"
-- local DARK_THEME = "catppuccin-macchiato"
local LIGHT_THEME = "zenbones"

local act = wezterm.action
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local key_mod_panes = "CTRL|SHIFT"

local process_icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["btop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_neovim,
	["psql"] = "󱤢",
	["python3"] = wezterm.nerdfonts.dev_python,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["ssh"] = wezterm.nerdfonts.fa_exchange,
	["ssh-add"] = wezterm.nerdfonts.fa_exchange,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["usql"] = "󱤢",
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
}

-- Functions
local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name
	return process_name == "nvim" or process_name == "vim"
end

local function find_vim_pane(tab)
	for _, pane in ipairs(tab:panes()) do
		if is_vim(pane) then
			return pane
		end
	end
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return DARK_THEME
	end
	return LIGHT_THEME
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
	return process_icons[process_name] or string.format("[%s]", process_name)
end

-- Behavior
config.automatically_reload_config = true

-- UI
config.color_scheme_dirs = { "~/.config/wezterm/colors/" }

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local cwd = get_current_working_dir(tab)
	local title = string.format(" %s  %s  ", get_process(tab), cwd)
	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Text = title },
	}
end)

-- config.front_end = "WebGpu"
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
config.initial_rows = 32
-- config.window_background_opacity = 0.3
-- config.macos_window_background_blur = 20
-- config.tab_bar_at_bottom = true

-- Font
local jetbrains_mono = {
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt",
		"clig",
		"liga",
	},
}

local jetbrains_styled = {
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = {
		"calt", -- Contains all ligatures. Substitution for : between digits
		"clig",
		"liga",
		-- "zero", -- Changes 0 to slashed variant.
		-- "frac", -- Substitute digits in fraction sequences to look more like fractions.
		-- "ss01", -- All classic construction. JetBrains Mono but even more neutral. Performs better in big paragraph of text.
		-- "ss02", -- All closed construction. Change the rhythm to a more lively one.
		-- "ss19", -- Adds gaps in ≠ ≠= == === ligatures.
		"ss20", -- Shift horizontal stroke in f to match x-height
		-- "cv01", -- l with symmetrical lower stroke. (ss01)
		"cv02", -- t with curly tail (ss02)
		"cv03", -- g with more complex construction
		"cv04", -- j with curly descender
		"cv05", -- l with curly tail (ss02)
		"cv06", -- m with shorter middle leg (ss02)
		"cv07", -- Ww with lower middle peak (ss02)
		-- "cv08", -- Kk with sharp connection (ss01)
		-- "cv09", -- f with additional horizontal stroke. (ss01)
		-- "cv10", -- r with more open construction (ss01)
		"cv11", -- y with different ascender construction (ss01)
		-- "cv12", -- u with traditional construction (ss01)
		"cv14", -- $ with broken bar
		"cv15", -- & alternative ampersand
		"cv16", -- Q with bent tail
		"cv17", -- f with curly ascender (ss02)
		-- "cv18", -- 269 variant
		-- "cv19", -- 8 old variant
		-- "cv20", -- 5 old variant
		-- "cv99", -- highlights cyrillic C and c for debugging
	},
}

local operator_mono = {
	family = "Operator Mono",
	weight = "Book",
	harfbuzz_features = {
		"calt",
		"clig",
		"liga",
	},
}

local monolisa = {
	family = "MonoLisa",
	weight = "Regular",
	harfbuzz_features = {
		"calt",
		"clig",
		"liga",
		"ss02",
		"ss03",
		"ss09",
		"ss13",
		"ss14",
		"ss15",
		"ss16",
	},
}

local fira_code = {
	family = "Fira Code",
	weight = "Regular",
	harfbuzz_features = {
		"zero",
		-- "ss01",
		"ss02",
		"ss04",
		"ss06",
		"ss09",
		-- "ss10",
		-- "ss19",
		-- "ss20",
		-- "cv01",
		-- "cv02",
		-- "cv03",
		-- "cv04",
		-- "cv05",
		"cv06",
		-- "cv07",
		-- "cv08",
		-- "cv09",
		-- "cv10",
		-- "cv11",
		-- "cv12",
		-- "cv14",
		-- "cv15",
		-- "cv16",
		-- "cv17",
		-- "cv18",
		-- "cv19",
		-- "cv20",
		"cv26",
		"cv27",
		"cv30",
		-- "cv31",
		-- "cv99",
	},
}

config.font_size = 15
config.font = wezterm.font(jetbrains_styled)
config.adjust_window_size_when_changing_font_size = false

-- Colors
local colors = wezterm.color.get_builtin_schemes()
local function set_theme_attr(theme, attr, value)
	local t = colors[theme]
	t[attr] = value
	config.color_schemes = {
		[theme] = t,
	}
end

-- set_theme_attr("catppuccin-mocha", "background", "#0e0e13")
-- set_theme_attr("catppuccin-mocha", "background", "#11111b")
-- set_theme_attr("tokyonight_night", "background", "#11111b")
-- set_theme_attr("tokyonight_night", "background", "#0e0e13")

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
-- config.colors = {
-- 	tab_bar = {
-- 		background = "#191d24",
-- 		new_tab = {
-- 			bg_color = "#2e3440",
-- 			fg_color = "#d8dee9",
-- 		},
-- 	},
-- }
--
-- Keys
config.keys = {
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
			if is_vim(pane) then
				if (#tab:panes()) == 1 then
					pane:split({ direction = "Bottom" })
				else
					window:perform_action({
						SendKey = { key = ";", mods = "CTRL" },
					}, pane)
				end
			end

			local vim_pane = find_vim_pane(tab)
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

-- Below is an example implementation of a theme switcher
-- local wezterm = require("wezterm")
-- local act = wezterm.action
--
-- local M = {}
--
-- M.theme_switcher = function(window, pane)
--   -- get builting color schemes
--   local schemes = wezterm.get_builtin_color_schemes()
--   local choices = {}
--   local config_path = "/path/to/.wezterm.lua"
--
--   -- populate theme names in choices list
--   for key, _ in pairs(schemes) do
--     table.insert(choices, { label = tostring(key) })
--   end
--
--   -- sort choices list
--   table.sort(choices, function(c1, c2)
--     return c1.label < c2.label
--   end)
--
--   window:perform_action(
--     act.InputSelector({
--       title = "🎨 Pick a Theme!",
--       choices = choices,
--       fuzzy = true,
--
--       -- execute 'sed' shell command to replace the line
--           -- responsible of colorscheme in my config
--       action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
--         inner_window:perform_action(
--           act.SpawnCommandInNewTab({
--             args = {
--               "sed",
--               "-i",
--               '/^Colorscheme/c\\Colorscheme = "' .. label .. '"',
--               config_path,
--             },
--           }),
--           inner_pane
--           )
--       end),
--       }),
--       pane
--   )
-- end
--
-- return M
