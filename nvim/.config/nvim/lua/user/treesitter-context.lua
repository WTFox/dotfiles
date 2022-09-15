local status_ok, ts_context = pcall(require, "treesitter-context")
if not status_ok then
  return
end

ts_context.setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = -1, -- How many lines the window should span. Values <= 0 mean no limit.
})
