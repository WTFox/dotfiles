return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
        -- main branch: setup() only accepts install_dir
        -- ensure_installed is gone; call install() directly
        require("nvim-treesitter").install({
            "bash",
            "c",
            "comment",
            "css",
            "diff",
            "dockerfile",
            "elixir",
            "fish",
            "git_config",
            "gitcommit",
            "gitignore",
            "go",
            "groovy",
            "hcl",
            "heex",
            "html",
            "htmldjango",
            "http",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rst",
            "rust",
            "scss",
            "sql",
            "ssh_config",
            "terraform",
            "toml",
            "tsx",
            "typescript",
            "typst",
            "vim",
            "vimdoc",
            "yaml",
        })

        -- main branch: highlight auto-attach is gone; do it per FileType
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
                if ok and stats and stats.size > max_filesize then
                    return
                end
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
    end,
}
