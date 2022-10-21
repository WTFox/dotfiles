local status_ok, refactoring = pcall(require, "refactoring")
if not status_ok then
  return
end

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

vim.api.nvim_set_keymap(
  "v",
  "<C-r>",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)
telescope.load_extension("refactoring")

refactoring.setup({})
