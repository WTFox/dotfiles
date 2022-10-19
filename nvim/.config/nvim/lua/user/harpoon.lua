local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension('harpoon')
harpoon.setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})
