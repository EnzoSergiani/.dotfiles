---@type MappingsTable
local M = {}

-- keybinds disabled
M.disabled = {
  n = {
    ["V"] = "",
  },
}

M.general = {
  n = {
    [";"] = {
      ":",
      "enter command mode",
      opts = {
        nowait = true,
      },
    },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
    ["<C-l>"] = { "V", "Start line-wise visual mode" },
    ["<C-q>"] = { ":q<CR>", "Close file" },
    ["<C-w>"] = { ":bd<CR>", "Close buffer, quit if last" },
    ["<C-v>"] = { '"+p', "Paste from system clipboard" },
    ["<C-b>"] = { ":$<CR>", "Move cursor to the bottom of the document" },
    ["<C-t>"] = { "gg", "Move cursor to the top of the document" },
    ["<C-a>"] = { "ggVG", "Select entire file" },
    ["<C-d>"] = { "yyp", "Duplicate the current line" },
    ["<C-Up>"] = { ":1<CR>", "Move cursor to the top of the page" },
    ["<C-Down>"] = { ":$<CR>", "Move cursor to the bottom of the page" },
    ["<C-z>"] = { ":undo<CR>", "Undo" },
    ["<C-e>"] = { ":redo<CR>", "Redo" },
    ["<leader>zm"] = { "<cmd>ZenMode<CR>", "Mode Zen" },
    ["<C-k>"] = { [[<cmd>Silicon ~/Images/Screenshot_Neovim/<CR>]], "Screenshot" },
    -- ["<A-g>"] = { "db", "Delete word" },
    -- ["<A-g>"] = { "test", "Add commentary" },
  },
  v = {
    ["<C-c>"] = { '"+y', "Copy selected text to system clipboard" },
    ["<C-x>"] = { '"+x', "Cut selected text to system clipboard" },
    ["<Up>"] = { ":move '<-2<CR>gv=gv", "Move selected lines up" },
    ["<Down>"] = { ":move '>+1<CR>gv=gv", "Move selected lines down" },
    ["<C-d>"] = { "yyp", "Duplicate the current line" },
  },
  i = {
    ["<C-v>"] = { '"+p', "Paste from system clipboard" },
    ["<C-z>"] = { "<Esc>:undo<CR>i", "Undo" },
    ["<C-e>"] = { "<Esc>:redo<CR>i", "Redo" },
    -- ["<A-g>"] = { "<C-o>diw", "Delete word" },
  },
}

M.telescope = {
  n = {
    ["<leader>fb"] = { ":Telescope file_browser path=%:p:h select_buffer=true<CR>", "Telescope file browser" },
  },
}

M.Move = {
  n = {
    -- switch between windows
    ["<C-S-Left>"] = { "<C-w>h", "Window left" },
    ["<C-S-Right>"] = { "<C-w>l", "Window right" },
    -- move between words
    ["<C-Left>"] = { "b", "Move cursor to the left of the word" },
    ["<C-Right>"] = { "e", "Move cursor to the right of the word" },
  },
}

-- Debugger
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
    ["<leader>dr"] = { "<cmd> DapContinue <CR>", "Start or continue the debugger" },
  },
}

-- M.dap_python = {
--   plugin = true,
--   n = {
--     ["<leader>dpr"] = {
--       function()
--         require('dap-python').test_method()
--       end
--     }
--   }
-- }

-- Markdown
M.markdown_preview = {
  n = {
    ["<leader>mp"] = { "<cmd> MarkdownPreview<CR>", "Open Preview" },
    ["<leader>mc"] = { "<cmd> MarkdownPreviewStop<CR>", "Close Preview" },
  },
}

return M
