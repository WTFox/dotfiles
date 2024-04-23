local Utils = require("utils")

return {
  "zbirenbaum/copilot.lua",
  enabled = Utils.on_personal_laptop(),
  opts = {
    panel = {
      enabled = true,
    },
  },
}
