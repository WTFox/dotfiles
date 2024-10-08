local wezterm = require('wezterm')
local util = require('tabline.util')
local config = require('tabline.config')

local M = {}

local function correct_window(window)
  if window then
    if window.gui_window then
      window = window:gui_window()
    end
  end
  return window
end

local function set_attributes(sections, colors, window)
  config.sections = sections
  config.colors.normal_mode = colors
  if window and window.window_id then
    require('tabline.component').set_status(window)
  end
end

local function on_show_event(event, events, sections, colors)
  wezterm.on(event, function(window, ...)
    window = correct_window(window)
    set_attributes(sections, colors, window)
    if not events.hide then
      wezterm.time.call_after(events.delay or 5, function()
        set_attributes(config.opts.sections, config.normal_mode_colors, window)
      end)
    end
    if events.callback then
      events.callback(window, ...)
    end
  end)
end

local function on_hide_event(event, events)
  wezterm.on(event, function(window)
    window = correct_window(window)
    if events.delay then
      wezterm.time.call_after(events.delay, function()
        set_attributes(config.opts.sections, config.normal_mode_colors, window)
      end)
    else
      set_attributes(config.opts.sections, config.normal_mode_colors, window)
    end
  end)
end

local function setup_extension(extension)
  local sections = util.deep_extend(util.deep_copy(config.opts.sections), extension.sections or {})
  local colors = util.deep_extend(util.deep_copy(config.normal_mode_colors), extension.colors or {})
  local events = extension.events
  if sections and events then
    if type(events.show) == 'string' then
      on_show_event(events.show, events, sections, colors)
    else
      for _, event in ipairs(events.show) do
        on_show_event(event, events, sections, colors)
      end
    end
    if events.hide then
      if type(events.hide) == 'string' then
        on_hide_event(events.hide, events)
      elseif type(events.hide) == 'table' then
        for _, event in ipairs(events.hide) do
          on_hide_event(event, events)
        end
      end
    end
  end
end

function M.load()
  for _, extension in ipairs(config.opts.extensions) do
    if type(extension) == 'string' then
      local internal_extension = require('tabline.extensions.' .. extension)
      for _, ext in ipairs(internal_extension) do
        setup_extension(ext)
      end
    elseif type(extension) == 'table' then
      setup_extension(extension)
    end
  end
end

return M
