if true then
  return {}
end

return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<leader>sr",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      desc = "Replace in File (Spectre)",
    },
  },
}
