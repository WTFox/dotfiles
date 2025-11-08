local wezterm = require("wezterm") --[[@as Wezterm]]
local utils = require("lib.utils")

local M = {}

M.setup = function(config)
	local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")

	-- Helper function to get active workspace paths
	local function get_active_workspaces()
		local active = {}
		local mux = wezterm.mux
		for _, workspace in ipairs(mux.get_workspace_names()) do
			active[workspace] = true
		end
		return active
	end

	-- Function to get deduplicated items from all sources
	local function get_deduped_schema()
		return function()
			local items = {}
			local seen = {}

			-- Add active workspaces first
			local active_items = sessionizer.AllActiveWorkspaces()()
			for _, item in ipairs(active_items) do
				if not seen[item.id] and not seen[item.label] then
					table.insert(items, item)
					seen[item.id] = true
					seen[item.label] = true
				end
			end

			-- Add zoxide items (skip duplicates)
			local zoxide_items = M.zoxide()()
			for _, item in ipairs(zoxide_items) do
				if not seen[item.id] and not seen[item.label] then
					table.insert(items, item)
					seen[item.id] = true
					seen[item.label] = true
				end
			end

			return items
		end
	end

	for _, key_mapping in ipairs({
		{ key = "P", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				-- Get active workspaces at the time of invocation
				local active_workspaces = get_active_workspaces()

				local action = sessionizer.show({
					schema = { get_deduped_schema() },
					options = {
						title = "Switch Workspace",
						prompt = " ",
					},
					processing = {
						sessionizer.for_each_entry(function(entry)
							-- Replace home directory with ~
							local display_path = entry.label:gsub(wezterm.home_dir, "~")

							-- Check if this path corresponds to an active workspace
							local is_active = active_workspaces[entry.id] or active_workspaces[entry.label] or false

							-- Choose dot indicator and colors based on active status
							local dot = is_active and "● " or "○ "

							local dot_color = is_active and "#bb9dbd" or "#9ca3af"
							local text_color = is_active and "#bb9dbd" or "#9ca3af"

							-- Format with dot indicator and appropriate colors
							entry.label = wezterm.format({
								{ Foreground = { Color = dot_color } },
								{ Text = dot },
								{ Foreground = { Color = text_color } },
								{ Attribute = { Intensity = is_active and "Bold" or "Normal" } },
								{ Text = display_path },
							})
						end),
					},
				})

				window:perform_action(action, pane)
			end),
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
