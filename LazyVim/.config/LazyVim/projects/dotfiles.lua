local neotree_show_hidden = function()
  local config = require("neo-tree").config
  if not config then
    return
  end

  config.filesystem.filtered_items = {
    visible = true, -- when true, they will just be displayed differently than normal items
    hide_dotfiles = false,
    hide_gitignored = true,
    hide_hidden = false, -- only works on Windows for hidden files/directories
  }

  require("neo-tree").setup(config)
end

neotree_show_hidden()
