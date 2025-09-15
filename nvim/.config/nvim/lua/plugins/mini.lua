local setup_surround = function()
    require("mini.surround").setup({
        mappings = {
            add = "gsa",
            delete = "gsd",
            find = "gsf",
            find_left = "gsF",
            highlight = "gsh",
            replace = "gsr",
            update_n_lines = "gsn",
        },
    })
end

local setup_clue = function()
    local miniclue = require("mini.clue")
    require("mini.clue").setup({
        triggers = {
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },
            { mode = "i", keys = "<C-x>" },
            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },
            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },
            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },
            { mode = "n", keys = "<C-w>" },
            { mode = "n", keys = "z" },
            { mode = "x", keys = "z" },
        },
        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
            -- Custom leader key groups
            { mode = "n", keys = "<Leader>a", desc = "+AI" },
            { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
            { mode = "n", keys = "<Leader>c", desc = "+Code" },
            { mode = "n", keys = "<Leader>d", desc = "+Diagnostics" },
            { mode = "n", keys = "<Leader>f", desc = "+Find" },
            { mode = "n", keys = "<Leader>g", desc = "+Git" },
            { mode = "n", keys = "<Leader>gh", desc = "+Git Hunks" },
            { mode = "n", keys = "<Leader>p", desc = "+Project" },
            { mode = "n", keys = "<Leader>s", desc = "+Search" },
            { mode = "n", keys = "<Leader>t", desc = "+Tabs" },
            { mode = "n", keys = "<Leader>u", desc = "+UI" },
        },
    })
end

-- Helper function to get project-based session name
local function get_session_name()
    local project_name
    -- Try to use git root as project identifier
    local git_root = vim.fn
        .system("git rev-parse --show-toplevel 2>/dev/null")
        :gsub("\n", "")
    if vim.v.shell_error == 0 and git_root ~= "" then
        project_name = vim.fn.fnamemodify(git_root, ":t")
    else
        -- Fallback to current directory basename
        project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end
    return project_name .. ".vim"
end

local setup_starter = function()
    local starter = require("mini.starter")
    starter.setup({
        evaluate_single = false,
        header = [[ i'm sorry, dave. i'm afraid i can't do that.  ]],
        footer = "",
        items = {
            {
                name = "Files",
                action = "FzfLua git_files",
                section = "Builtin actions",
            },
            -- Conditional session action for current directory
            function()
                local session_file = get_session_name()
                local session_path = require("mini.sessions").config.directory
                    .. "/"
                    .. session_file
                if vim.fn.filereadable(session_path) == 1 then
                    return {
                        name = "Session",
                        action = function()
                            require("mini.sessions").read(session_file)
                        end,
                        section = "Session",
                    }
                end
                return nil
            end,
            starter.sections.builtin_actions(),
            starter.sections.recent_files(5, true),
        },
        content_hooks = {
            starter.gen_hook.adding_bullet(),
            starter.gen_hook.indexing("all", { "Builtin actions", "Session" }),
            starter.gen_hook.aligning("center", "center"),
        },
    })
end

local setup_sessions = function()
    require("mini.sessions").setup({
        directory = vim.fn.stdpath("data") .. "/sessions",
    })

    local sessions_group =
        vim.api.nvim_create_augroup("MiniSessionsAuto", { clear = true })

    -- Auto-read session when vim starts
    vim.api.nvim_create_autocmd("VimEnter", {
        group = sessions_group,
        nested = true,
        callback = function()
            -- Only auto-read if no files were opened and we're not in the home directory
            if
                vim.fn.argc() == 0
                and vim.fn.line2byte("$") == -1
                and vim.fn.getcwd() ~= vim.env.HOME
            then
                local session_file = get_session_name()
                local session_path = require("mini.sessions").config.directory
                    .. "/"
                    .. session_file
                if vim.fn.filereadable(session_path) == 1 then
                    require("mini.sessions").read(session_file)
                    -- Preload LSPs for common file types in project after session restore
                    vim.defer_fn(function()
                        local common_files = {
                            { pattern = "*.py", filetype = "python" },
                            { pattern = "*.js", filetype = "javascript" },
                            { pattern = "*.ts", filetype = "typescript" },
                            { pattern = "*.go", filetype = "go" },
                            { pattern = "*.rs", filetype = "rust" },
                            { pattern = "*.lua", filetype = "lua" },
                        }

                        for _, file_info in ipairs(common_files) do
                            local files = vim.fn.glob(file_info.pattern, false, true)
                            if #files > 0 then
                                -- Create temp buffer to trigger LSP startup
                                local temp_buf = vim.api.nvim_create_buf(false, true)
                                vim.api.nvim_buf_set_option(temp_buf, 'filetype', file_info.filetype)
                                -- Clean up temp buffer
                                vim.defer_fn(function()
                                    if vim.api.nvim_buf_is_valid(temp_buf) then
                                        vim.api.nvim_buf_delete(temp_buf, { force = true })
                                    end
                                end, 1000)
                            end
                        end
                    end, 100)
                end
            end
        end,
    })

    -- Auto-write session when vim exits
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = sessions_group,
        callback = function()
            -- Only auto-write if we're in a project directory
            local cwd = vim.fn.getcwd()
            if cwd and cwd ~= vim.env.HOME then
                local session_file = get_session_name()
                require("mini.sessions").write(session_file)
            end
        end,
    })
end

---@type PluginSpec
return {
    src = "https://github.com/nvim-mini/mini.nvim",
    config = function()
        require("mini.ai").setup()
        require("mini.basics").setup()
        require("mini.bufremove").setup()
        require("mini.move").setup()
        require("mini.splitjoin").setup()
        require("mini.trailspace").setup()

        setup_surround()
        setup_clue()
        setup_starter()
        setup_sessions()
    end,
}
