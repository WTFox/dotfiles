-- Auto-resize event for WezTerm to maximize space usage
-- Targets font size around 16 with tight constraints

local wezterm = require("wezterm")

-- wezterm.on("update-right-status", function(window, pane)
--     local dimensions = pane:get_dimensions()
--
--     local cols = dimensions and dimensions.cols or "N/A"
--     local rows = dimensions and dimensions.viewport_rows or "N/A"
--
--     -- Create a status text with window size
--     local status_text = string.format("  %sx%s", cols, rows)
--
--     -- Set the status text to display in the right status area
--     window:set_right_status(wezterm.format({
--         { Text = status_text },
--     }))
-- end)
--
-- Configuration for auto-resize
local AUTO_RESIZE = {
    target_size = 16.0, -- Target font size
    min_font_size = 15.0, -- Minimum allowed (tight range)
    max_font_size = 17.0, -- Maximum allowed (tight range)
    step_size = 0.1, -- Fine adjustments
    pixel_tolerance = 0, -- Zero wasted pixels
    debounce_ms = 500, -- Prevent flicker
}

-- State tracking
local resize_state = {
    pending_resize = nil,
    last_window_size = { width = 0, height = 0 },
}

-- Find optimal font size within tight range
local function optimize_font_size(window, pane)
    local window_dims = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}

    local best_size = AUTO_RESIZE.target_size
    local min_waste = math.huge

    -- Test each size in the range
    local test_size = AUTO_RESIZE.min_font_size

    while test_size <= AUTO_RESIZE.max_font_size do
        -- Apply test size
        overrides.font_size = test_size
        window:set_config_overrides(overrides)
        wezterm.sleep_ms(5)

        -- Measure waste
        local pane_dims = pane:get_dimensions()
        local height_waste = window_dims.pixel_height - pane_dims.pixel_height
        local width_waste = window_dims.pixel_width - pane_dims.pixel_width

        -- Check if this size fits and is better
        if height_waste >= 0 and width_waste >= 0 then
            -- Prefer sizes closer to target with minimal waste
            local distance_from_target = math.abs(test_size - AUTO_RESIZE.target_size)
            local weighted_waste = height_waste + (distance_from_target * 10)

            if weighted_waste < min_waste then
                best_size = test_size
                min_waste = weighted_waste
            end

            -- Perfect fit at target size - stop searching
            if height_waste <= AUTO_RESIZE.pixel_tolerance and test_size == AUTO_RESIZE.target_size then
                break
            end
        end

        test_size = test_size + AUTO_RESIZE.step_size
    end

    -- Apply best size found
    overrides.font_size = best_size
    window:set_config_overrides(overrides)

    return best_size
end

-- Check if presentation mode is active
local function is_presentation_mode(window)
    local overrides = window:get_config_overrides() or {}

    -- Check if font size is outside our normal dynamic range
    -- This indicates presentation mode (or manual override) is active
    if overrides.font_size then
        local font_size = overrides.font_size
        if font_size < AUTO_RESIZE.min_font_size - 0.5 or font_size > AUTO_RESIZE.max_font_size + 0.5 then
            return true
        end
    end

    -- Also check for common presentation mode overrides
    if overrides.enable_tab_bar == false or overrides.presentation_mode == true then
        return true
    end

    return false
end

-- Main resize handler
local function readjust_font_size(window, pane)
    -- Skip if presentation mode is active
    if is_presentation_mode(window) then
        return
    end

    local window_dims = window:get_dimensions()

    -- Skip if window size hasn't changed significantly
    if
        math.abs(window_dims.pixel_width - resize_state.last_window_size.width) < 2
        and math.abs(window_dims.pixel_height - resize_state.last_window_size.height) < 2
    then
        return
    end

    -- Update tracked size
    resize_state.last_window_size = {
        width = window_dims.pixel_width,
        height = window_dims.pixel_height,
    }

    -- Find and apply optimal size
    optimize_font_size(window, pane)
end

-- Debounced wrapper to prevent excessive recalculation
local function debounced_readjust(window, pane)
    if resize_state.pending_resize then
        wezterm.cancel_timeout(resize_state.pending_resize)
    end

    resize_state.pending_resize = wezterm.time.call_after(AUTO_RESIZE.debounce_ms / 1000, function()
        readjust_font_size(window, pane)
        resize_state.pending_resize = nil
    end)
end

-- Register resize event
wezterm.on("window-resized", function(window, pane)
    debounced_readjust(window, pane)
end)

-- Also adjust when window gains focus
wezterm.on("window-focus-changed", function(window, pane)
    if window:is_focused() then
        readjust_font_size(window, pane)
    end
end)

-- Initial adjustment for new windows
wezterm.on("gui-startup", function()
    wezterm.time.call_after(0.5, function()
        local windows = wezterm.gui.gui_windows()
        for _, window in ipairs(windows) do
            local pane = window:active_pane()
            if pane then
                readjust_font_size(window, pane)
            end
        end
    end)
end)

return {}
