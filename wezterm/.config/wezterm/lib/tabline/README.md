# tabline.wez

A versatile and easy to use tab-bar written in Lua.

`tabline.wez` requires the [WezTerm](https://wezfurlong.org/wezterm/index.html) terminal emulator.

Tabline was greatly inspired by [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim/tree/master), a statusline plugin for [Neovim](https://neovim.io), and tries to use the same configuration format.

## Contributing

Feel free to create an issue/PR if you want to see anything else implemented, or if you have some question or need help with configuration.

## Screenshots

Here is a preview of what the tab-bar can look like.

<p>
  <img width="1656" alt="tabline 1" src="https://github.com/user-attachments/assets/bc3a2dc3-fa95-4386-a2b2-6b593dc4cef8">
  <img width="1656" alt="tabline 2" src="https://github.com/user-attachments/assets/6c72b8b0-7751-4972-950e-ee1e3de1a39b">
  <img width="1656" alt="tabline 3" src="https://github.com/user-attachments/assets/cd61edca-8c50-477b-a14a-84a89d369600">
  <img width="1656" alt="tabline 4" src="https://github.com/user-attachments/assets/38b194ec-33d9-4955-af08-c70c25b3bcf0">
  <img width="1656" alt="tabline 5" src="https://github.com/user-attachments/assets/ff216ab2-8a60-494d-9b11-9295212143df">
</p>

Some more examples, but very zoomed in.

<p>
  <img width="1680" alt="tabline 1 big" src="https://github.com/user-attachments/assets/2b48be12-7875-4282-aeb4-c24b0ed2fc1c">
  <img width="1680" alt="tabline 2 big" src="https://github.com/user-attachments/assets/b3ec5b88-d940-4ff0-9612-0f74d8b003a3">
  <img width="1680" alt="tabline 3 big" src="https://github.com/user-attachments/assets/00e39a55-5628-4926-9d42-9eff1e00e75c">
  <img width="1680" alt="tabline 4 big" src="https://github.com/user-attachments/assets/a2d84536-345c-4fce-9b50-d55b2768ae90">
</p>

`tabline.wez` supports all the same themes as WezTerm. You can find the list of themes [here](https://wezfurlong.org/wezterm/colorschemes/index.html).

## Installation

### WezTerm Plugin API

```lua
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
```

You'll also need to have a patched font if you want icons.

## Usage and customization

Tabline has sections as shown below just like lualine with the addition of `tabs` in the middle.

```text
+-------------------------------------------------+
| A | B | C |  TABS                   | X | Y | Z |
+-------------------------------------------------+
```

Each sections holds its components e.g. Current active keytable (mode).

### Configuring tabline in wezterm.lua

#### Default configuration

```lua
tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    color_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'tab_index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'tab_index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'hostname' },
  },
  extensions = {},
})
```

If you want to get your current tabline config, you can
do so with:

```lua
tabline.get_config()

```

#### WezTerm configuration

Tabline requires that some options are applied to the WezTerm [Config](https://wezfurlong.org/wezterm/config/lua/config/index.html) struct. For example the retro tab-bar must be enabled. Tabline provides a function to apply some recommended options to the config. If you already set these options in your `wezterm.lua` you do not need this function.

```lua
tabline.apply_to_config(config)
```

> [!CAUTION]
> This function has nothing to do with the tabline config passed into setup and retrieved with `tabline.get_config()`. It only applies some recommended options to the WezTerm config. More info [here](https://github.com/michaelbrusegard/tabline.wez/discussions/3)

---

### Starting tabline

```lua
tabline.setup()
```

---

### Setting a theme

```lua
options = { theme = 'GruvboxDark' }
```

All available themes are found [here](https://wezfurlong.org/wezterm/colorschemes/index.html).

#### Customizing themes

To modify a theme, you can use the `color_overrides` option.

```lua
-- Change the background of tabline_c section for normal mode
tabline.setup({
  options = {
    color_overrides = {
      normal_mode = {
        c = { bg = '#112233' },
      },
    }
  }
})
```

This is also where you would specify the colors for a new [Key Table](https://wezfurlong.org/wezterm/config/key-tables.html) (mode). Tabline expects each key table to end with `_mode`.

```lua
tabline.setup({
  options = {
    color_overrides = {
    -- Default colors from Catppuccin Mocha
      normal_mode = {
        a = { fg = '#181825', bg = '#89b4fa' },
        b = { fg = '#89b4fa', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      copy_mode = {
        a = { fg = '#181825', bg = '#f9e2af' },
        b = { fg = '#f9e2af', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      search_mode = {
        a = { fg = '#181825', bg = '#a6e3a1' },
        b = { fg = '#a6e3a1', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      -- Defining colors for a new key table
      window_mode = {
        a = { fg = '#181825', bg = '#cba6f7' },
        b = { fg = '#cba6f7', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      -- Default tab colors
      tab = {
        active = { fg = '#89b4fa', bg = '#313244' },
        inactive = { fg = '#cdd6f4', bg = '#181825' },
        inactive_hover = { fg = '#f5c2e7', bg = '#313244' } },
      }
    }
  }
})
```

#### Getting colors

If you want to get the colors used in the current theme, you can do so with:

```lua
tabline.get_colors()
```

You will get an object like the `color_overrides` object above, but with the addition of a scheme property (the scheme property is the scheme object from WezTerm with every color found there).

> [!TIP]
> This can be useful when creating your own components or extensions and you want to use the same colors as the current theme

---

### Separators

tabline defines three kinds of separators:

- `section_separators` - separators between sections
- `component_separators` - separators between the different components in sections
- `tab_separators` - separators around tabs

```lua
options = {
  section_separators = {
    left = wezterm.nerdfonts.pl_left_hard_divider,
    right = wezterm.nerdfonts.pl_right_hard_divider,
  },
  component_separators = {
    left = wezterm.nerdfonts.pl_left_soft_divider,
    right = wezterm.nerdfonts.pl_right_soft_divider,
  },
  tab_separators = {
    left = wezterm.nerdfonts.pl_left_hard_divider,
    right = wezterm.nerdfonts.pl_right_hard_divider,
  },
}
```

Here, left refers to the left-most sections (a, b, c), and right refers
to the right-most sections (x, y, z). For the tabs it refers to each side of the tab.

#### Disabling separators

```lua
options = {
  section_separators = '',
  component_separators = '',
  tab_separators = '',
}
```

---

### Changing components in tabline sections

```lua
sections = { tabline_a = { 'mode' } }
```

#### Available components

Tabline separates components into ones available for the tabline components (`tabline_a`, `tabline_b`, etc...), which are grouped under Window since they have access to the [Window](https://wezfurlong.org/wezterm/config/lua/window/index.html) object.

And the `tab_active` and `tab_inactive` components which are grouped under Tab and have access to [TabInformation](https://wezfurlong.org/wezterm/config/lua/TabInformation.html).

- Window
  - `mode` (current keytable)
  - `battery` (battery percentage)
  - `cpu` (cpu percentage)
  - `datetime` (current date and time)
  - `hostname` (hostname of the machine)
  - `ram` (ram used in GB)
  - `window` (window title)
  - `workspace` (active wezterm workspace)
- Tab
  - `cwd` (current working directory)
  - `parent` (parent directory)
  - `process` (process name)
  - `tab_index` (tab index)
  - `zoomed` (indicator if tab has zoomed pane)

#### Custom components

##### Lua functions as tabline component

```lua
local function hello()
  return 'Hello World'
end
sections = { tabline_a = { hello } }
```

> [!NOTE]
> Functions receive the `Window` object or `TabInformation` object as the first argument depending on the component group

##### Text string as tabline component

```lua
sections = { tabline_a = { 'Hello World' } }
```

##### WezTerm Formatitem as tabline component

You can find all the available format items [here](https://wezfurlong.org/wezterm/config/lua/wezterm/format.html). The `ResetAttributes` format item has been overwritten to reset all attributes back to the default for that component instead of the WezTerm default.

```lua
sections = {
  tabline_c = {
    { Attribute = { Underline = 'Single' } },
    { Foreground = { AnsiColor = 'Fuchsia' } },
    { Background = { Color = 'blue' } },
    'Hello World', -- { Text = 'Hello World' }
  }
}

```

> [!TIP]
> Strings are automatically wrapped in a Text FormatItem when used as a component.

##### Lua expressions as tabline component

You can use any valid lua expression as a component including:

- oneliners
- global variables (as strings)
- require statements

```lua
sections = { tabline_c = { os.date('%a'), data, require('util').status() } }
```

`data` is a global variable in this example.

---

### Component options

Component options can change the way a component behave.
There are two kinds of options:

- global options affecting all components
- local options affecting specific

Global options can be used as local options (can be applied to specific components)
but you cannot use local options as global.
Global options used locally overwrites the global, for example:

```lua
tabline.setup {
  options = { fmt = string.lower },
  sections = {
    tabline_a = {
      { 'mode', fmt = function(str) return str:sub(1,1) end }
    },
    tabline_b = { 'window' }
  }
}
```

`mode` will be formatted with the passed function so only first char will be
shown. On the other hand `window` will be formatted with the global formatter
`string.lower` so it will be showed in lower case.

#### Available options

#### Global options

These are `options` that are used in the options table.
They set behavior of tabline.

Values set here are treated as default for other options
that work in the component level.

For example even though `icons_enabled` is a general component option.
You can set `icons_enabled` to `false` and icons will be disabled on all
component. You can still overwrite defaults set in the options table by specifying
the option value in the component.

```lua
options = {
  theme = 'nord', -- tabline theme
  section_separators = {
    left = wezterm.nerdfonts.ple_right_half_circle_thick,
    right = wezterm.nerdfonts.ple_left_half_circle_thick,
  },
  component_separators = {
    left = wezterm.nerdfonts.ple_right_half_circle_thin,
    right = wezterm.nerdfonts.ple_left_half_circle_thin,
  },
  tab_separators = {
    left = wezterm.nerdfonts.ple_right_half_circle_thick,
    right = wezterm.nerdfonts.ple_left_half_circle_thick,
  },
}
```

#### General component options

These are options that control behavior at the component level
and are available for all components.

```lua
sections = {
  tabline_a = {
    {
      'mode',
      icons_enabled = true, -- Enables the display of icons alongside the component.
      -- Defines the icon to be displayed in front of the component.
      -- Can be string|table
      -- As table it must contain the icon as first entry and can use
      -- color option to custom color the icon. Example:
      -- { 'workspace', icon = wezterm.nerdfonts.cod_terminal_tmux } / { 'workspace', icon = { wezterm.nerdfonts.cod_terminal_tmux, color = { fg= '#00ff00' } } }

      icons_only = false, -- Only show icon (if the component has one)

      -- icon position can also be set to the right side from table. Example:
      -- {'branch', icon = { wezterm.nerdfonts.cod_terminal_tmux, align = 'right', color = { fg = '#00ff00' } } }
      icon = nil,

      cond = nil, -- Condition function, the component is loaded when the function returns `true`.

      padding = 1, -- Adds padding to the left and right of components.
                   -- Padding can be specified to left or right independently, e.g.:
                   --   padding = { left = left_padding, right = right_padding }

      fmt = nil, -- Format function, formats the component's output.
      -- This function receives two arguments:
      -- - string that is going to be displayed and
      --   that can be changed, enhanced and etc.
      -- - Window/TabInformation object with information you might
      --   need. E.g. active_pane if used with Window.
    },
  },
}
```

#### Component specific options

These are options that are available on specific components.
For example, you have option on `tab_index` component to
specify if it should be zero indexed.

#### datetime component options

```lua
sections = {
  tabline_a = {
    {
      'datetime',
      -- options: your own format string ('%Y/%m/%d %H:%M:%S', etc.)
      style = '%H:%M',
      hour_to_icon = {
        ['00'] = wezterm.nerdfonts.md_clock_time_twelve_outline,
        ['01'] = wezterm.nerdfonts.md_clock_time_one_outline,
        ['02'] = wezterm.nerdfonts.md_clock_time_two_outline,
        -- for every hour...
        ['23'] = wezterm.nerdfonts.md_clock_time_eleven,
      },
    -- hour_to_icon is a table that maps hours to icons it overwrites the default icon property.
    -- To use the default icon property set hour_to_icon to nil.
    -- The color and align properties can still be used on the icon property.
    },
  },
}
```

#### cwd and parent component options

```lua
sections = {
  tab_active = {
    {
      'cwd',
      max_length = 10, -- Max length before it is truncated
    },
  },
}
```

#### tab_index component options

```lua
sections = {
  tab_active = {
    {
      'tab_index',
      zero_indexed = false, -- Does the tab index start at 0 or 1
    },
  },
}
```

#### process component options

```lua
sections = {
  tab_active = {
    {
      'process',
      process_to_icon = {
        ['apt'] = wezterm.nerdfonts.dev_debian,
        ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
        ['bat'] = wezterm.nerdfonts.md_bat,
        ['cmd.exe'] = wezterm.nerdfonts.md_console_line,
        ['curl'] = wezterm.nerdfonts.md_flattr,
        ['debug'] = wezterm.nerdfonts.cod_debug,
        ['default'] = wezterm.nerdfonts.md_application,
        ['docker'] = wezterm.nerdfonts.linux_docker,
        ['docker-compose'] = wezterm.nerdfonts.linux_docker,
        ['git'] = wezterm.nerdfonts.dev_git,
        ['go'] = wezterm.nerdfonts.md_language_go,
        ['lazydocker'] = wezterm.nerdfonts.linux_docker,
        ['lazygit'] = wezterm.nerdfonts.cod_github,
        ['lua'] = wezterm.nerdfonts.seti_lua,
        ['make'] = wezterm.nerdfonts.seti_makefile,
        ['nix'] = wezterm.nerdfonts.linux_nixos,
        ['node'] = wezterm.nerdfonts.md_nodejs,
        ['npm'] = wezterm.nerdfonts.md_npm,
        ['nvim'] = wezterm.nerdfonts.custom_neovim,
        ['psql'] = wezterm.nerdfonts.dev_postgresql,
        ['zsh'] = wezterm.nerdfonts.dev_terminal,
        -- and more...
      },
    -- process_to_icon is a table that maps process to icons
    },
  },
}
```

#### cpu and ram component options

```lua
sections = {
  tab_active = {
    {
      'cpu',
      throttle = 3, -- How often in seconds the component updates, set to 0 to disable throttling
    },
  },
}
```

#### battery component options

```lua
sections = {
  battery_to_icon = {
    empty = { wezterm.nerdfonts.fa_battery_empty, color = { fg = scheme.ansi[2] } },
    quarter = wezterm.nerdfonts.fa_battery_quarter,
    half = wezterm.nerdfonts.fa_battery_half,
    three_quarters = wezterm.nerdfonts.fa_battery_three_quarters,
    full = wezterm.nerdfonts.fa_battery_full,
  }
-- battery_to_icon is a table that maps battery percentage to icons
-- It overwrites the default icon property. To use the default icon property set battery_to_icon to nil
-- The color and align properties can still be used on the icon property
}
```

---

### Extensions

tabline extensions change statusline appearance for other plugins.

By default no extensions are loaded to improve performance.
You can load extensions with:

```lua
extensions = { 'resurrect' }
```

#### Available extensions

- resurrect
- smart_workspace_switcher
- quick_domains
- presentation

#### Custom extensions

You can define your own extensions. If you believe an extension may be useful to others, then please submit a PR.

Custom extensions requires a `show` event to be defined. When the `show` event is triggered the defined `sections` will be shown. If a section in `sections` is not defined it will use the default from the config.
The `hide` event is optional. When the `hide` event is triggered the extension will hide the defined `sections`.
If the `hide` event is not defined the extension will hide the `sections` after the `delay` which is set to 5 seconds by default.
You can also have a `delay` with the `hide` event, which will delay the hide for the specified time in seconds after the `hide` event is triggered.
You can also have a optional `callback` function that will be called when the `show` event is triggered with the properties from the event.
The `colors` overwrite the default colors for the extension to use with its `sections`.

```lua
local my_extension = {
  events = {
    show = 'my_plugin.show',
    hide = 'my_plugin.hide',
    delay = 3
    callback = function(window)
      wezterm.log_info('Extension was shown')
    end
  },
  sections = {
    tabline_a = { 'mode' }
  },
  colors = {
    a = { fg = '#181825', bg = '#f38ba8' },
    b = { fg = '#f38ba8', bg = '#313244' },
    c = { fg = '#cdd6f4', bg = '#181825' },
  }
}

tabline.setup({ extensions = { my_extension } })
```

You can also pass multiple events to the `show` and `hide` properties.

```lua
events = {
  show = { 'my_plugin.show', 'my_plugin.show2' },
  hide = { 'my_plugin.hide', 'my_plugin.hide2' }
}
```

---

### Refreshing tabline

By default tabline refreshes itself based on the [`status_update_interval`](https://wezfurlong.org/wezterm/config/lua/config/status_update_interval.html). However you can also force
tabline to refresh at any time by calling `tabline.refresh` function.
The refresh function needs the Window object to refresh the tabline, and the TabInformation object to refresh the tabs. If passing one of them as nil it won't refresh the respective section.

```lua
tabline.refresh(window, tab)
```

Avoid calling `tabline.refresh` inside components. Since components are evaluated
during refresh, calling refresh while refreshing can have undesirable effects.

### Disabling tabline

You can also disable tabline completely. By setting the [enable_tab_bar](https://wezfurlong.org/wezterm/config/lua/config/enable_tab_bar.html) option to false in the WezTerm config.

### Inspiration

Thanks to [MLFlexer](https://github.com/MLFlexer) for some tips in developing a plugin for WezTerm.

Thanks to [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) for the inspiration and a nice statusline for my Neovim.
