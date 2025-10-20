local wezterm = require("wezterm") --[[@as Wezterm]]
local mux = wezterm.mux

-- GUI Startup Event Handler
-- Automatically maximize the window when WezTerm starts up
-- wezterm.on("gui-startup", function()
--     -- Spawn a new window and get references to tab, pane, and window
--     local _, _, window = mux.spawn_window({})
--     -- Maximize the window for full screen usage
--     window:gui_window():maximize()
-- end)

-- Window Resize Event Handler (Currently Disabled)
-- Uncomment the lines below to enable automatic font size adjustment on window resize
wezterm.on("window-resized", function(window, pane)
    readjust_font_size(window, pane)
end)

-- Font Size Auto-Adjustment Function
-- Dynamically adjusts font size when window is resized to eliminate bottom padding
-- This ensures the terminal content fills the entire window height properly
function readjust_font_size(window, pane)
    -- Get current window and pane dimensions
    local window_dims = window:get_dimensions()
    local pane_dims = pane:get_dimensions()

    -- Initialize configuration overrides and algorithm parameters
    local config_overrides = {}
    local initial_font_size = 16 -- Starting font size for adjustment
    config_overrides.font_size = initial_font_size

    -- Algorithm constraints to prevent infinite loops
    local max_iterations = 6 -- Maximum number of adjustment attempts
    local iteration_count = 0 -- Current iteration counter
    local tolerance = 4 -- Acceptable pixel difference (3px tolerance)

    -- Calculate the initial height difference between window and pane
    local current_diff = window_dims.pixel_height - pane_dims.pixel_height
    local min_diff = math.abs(current_diff) -- Track the smallest difference found
    local best_font_size = initial_font_size -- Remember the best font size

    -- Iterative font size adjustment algorithm
    -- Continue until difference is within tolerance or max iterations reached
    while current_diff > tolerance and iteration_count < max_iterations do
        -- Debug logging: display current dimensions and font size
        wezterm.log_info(string.format(
            "Win Height: %d, Pane Height: %d, Height Diff: %d, Curr Font Size: %.2f, Cells: %d, Cell Height: %.2f",
            window_dims.pixel_height, -- Total window height in pixels
            pane_dims.pixel_height, -- Pane content height in pixels
            window_dims.pixel_height - pane_dims.pixel_height, -- Height difference
            config_overrides.font_size, -- Current font size being tested
            pane_dims.viewport_rows, -- Number of text rows visible
            pane_dims.pixel_height / pane_dims.viewport_rows -- Pixels per row
        ))

        -- Incrementally increase font size to reduce padding
        config_overrides.font_size = config_overrides.font_size + 0.5
        window:set_config_overrides(config_overrides)

        -- Recalculate dimensions after font size change
        window_dims = window:get_dimensions()
        pane_dims = pane:get_dimensions()
        current_diff = window_dims.pixel_height - pane_dims.pixel_height

        -- Track the best font size (one that produces smallest difference)
        local abs_diff = math.abs(current_diff)
        if abs_diff < min_diff then
            min_diff = abs_diff
            best_font_size = config_overrides.font_size
        end

        iteration_count = iteration_count + 1
    end

    -- Fallback: if no acceptable difference found, use the best font size discovered
    if current_diff > tolerance then
        config_overrides.font_size = best_font_size
        window:set_config_overrides(config_overrides)
    end
end

---@type StrictConfig
return {}
