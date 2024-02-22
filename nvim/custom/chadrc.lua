---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",

  hl_override = {
    highlights.override,
    NvDashAscii = {
    fg = "#E2EAED",
    bg = "#295844",
    },
    NvDashButtons = {
    fg = "#295844",
    },
  },

  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
