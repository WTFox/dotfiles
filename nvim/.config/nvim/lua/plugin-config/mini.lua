require('mini.ai').setup()
require('mini.basics').setup()
require('mini.bufremove').setup()
require('mini.diff').setup()
require('mini.files').setup()
require('mini.move').setup()
require('mini.splitjoin').setup()
require('mini.trailspace').setup()

require('mini.surround').setup({
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

local miniclue = require('mini.clue')
require('mini.clue').setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

local starter = require('mini.starter')
starter.setup({
    evaluate_single = true,
    header = [[ i'm sorry, dave. i can't do that. ]],
    items = {
        { name = 'Files', action = 'FzfLua git_files', section = 'Builtin actions' },
        starter.sections.builtin_actions(),
        -- starter.sections.recent_files(10, false),
        starter.sections.recent_files(10, true),
        starter.sections.sessions(5, true)
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing('all', { 'Builtin actions' }),
        starter.gen_hook.padding(3, 2),
    },
})

-- Helper function to get project-based session name
local function get_session_name()
    local project_name
    -- Try to use git root as project identifier
    local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
    if vim.v.shell_error == 0 and git_root ~= '' then
        project_name = vim.fn.fnamemodify(git_root, ':t')
    else
        -- Fallback to current directory basename
        project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end
    return project_name .. '.vim'
end

require('mini.sessions').setup({
    directory = vim.fn.stdpath('data') .. '/sessions',
})

local sessions_group = vim.api.nvim_create_augroup('MiniSessionsAuto', { clear = true })

-- Auto-read session when vim starts
vim.api.nvim_create_autocmd('VimEnter', {
    group = sessions_group,
    nested = true,
    callback = function()
        -- Only auto-read if no files were opened and we're not in the home directory
        if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 and vim.fn.getcwd() ~= vim.env.HOME then
            local session_file = get_session_name()
            local session_path = require('mini.sessions').config.directory .. '/' .. session_file
            if vim.fn.filereadable(session_path) == 1 then
                require('mini.sessions').read(session_file)
            end
        end
    end
})

-- Auto-write session when vim exits
vim.api.nvim_create_autocmd('VimLeavePre', {
    group = sessions_group,
    callback = function()
        -- Only auto-write if we're in a project directory
        local cwd = vim.fn.getcwd()
        if cwd and cwd ~= vim.env.HOME then
            local session_file = get_session_name()
            require('mini.sessions').write(session_file)
        end
    end
})
