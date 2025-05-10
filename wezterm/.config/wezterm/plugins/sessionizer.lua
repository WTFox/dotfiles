local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

local M = {}

M.setup = function(config)
	local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
	local schema = {
		M.zoxide(),
	}

	for _, key_mapping in ipairs({
		{ key = "P", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
		{
			key = "p",
			mods = "LEADER",
			action = sessionizer.show({
				schema = schema,
				processing = {
					sessionizer.for_each_entry(function(entry)
						entry.label = wezterm.format({
							{ Text = entry.label:gsub(wezterm.home_dir, "~") },
						})
					end),
					sessionizer.for_each_entry(function(entry)
						entry.label = wezterm.format({
							-- { Background = { Color = "#101010" } },
							-- { Foreground = { Color = "#d8a16c" } },
							{ Text = wezterm.nerdfonts.cod_folder_opened .. "  " },
							{ Foreground = { Color = "#7a8aa6" } },
							-- { Background = { Color = "#101010" } },
							{ Text = entry.label },
						})
					end),
				},
			}),
		},
	}) do
		table.insert(config.keys, key_mapping)
	end
end

M.zoxide = function()
	return function()
		local res = {}

		local success, stdout, stderr = utils.run_command({
			"/bin/zsh",
			"-c",
			"-l",
			'source ~/.exports.zsh && eval "$(zoxide init zsh)" && zoxide query -l',
		})

		if not success then
			wezterm.log_error("Error running zoxide: " .. stderr)
			return res
		end

		if stdout == "" then
			wezterm.log_info("No zoxide results")
			return res
		end

		for line in stdout:gmatch("[^\n]+") do
			table.insert(res, { label = line, id = line })
		end

		return res
	end
end

return M
