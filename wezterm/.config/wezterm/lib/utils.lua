local wezterm = require("wezterm") --[[@as Wezterm]]
local process_icons = require("lib.icons")

local M = {}

M.is_mac = function()
	return wezterm.target_triple:find("darwin")
end

M.is_windows = function()
	return wezterm.target_triple == "x86_64-pc-windows-msvc"
end

M.run_command = function(cmd)
	if M.is_windows() then
		cmd = {
			"wsl.exe",
			"-e",
			table.unpack(cmd),
		}
	end
	return wezterm.run_child_process(cmd)
end

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

M.is_vim = function(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name
	return process_name == "nvim" or process_name == "vim"
end

M.find_vim_pane = function(tab)
	for _, pane in ipairs(tab:panes()) do
		if M.is_vim(pane) then
			return pane
		end
	end
end

---@param cmd string
M.get_cmd = function(cmd)
	local exports_file = "~/.exports_mac.zsh"
	return table.unpack({
		"/bin/zsh",
		"-c",
		"-l",
		"source " .. exports_file .. " && " .. cmd,
	})
end

return M
