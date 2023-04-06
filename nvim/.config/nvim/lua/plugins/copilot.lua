local copilot = require("lazyvim.plugins.extras.coding.copilot")

for _, item in ipairs(copilot) do
  if item[1] == "zbirenbaum/copilot.lua" then
    item.opts.panel = { enabled = true }
  end
end

return copilot
