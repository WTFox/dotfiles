local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")

local fuzzy_sorter = sorters.get_generic_fuzzy_sorter()

-- sorter that moves less important entries to the bottom
local sorter = sorters.Sorter:new({
  scoring_function = function(_, prompt, line, entry, cb_add, cb_filter)
    local base_score = fuzzy_sorter:scoring_function(prompt, line, cb_add, cb_filter)

    if entry.value.is_test_file then
      base_score = base_score + 100
    end

    if entry.value.is_inside_import then
      base_score = base_score + 200
    end

    return base_score
  end,
  highlighter = fuzzy_sorter.highlighter,
})

local function filter_entries(results)
  local function should_include_entry(entry)
    -- if entry is closing tag - just before it there is a closing tag syntax '</'
    if entry.col > 2 and entry.text:sub(entry.col - 2, entry.col - 1) == "</" then
      return false
    end

    return true
  end

  return vim.tbl_filter(should_include_entry, vim.F.if_nil(results, {}))
end

--- @return table
local function add_metadata_to_locations(locations)
  return vim.tbl_map(function(location)
    if string.find(location.text, "^import") then
      location.is_inside_import = true
    end

    if string.find(location.filename, ".spec.") or string.find(location.filename, "TestBuilder") then
      location.is_test_file = true
    end

    return location
  end, locations)
end

local function handle_references_response(result)
  local locations = vim.lsp.util.locations_to_items(result, "utf-16")
  local filtered_entries = filter_entries(locations)
  pickers
    .new({}, {
      prompt_title = "References",
      finder = finders.new_table({
        results = add_metadata_to_locations(filtered_entries),
        entry_maker = require("telescope.make_entry").gen_from_quickfix(),
      }),
      previewer = require("telescope.config").values.qflist_previewer({}),
      sorter = sorter,
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
      initial_mode = "insert",
    })
    :find()
end

-- handle_references_response,
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gd", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
  {
    "KostkaBrukowa/definition-or-references.nvim",
    opts = {
      on_references_result = handle_references_response,
    },
    keys = {
      {
        "gd",
        function()
          require("definition-or-references").definition_or_references()
        end,
        { silent = false, desc = "Definition or References" },
      },
    },
  },
}
