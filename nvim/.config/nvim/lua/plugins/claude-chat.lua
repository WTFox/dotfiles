return {
    "wtfox/claude-chat.nvim",
    config = true,
    dev = true,
    ---@type claude-chat.Config
    opts = {
        split = "vsplit",
        position = "right", --ignored for float
        width = 0.4, -- percentage of screen width (for vsplit or float)
        height = 0.8, -- percentage of screen height (for split or float)
        claude_cmd = "claude", -- command to invoke Claude Code
        float_opts = {
            relative = "editor",
            border = "rounded",
            title = " Claude Chat ",
            title_pos = "center",
        },
        keymaps = {
            global = "<C-.>", -- Global keymap for ClaudeChat command (set to nil to disable)
            terminal = {
                close = "<C-q>", -- Close chat from terminal mode
                toggle = "<C-.>", -- Toggle chat window visibility
                normal_mode = "<Esc><Esc>", -- Exit terminal mode to normal mode
                insert_file = "<C-f>", -- Insert current file path
                interrupt = "<C-c>", -- Interrupt/close chat
            },
        },
    },
}
