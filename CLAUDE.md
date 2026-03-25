# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Applying Changes

Config is managed with **GNU Stow**. After editing files, symlinks are already in place — no extra step needed. To re-run stow (e.g. after adding new files):

```bash
./stow.sh          # stow all packages
stow -d . <pkg>    # stow a single package (e.g. nvim, tmux, zsh)
```

To bootstrap a fresh machine:

```bash
./bootstrap.sh
```

## Repository Structure

Each top-level directory is a stow package. Stow mirrors the directory tree from the package root into `$HOME`. For example:
- `nvim/.config/nvim/` → `~/.config/nvim/`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `bin/bin/` → `~/bin/`
- `zsh/.zshrc` → `~/.zshrc`

Key packages: `nvim`, `tmux`, `zsh`, `git`, `wezterm`, `ghostty`, `bin`, `claude`, `hammerspoon` (macOS only).

## Neovim Config Architecture

**Plugin manager:** Lazy.nvim (bootstrapped in `lua/config/lazy.lua`)

```
nvim/.config/nvim/
├── init.lua              # Entry point — requires config/* modules
├── lsp/                  # Per-server LSP configs (one file per server)
├── lua/
│   ├── config/
│   │   ├── options.lua   # Vim options and diagnostics settings
│   │   ├── keymaps.lua   # All keybindings
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── lazy.lua      # Lazy.nvim setup and plugin loading
│   │   └── statusline.lua
│   └── plugins/          # One file per plugin or plugin group
└── lazy-lock.json        # Pin file — commit changes after :Lazy update
```

LSP servers are configured in `lsp/` as standalone files and loaded via `vim.lsp.config` / `vim.lsp.enable`. Mason manages server binaries.

Two plugins are loaded from a **local dev path** (`~/dev/nvim-plugins/`): `jellybeans.nvim` and `claude-chat.nvim`. When working on those, changes are picked up immediately without reinstalling.

## Tmux Config

Single file: `tmux/.tmux.conf`. Plugins managed by TPM (in `tmux/.tmux/plugins/`). After editing, reload with `prefix+r`.

Notable bindings: `prefix+|` (vsplit), `prefix+-` (hsplit), `prefix+g` (lazygit), `prefix+c` (claude), `prefix+p` (tmux-sessionizer), `prefix+X` (prompt to run command in new pane).

## Shell (Zsh)

`zsh/.zshrc` sources modular files from `zsh/`:
- `.zsh_aliases`, `.zsh_functions`, `.zsh_exports`
- Platform-specific: `.zsh_macos` / `.zsh_linux`

Key shell integrations: fzf, zoxide (`Ctrl-G`), yazi (`Ctrl-O`), tmux-sessionizer (`Ctrl-T`).

## Custom Scripts

`bin/bin/` — scripts symlinked to `~/bin/`:
- `tmux-sessionizer` — fzf-based tmux session switcher; searches `~/dev/` and `~/dev/nvim-plugins/`
- `screensaver.sh`, `interactive-commit`, `alert`

## Claude AI Config

`claude/.claude/` — symlinked to `~/.claude/`. Contains:
- `CLAUDE.md` — global user preferences (response style, workflow rules)
- `commands/` — slash commands (commit, debug, refactor, etc.)
- `agents/` — subagent definitions
- `skills/` — reusable skill prompts
