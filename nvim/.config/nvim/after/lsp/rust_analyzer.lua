---@type vim.lsp.Config
return {
    cmd = { vim.fn.expand('~/.cargo/bin/rust-analyzer') },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' }
}
