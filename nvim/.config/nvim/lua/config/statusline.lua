-- internal state for toggles
local state = {
    show_path = false,
}

-- config for placeholders + highlighting
local config = {
    placeholder_hl = "StatusLineDim", -- a dim highlight group we define below
}

-- helper to wrap text in a statusline highlight group
local function hl(group, text)
    return string.format("%%#%s#%s%%*", group, text)
end

-- set dim highlight group
vim.api.nvim_set_hl(0, config.placeholder_hl, { link = "Comment" })

-- Shorten a relative directory path to its last component, abbreviating up to
-- 3 preceding components to a single character each
-- (e.g. "lua/config/plugins/colors" -> "l/c/p/colors")
local function shorten_path(path)
    local sep = package.config:sub(1, 1)
    local components = vim.split(path, sep, { plain = true, trimempty = true })
    local n = #components
    if n <= 1 then
        return path
    end

    local head_start = math.max(1, n - 3)
    local head = {}
    for i = head_start, n - 1 do
        head[#head + 1] = components[i]:sub(1, 1)
    end

    return table.concat(head, sep) .. sep .. components[n]
end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")

    if fpath == "" or fpath == "." then
        return ""
    end

    if state.show_path then
        return string.format("%%<%s/", fpath)
    end

    return hl(config.placeholder_hl, shorten_path(fpath) .. "/")
end

local function git()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    local added = (git_info.added and git_info.added > 0) and hl("DiffAdd", " +" .. git_info.added) or ""
    local changed = (git_info.changed and git_info.changed > 0) and hl("DiffChange", " ~" .. git_info.changed) or ""
    local removed = (git_info.removed and git_info.removed > 0) and hl("DiffDelete", " -" .. git_info.removed) or ""

    return table.concat({
        "[ ",
        git_info.head,
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

-- <leader>sp is Snacks' "Search for Plugin Spec" (see snacks.lua)
vim.keymap.set("n", "<leader>uP", Statusline.toggle_path, { desc = "Toggle statusline path" })

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        if vim.api.nvim_win_get_config(0).relative ~= "" then
            return
        end
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        if vim.api.nvim_win_get_config(0).relative ~= "" then
            return
        end
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})
