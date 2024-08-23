local wezterm = require("wezterm")
local process_icons = require("lib.icons")

local M = {}

M.get_current_working_dir = function(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

M.get_process = function(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return "[?]"
	end
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	return process_icons[process_name] or string.format("[%s]", process_name)
end

M.scheme_for_appearance = function(appearance, dark, light)
	if appearance:find("Dark") then
		return dark
	end
	return light
end

M.merge_tables = function(base, updates)
	for k, v in pairs(updates) do
		if type(v) == "table" and type(base[k]) == "table" then
			M.merge_tables(base[k], v)
		else
			base[k] = v
		end
	end
end

return M
