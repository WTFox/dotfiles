return {
  "ThePrimeagen/harpoon",
  enabled = false,
  config = function()
    require("harpoon").setup()
    require("telescope").load_extension("harpoon")
  end,
  keys = {
    { "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon" },
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon" },
    { "<leader>ht", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon" },
    { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Goto File 1" },
    { "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Goto File 2" },
    { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Goto File 1" },
  },
}
