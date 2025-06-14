-- Blink.nvim configuration without snippet support
-- Priority: Copilot > LSP > Path > Buffer

return {
  -- Plugin name/URL
  'saghen/blink.cmp',

  -- Load on InsertEnter
  event = 'InsertEnter',

  version = 'v0.13.0',

  -- Main configuration
  opts = {
    -- Appearance settings
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      -- Kind icons
      kind_icons = {
        Copilot = '',
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Class = '󰠱',
        Interface = '󱡠',
        Module = '󱃖',
        Property = '󰖷',
        Unit = '󰪚',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Color = '󰏘',
        File = '󰈙',
        Reference = '󰬲',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '󰙅',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },

    -- Completion settings
    completion = {

      -- Trigger settings
      trigger = {
        show_in_snippet = false,
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
      },

      -- Accept settings
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },

      -- Menu configuration
      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = 'rounded',
        winblend = 0,
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        scrolloff = 2,
        scrollbar = true,
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
          },
        },
      },

      -- Documentation window
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        window = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = 'rounded',
          winblend = 0,
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
          scrollbar = true,
        },
      },

      -- Ghost text (inline suggestions from Copilot)
      ghost_text = {
        enabled = true,
      },

      -- List settings
      list = {
        max_items = 200,
      },
    },

    -- Keymap configuration (simplified without snippet navigation)
    keymap = {
      preset = 'super-tab',
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- ['<C-e>'] = { 'hide', 'fallback' },
      -- ['<C-y>'] = { 'accept', 'fallback' },
      --
      -- -- Super tab for completion navigation only
      -- ['<Tab>'] = { 'select_next', 'fallback' },
      -- ['<S-Tab>'] = { 'select_prev', 'fallback' },
      --
      -- ['<Up>'] = { 'select_prev', 'fallback' },
      -- ['<Down>'] = { 'select_next', 'fallback' },
      -- ['<C-p>'] = { 'select_prev', 'fallback' },
      -- ['<C-n>'] = { 'select_next', 'fallback' },
      --
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<CR>'] = { 'accept', 'fallback' },
    },

    -- Sources configuration with priority (no snippets)
    sources = {
      default = { 'copilot', 'lsp', 'path', 'buffer' },
      providers = {
        -- Copilot provider (highest priority)
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = 'Copilot'
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },

        -- LSP provider (second priority)
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          fallbacks = { 'buffer' },
          score_offset = 90,
          enabled = true,
        },

        -- Path provider
        path = {
          name = 'Path',
          module = 'blink.cmp.sources.path',
          score_offset = 3,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
            end,
            show_hidden_files_by_default = false,
          },
        },

        -- Buffer provider
        buffer = {
          name = 'Buffer',
          module = 'blink.cmp.sources.buffer',
          max_items = 4,
          min_keyword_length = 4,
          score_offset = 0,
        },

        -- Command line provider
        cmdline = {
          name = 'cmdline',
          module = 'blink.cmp.sources.cmdline',
        },
      },
    },

    -- Fuzzy matching configuration
    fuzzy = {
      implementation = 'prefer_rust',
      use_frecency = true,
      use_proximity = true,
      -- max_typos = 2,
      sorts = { 'score', 'kind', 'label' },
      prebuilt_binaries = {
        download = true,
        force_version = nil,
      },
    },

    -- Signature help configuration
    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = 'rounded',
        winblend = 0,
        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
        scrollbar = false,
        treesitter_highlighting = true,
      },
    },
  },

  -- Dependencies (only Copilot integration, no snippet engines)
  dependencies = {
    -- Copilot integration
    {
      'giuxtaposition/blink-cmp-copilot',
    },
  },
}
