require("which-key").register({
  h = { name = "Harpoon" },
}, {
  prefix = "<leader>",
})

return {
  "ThePrimeagen/harpoon",
  lazy = false,
  config = function(_, opts)
    require("harpoon").setup(opts)
    require("telescope").load_extension("harpoon")
  end,
  opts = {
    save_on_toggle = true,
    tabline = true,
  },
  keys = {
    {
      "<leader>ha",
      "<CMD>lua require('harpoon.mark').add_file()<CR>",
      desc = "Add file to harpoon",
    },
    { "<leader>hh", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Open Harpoon Menu" },
    { "<leader>ho", "<CMD>Telescope harpoon marks<CR>", desc = "Open Harpoon Marks" },
  },
}
