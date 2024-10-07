return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  opts = {
    -- no_italic = true,
    -- no_bold = true,
    -- no_underline = true,
    -- transparent_background = transparent_background,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    background = {
      light = "latte",
      dark = "mocha",
    },
    integrations = {
      diffview = true,
      telescope = {
        enabled = true,
        style = "nvchad",
      },
      mini = {
        enabled = true,
        indentscope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      },
      noice = true,
    },
    custom_highlights = function(colors)
      return {
        -- WinSeparator = { fg = colors.lavender, bg = colors.base },
        -- DiffChange = { fg = colors.base, bg = colors.pink },
        ["@string.documentation"] = { link = "Comment" },
        -- ["@property"] = { fg = "#45707a" },
      }
    end,
    color_overrides = {
      mocha = {
        --   rosewater = "#efc9c2",
        --   flamingo = "#ebb2b2",
        --   pink = "#f2a7de",
        --   mauve = "#b889f4",
        --   red = "#ea7183",
        --   maroon = "#ea838c",
        --   peach = "#f39967",
        --   yellow = "#eaca89",
        green = "#96d382",
        -- green = "#89b482",
        --   teal = "#78cec1",
        --   sky = "#91d7e3",
        --   sapphire = "#68bae0",
        --   blue = "#739df2",
        --   -- lavender = "#a0a8f6",
        --   lavender = "#959de6",
        --   -- text = "#b5c1f1",
        --   text = "#d5daeb",
        --   subtext1 = "#a6b0d8",
        --   subtext0 = "#959ec2",
        --   overlay2 = "#848cad",
        --   overlay1 = "#717997",
        --   overlay0 = "#63677f",
        --   surface2 = "#505469",
        --   surface1 = "#3e4255",
        --   surface0 = "#2c2f40",
        -- base = "#0e0e13",
        base = "#000000",
        --   mantle = "#141620",
        --   crust = "#0e0f16",
      },
      -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-5287724
      frappe = {
        rosewater = "#ea6962",
        flamingo = "#ea6962",
        red = "#ea6962",
        maroon = "#ea6962",
        pink = "#d3869b",
        mauve = "#d3869b",
        peach = "#e78a4e",
        yellow = "#d8a657",
        green = "#a9b665",
        teal = "#89b482",
        sky = "#89b482",
        sapphire = "#89b482",
        blue = "#7daea3",
        lavender = "#7daea3",
        text = "#ebdbb2",
        subtext1 = "#d5c4a1",
        subtext0 = "#bdae93",
        overlay2 = "#a89984",
        overlay1 = "#928374",
        overlay0 = "#595959",
        surface2 = "#4d4d4d",
        surface1 = "#404040",
        surface0 = "#292929",
        base = "#1d2021",
        mantle = "#191b1c",
        crust = "#141617",
      },
      latte = {
        rosewater = "#c14a4a",
        flamingo = "#c14a4a",
        red = "#c14a4a",
        maroon = "#c14a4a",
        pink = "#945e80",
        mauve = "#945e80",
        peach = "#c35e0a",
        yellow = "#b47109",
        green = "#6c782e",
        teal = "#4c7a5d",
        sky = "#4c7a5d",
        sapphire = "#4c7a5d",
        blue = "#45707a",
        lavender = "#45707a",
        text = "#654735",
        subtext1 = "#73503c",
        subtext0 = "#805942",
        overlay2 = "#8c6249",
        overlay1 = "#8c856d",
        overlay0 = "#a69d81",
        surface2 = "#bfb695",
        surface1 = "#d1c7a3",
        surface0 = "#e3dec3",
        base = "#f9f5d7",
        mantle = "#f0ebce",
        crust = "#e8e3c8",
      },
      macchiato = {
        rosewater = "#ffc9c9",
        flamingo = "#ff9f9a",
        pink = "#ffa9c9",
        mauve = "#df95cf",
        lavender = "#a990c9",
        red = "#ff6960",
        maroon = "#f98080",
        peach = "#f9905f",
        yellow = "#f9bd69",
        green = "#b0d080",
        teal = "#a0dfa0",
        sky = "#a0d0c0",
        sapphire = "#95b9d0",
        blue = "#89a0e0",
        text = "#e0d0b0",
        subtext1 = "#d5c4a1",
        subtext0 = "#bdae93",
        overlay2 = "#928374",
        overlay1 = "#7c6f64",
        overlay0 = "#665c54",
        surface2 = "#504844",
        surface1 = "#3a3634",
        surface0 = "#252525",
        base = "#151515",
        mantle = "#0e0e0e",
        crust = "#080808",
      },
    },
  },
}
