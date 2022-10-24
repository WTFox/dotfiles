local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

local function info_string()
  local total_plugins = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return "   " .. total_plugins .. " plugins" .. nvim_version_info
end

dashboard.section.header.val = {
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⡆⠀⠀⠀⢸⣿⣿⠿⠿⢿⣿⣿⣿⣿⡿⠿⠿⣿⣿⡇⠀⠀⠀⣾⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢿⣿⠿⠿⠿⠿⣿⣿⣿⡏⠀⠀⠀⢹⣿⡇⠀⠀⠀⢸⣿⢱⣶⣴⣶⢹⣿⣿⡏⣶⣦⣶⡎⣿⡇⠀⠀⠀⢿⣿⠁⠀⠀⠈⣿⣿⣿⡿⠟⣋⣽⣿⣿⠇⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠘⣿⣧⣄⣀⣴⣿⣿⣿⣷⣄⣀⣠⣾⣟⠀⠀⠀⠀⠈⣿⣦⣙⣛⣡⣾⡿⢿⣷⣌⣛⣋⣴⣿⠁⠀⠀⠀⠘⣿⣦⣄⣀⣴⣿⣿⣿⣿⣶⣶⣤⣿⡟⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣏⣼⣌⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣰⣆⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣏⣼⣌⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠉⠉⢿⣿⣿⣿⣿⣿⣿⡏⠉⠁⠀⠀⠀⠀⠀⠀⠀⠉⠉⢹⣿⣿⣿⣿⣿⣿⡏⠉⠉⠀⠀⠀⠀⠀⠀⠀⠉⠉⣿⣿⣿⣿⣿⣿⣿⡏⠉⠁⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠁⠁⠉⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠁⠉⠉⠈⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠁⠁⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}

dashboard.section.buttons.opts.spacing = 0
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("pc", "  Project Config", ":EditProjectConfig<CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
  dashboard.button("r", "  Reload Config", ":source $MYVIMRC<CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = fortune()

dashboard.config.layout = {
  dashboard.section.header,
  { type = "padding", val = 2 },
  { type = "text", val = "neovim", opts = { hl = "Number", position = "center" } },
  { type = "text", val = info_string(), opts = { position = "center" } },
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
  dashboard.section.footer,
}

alpha.setup(dashboard.config)
