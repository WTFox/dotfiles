return {
    -- jellybeans (dark) and modus (light) load eagerly; auto-dark-mode.lua
    -- switches between them. github/koda/vague are lazy, reachable via the
    -- Snacks colorscheme picker (<leader>uC).
    { import = "plugins.colors.github" },
    { import = "plugins.colors.jellybeans" },
    { import = "plugins.colors.koda" },
    { import = "plugins.colors.modus" },
    { import = "plugins.colors.vague" },
}
