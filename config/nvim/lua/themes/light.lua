local M = {}

M.base_30 = {
  white = "#3a3226",
  darker_black = "#f5e6d3",
  black = "#faf6f0",
  black2 = "#f0e6d8",
  one_bg = "#f0e6d8",
  one_bg2 = "#e8dcc8",
  one_bg3 = "#e0d0b8",
  grey = "#c4b5a0",
  grey_fg = "#b5a590",
  grey_fg2 = "#a59580",
  light_grey = "#958575",
  red = "#c14a4a",
  baby_pink = "#d97777",
  pink = "#d66b6b",
  line = "#e8dcc8",
  green = "#6b8e3c",
  vibrant_green = "#7da047",
  nord_blue = "#5b8db8",
  blue = "#5a8ec9",
  yellow = "#d4a543",
  sun = "#e6b955",
  purple = "#9b6b9e",
  dark_purple = "#8a5a8d",
  teal = "#5c9082",
  orange = "#d17a4a",
  cyan = "#5a9faa",
  statusline_bg = "#f0e6d8",
  lightbg = "#e8dcc8",
  pmenu_bg = "#5a8ec9",
  folder_bg = "#5a8ec9",
}

M.base_16 = {
  base00 = "#faf6f0",
  base01 = "#f0e6d8",
  base02 = "#e8dcc8",
  base03 = "#e0d0b8",
  base04 = "#b5a590",
  base05 = "#3a3226",
  base06 = "#2a2216",
  base07 = "#1a1206",
  base08 = "#c14a4a",
  base09 = "#d17a4a",
  base0A = "#d4a543",
  base0B = "#6b8e3c",
  base0C = "#5a9faa",
  base0D = "#5a8ec9",
  base0E = "#9b6b9e",
  base0F = "#b85a6b",
}

M.type = "light"

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.white },
    ["@keyword"] = { fg = M.base_16.base0E, bold = true },
  },
}

return M
