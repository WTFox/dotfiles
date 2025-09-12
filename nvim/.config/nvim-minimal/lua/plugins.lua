return {
    -- Color
    { src = "https://github.com/wtfox/jellybeans.nvim" },
    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    -- Autocompletion
    { src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range("^1") },
    { src = "https://github.com/github/copilot.vim" },
    -- Git
    { src = "https://github.com/vieitesss/gh-permalink.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    -- Navigation
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/cbochs/grapple.nvim" },
    -- Utilities
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MagicDuck/grug-far.nvim" },
    { src = "https://github.com/monaqa/dial.nvim" },
    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
}
