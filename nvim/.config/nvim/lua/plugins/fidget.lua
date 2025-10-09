return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        progress = {
            poll_rate = 0,
            suppress_on_insert = false,
            ignore_done_already = false,
            ignore_empty_message = false,
            display = {
                render_limit = 16,
                done_ttl = 3,
                done_icon = "✔",
                done_style = "Constant",
                progress_ttl = 15, -- Auto-clear progress after 15 seconds
                progress_icon = { pattern = "dots", period = 1 },
                progress_style = "WarningMsg",
                group_style = "Title",
                icon_style = "Question",
                priority = 30,
                skip_history = true,
                format_message = function(msg)
                    if msg.message then
                        return msg.message
                    else
                        return msg.done and "Completed" or "In progress..."
                    end
                end,
                format_annote = function(msg)
                    return msg.title
                end,
                format_group_name = function(group)
                    return tostring(group)
                end,
                overrides = {
                    rust_analyzer = { name = "rust-analyzer" },
                },
            },
        },
        notification = {
            window = {
                normal_hl = "Comment",
                winblend = 0,
                border = "none",
                zindex = 45,
                max_width = 0,
                max_height = 0,
                x_padding = 1,
                y_padding = 0,
                align = "bottom",
                relative = "editor",
            },
        },
    },
}
