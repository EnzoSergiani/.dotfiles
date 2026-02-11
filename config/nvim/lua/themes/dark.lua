local M = {}

M.base_30 = {
  white = "#ffffff",
  darker_black = "#181818",
  black = "#1e1e1e",
  black2 = "#282828",
  one_bg = "#282828",
  one_bg2 = "#313244",
  one_bg3 = "#3c3836",
  grey = "#504945",
  grey_fg = "#5c5c5c",
  grey_fg2 = "#6c6c6c",
  light_grey = "#7c7c7c",
  red = "#ff6b6b",
  baby_pink = "#ffb3ba",
  pink = "#ff9eb3",
  line = "#2a2a2a",
  green = "#51cf66",
  vibrant_green = "#69db7c",
  nord_blue = "#74c7ec",
  blue = "#4dabf7",
  yellow = "#ffd43b",
  sun = "#ffe066",
  purple = "#b197fc",
  dark_purple = "#9775fa",
  teal = "#15aabf",
  orange = "#ff922b",
  cyan = "#22b8cf",
  statusline_bg = "#282828",
  lightbg = "#313244",
  pmenu_bg = "#4dabf7",
  folder_bg = "#4dabf7",
}

M.base_16 = {
  base00 = "#1e1e1e",
  base01 = "#282828",
  base02 = "#313244",
  base03 = "#3c3836",
  base04 = "#5c5c5c",
  base05 = "#e0e0e0",
  base06 = "#eeeeee",
  base07 = "#ffffff",
  base08 = "#ff6b6b",
  base09 = "#ff922b",
  base0A = "#ffd43b",
  base0B = "#51cf66",
  base0C = "#22b8cf",
  base0D = "#4dabf7",
  base0E = "#b197fc",
  base0F = "#ff8787",
}

M.type = "dark"

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.white },
    ["@keyword"] = { fg = M.base_16.base0E, bold = true },
  },
}

return M
