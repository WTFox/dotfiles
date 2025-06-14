require 'config.autocmds'
require 'config.health'
require 'config.options'
require 'config.keymaps'
require 'utils'

require 'config.lazy'

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
