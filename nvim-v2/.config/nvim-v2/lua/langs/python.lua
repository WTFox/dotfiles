-- Framework-agnostic Python configuration for Neovim
-- Only LSP and test adapter configuration

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'rst', 'python' } },
  },
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    cmd = 'VenvSelect',
    ft = 'python',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('venv-selector').setup {
        settings = {
          options = {
            notify_user_on_venv_activation = true,
          },
        },
      }
    end,
    keys = {
      { '<leader>cv', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' },
    },
  },
}
