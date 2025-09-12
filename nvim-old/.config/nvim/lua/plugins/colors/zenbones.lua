-- adjust contrast
vim.g.tokyobones = { darkness = "stark" }
vim.g.zenbones = { lightness = "bright" }

-- remove Lush as dependency
vim.g.zenbones_compat = 1

return {
  "mcchrish/zenbones.nvim",
  dependencies = {
    "rktjmp/lush.nvim",
  },
}
