-- internal state for toggles
local state = {
    show_path = false,
    show_branch = true,
}

-- config for placeholders + highlighting
local config = {
    icons = {
        branch_hidden = " ",
        hint = "",
        error = "",
        warn = "",
        info = "",
    },
    placeholder_hl = "StatusLineDim", -- a dim highlight group we define below
}

-- helper to wrap text in a statusline highlight group
local function hl(group, text)
    return string.format("%%#%s#%s%%*", group, text)
end

-- set dim highlight group
vim.api.nvim_set_hl(0, config.placeholder_hl, { link = "Comment" })

local function shorten_path(path, opts)
    opts = opts or {}
    local short_len = opts.short_len or 1
    local tail_count = opts.tail_count or 2
    local head_max = opts.head_max or 0
    local relative = (opts.relative == nil) and true or opts.relative
    local return_tbl = opts.return_table or false

    -- Normalize to relative if requested
    if relative then
        path = vim.fn.fnamemodify(path, ":.")
    end

    -- OS path separator (same thing plenary.path.sep uses)
    local sep = package.config:sub(1, 1)

    -- Split path quickly; trimempty=true matches vim.split default behavior
    local components = vim.split(path, sep, { plain = true, trimempty = true })
    local n = #components

    -- Single (or empty) component: mirror your old behavior
    if n <= 1 then
        if return_tbl then
            return { nil, path }
        end
        return path
    end

    -- Compute head/tail ranges
    if tail_count < 0 then
        tail_count = 0
    end
    if tail_count > n then
        tail_count = n
    end

    local head_end = n - tail_count
    local head = {}
    if head_end > 0 then
        -- Respect head_max (keep only the LAST head_max elements if exceeding)
        local head_start = 1
        if head_max > 0 and head_end > head_max then
            head_start = head_end - head_max + 1
        end
        local hsz = 0
        for i = head_start, head_end do
            hsz = hsz + 1
            head[hsz] = components[i]
        end
    end

    local tail = {}
    do
        local tsz = 0
        for i = head_end + 1, n do
            tsz = tsz + 1
            tail[tsz] = components[i]
        end
    end

    -- Shorten each head segment to `short_len`, preserving a leading dot
    local function shorten(seg)
        if short_len <= 0 then
            return seg
        end
        if seg:sub(1, 1) == "." and #seg > 1 then
            return "." .. seg:sub(2, 1 + short_len)
        end
        return seg:sub(1, short_len)
    end

    local head_short = nil
    if #head > 0 then
        for i = 1, #head do
            head[i] = shorten(head[i])
        end
        head_short = table.concat(head, sep)
    end

    local tail_str = table.concat(tail, sep)

    if return_tbl then
        -- Keep same shape as your original: { shortened_head_or_nil, full_tail }
        return { head_short, tail_str }
    end

    -- Join like original: "head_short/TAIL..." (or just tail if no head)
    if head_short and #head_short > 0 then
        return head_short .. sep .. tail_str
    else
        return tail_str
    end
end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")

    if fpath == "" or fpath == "." then
        return ""
    end

    if state.show_path then
        return string.format("%%<%s/", fpath)
    end

    return hl(config.placeholder_hl, shorten_path(fpath, {
        short_len = 1,
        tail_count = 1,
        head_max = 3,
    }) .. "/")
end

local function git()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    local head = git_info.head
    local added = (git_info.added and git_info.added > 0) and hl("DiffAdd", " +" .. git_info.added) or ""
    local changed = (git_info.changed and git_info.changed > 0) and hl("DiffChange", " ~" .. git_info.changed) or ""
    local removed = (git_info.removed and git_info.removed > 0) and hl("DiffDelete", " -" .. git_info.removed) or ""

    if not state.show_branch then
        head = hl(config.placeholder_hl, config.icons.branch_hidden)
    end

    return table.concat({
        "[ ",
        head,
        added,
        changed,
        removed,
        "]",
    })
end

local function diagnostics()
    -- Fast path: if the built-in status says empty, bail
    local status = vim.diagnostic.status()
    if not status or status == "" then
        return ""
    end

    -- Count by severity in the current buffer
    local bufnr = 0
    local severities = vim.diagnostic.severity
    local counts = { [severities.ERROR] = 0, [severities.WARN] = 0, [severities.INFO] = 0, [severities.HINT] = 0 }

    for _, d in ipairs(vim.diagnostic.get(bufnr)) do
        counts[d.severity] = (counts[d.severity] or 0) + 1
    end

    -- Build colored chunks (only show nonzero)
    local parts = {}

    if counts[severities.ERROR] > 0 then
        table.insert(parts, hl("DiagnosticError", string.format("E:%d ", counts[severities.ERROR])))
    end
    if counts[severities.WARN] > 0 then
        table.insert(parts, hl("DiagnosticWarn", string.format("W:%d ", counts[severities.WARN])))
    end
    if counts[severities.INFO] > 0 then
        table.insert(parts, hl("DiagnosticInfo", string.format("I:%d ", counts[severities.INFO])))
    end
    if counts[severities.HINT] > 0 then
        table.insert(parts, hl("DiagnosticHint", string.format("H:%d", counts[severities.HINT])))
    end

    if #parts == 0 then
        return ""
    end

    return "[" .. table.concat(parts, "") .. "]"
end

Statusline = {}

function Statusline.active()
    return table.concat({
        "[",
        filepath(),
        "%t] ",
        git(),
        " ",
        diagnostics(),
        "%=",
        "%y [%P %l:%c]",
    })
end

function Statusline.inactive()
    return " %t"
end

function Statusline.toggle_path()
    state.show_path = not state.show_path
    vim.cmd("redrawstatus")
end

function Statusline.toggle_branch()
    state.show_branch = not state.show_branch
    vim.cmd("redrawstatus")
end

vim.keymap.set("n", "<leader>sp", function()
    Statusline.toggle_path()
end, { desc = "Toggle statusline path" })
vim.keymap.set("n", "<leader>sb", function()
    Statusline.toggle_branch()
end, { desc = "Toggle statusline git branch" })

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})
