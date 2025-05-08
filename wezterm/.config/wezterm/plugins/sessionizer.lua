local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}

M.setup = function(config)
	local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
	local schema = {
		M.zoxide(),
	}

	table.insert(config.keys, {
		key = "s",
		mods = "LEADER",
		action = sessionizer.show({
			schema = schema,
		}),
	})
end

M.zoxide = function()
	return function()
		local res = {}
		local success, stdout, stderr = wezterm.run_child_process({
			"/bin/zsh",
			"-c",
			"-l",
			"source ~/.zshrc && zoxide query -l",
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
