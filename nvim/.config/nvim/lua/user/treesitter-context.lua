local status_ok, context = pcall(require, "treesitter-context")
if not status_ok then
	return
end

context.setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  })
