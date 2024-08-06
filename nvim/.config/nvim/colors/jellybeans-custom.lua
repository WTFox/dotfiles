vim.opt.background = "dark"
vim.g.colors_name = "jellybeans-custom"

local lush = require("lush")
local jellybeans = require("lush_theme.jellybeans-nvim")
local hsl = lush.hsl

local foreground = hsl("#e8e8d3")
local background = hsl("#151515")
local grey = hsl("#888888")
local grey_one = hsl("#1c1c1c")
local grey_two = hsl("#f0f0f0")
local grey_three = hsl("#333333")
local regent_grey = hsl("#9098A0")
local scorpion = hsl("#606060")
local cod_grey = hsl("#101010")
local tundora = hsl("#404040")
local zambezi = hsl("#605958")
local silver_rust = hsl("#ccc5c4")
local silver = hsl("#c7c7c7")
local alto = hsl("#dddddd")
local gravel = hsl("#403c41")
local boulder = hsl("#777777")
local cocoa_brown = hsl("#302028")
local grey_chateau = hsl("#a0a8b0")
local bright_grey = hsl("#384048")
local shuttle_grey = hsl("#535d66")
local mine_shaft = hsl("#1f1f1f")
local temptress = hsl("#40000a")

local bayoux_blue = hsl("#556779")
local total_white = hsl("#ffffff")
local total_black = hsl("#000000")
local cadet_blue = hsl("#b0b8c0")
local perano = hsl("#b0d0f0")
local wewak = hsl("#f0a0c0")
local mantis = hsl("#70b950")
local raw_sienna = hsl("#cf6a4c")
local highland = hsl("#799d6a")
local hoki = hsl("#668799")
local green_smoke = hsl("#99ad6a")
local costa_del_sol = hsl("#556633")
local biloba_flower = hsl("#c6b6ee")
local morning_glory = hsl("#8fbfdc")
local goldenrod = hsl("#fad07a")
local ship_cove = hsl("#8197bf")
local koromiko = hsl("#ffb964")
local brandy = hsl("#dad085")
local old_brick = hsl("#902020")
local dark_blue = hsl("#0000df")
local ripe_plum = hsl("#540063")
local casal = hsl("#2D7067")
local purple = hsl("#700089")
local tea_green = hsl("#d2ebbe")
local dell = hsl("#437019")
local calypso = hsl("#2B5B77")

local spec = lush.extends({ jellybeans }).with(function(injected_functions)
  local sym = injected_functions.sym

  return {
    sym("@variable.parameter")({ fg = biloba_flower }),
  }
end)

lush(spec)
