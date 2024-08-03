require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Line
map("n", "<C-l>", function() vim.cmd("normal! V") end, { desc = "Select entire line" })
map("v", "<C-c>", function() vim.cmd('normal! "+y') end, { desc = "Line copied" })
map("i", "<C-v>", function() vim.cmd('normal! <C-r>+') end, { desc = "Line pasted" })
map("v", "<C-x>", function() vim.cmd('normal! "+x') end, { desc = "Line cut" })
map("i", "<C-d>", function() vim.cmd('normal! <Esc>"+yyp') end, { desc = "Line duplicated" })

-- Action
map("n", "<C-z>", function() vim.cmd("undo") end, { desc = "Action undo" })
map("n", "<C-e>", function() vim.cmd("redo") end, { desc = "Action redo" })
map("i", "<C-z>", function() vim.cmd("undo") end, { desc = "Action undo" })
map("i", "<C-e>", function() vim.cmd("redo") end, { desc = "Action redo" })
map("n", "<C-a>", function() vim.cmd("normal! ggVG") end, { desc = "Action select all" })
map("n", "<C-w>", function() vim.cmd("bd") end, { desc = "Action close buffer" })
map("n", "<C-s>", function() vim.cmd("w") end, { desc = "Action save" })
map("i", "<C-s>", function() vim.cmd("write") end, { desc = "Sauvegarder fichier" })

-- Move
map("n", "<C-S-Left>", function() vim.cmd("wincmd h") end, { desc = "Move to window left" })
map("n", "<C-S-Right>", function() vim.cmd("wincmd l") end, { desc = "Move to window right" })
map("n", "<C-left>", function() vim.cmd("normal! b") end, { desc = "Move cursor to the left of the word" })
map("n", "<C-right>", function() vim.cmd("normal! e") end, { desc = "Move cursor to the right of the word" })
map("n", "<C-S-Up>", function() vim.cmd("normal! gg") end, { desc = "Move cursor to the top of the page" })
map("n", "<C-S-Down>", function() vim.cmd("normal! G") end, { desc = "Move cursor to the bottom of the page" })
map("n", "<C-Up>", function() vim.cmd("normal! 10k") end, { desc = "Move cursor 10 lines up" })
map("n", "<C-Down>", function() vim.cmd("normal! 10j") end, { desc = "Move cursor 10 lines down" })

-- Telescope

map("n", "<C-Up>", function() vim.cmd("normal! 10k") end, { desc = "Move cursor 10 lines up" })
map("n", "<C-Down>", function() vim.cmd("normal! 10j") end, { desc = "Move cursor 10 lines down" })

-- Telescope
map("n", "<leader>ff", function() vim.cmd("Telescope find_files") end, { desc = "Find files" })
map("n", "<leader>td", function() vim.cmd("TodoTelescope") end, { desc = "Find TODO" })
map("n", "<leader>fb", function() vim.cmd("Telescope file_browser path=%:p:h select_buffer=true") end,
  { desc = "Folder" })

-- Markdown preview
-- map("n", "<leader>mp", function() vim.cmd("MarkdownPreview") end, { desc = "MarkdownPreview start" })
-- map("n", "<leader>mc", function() vim.cmd("MarkdownPreviewStop") end, { desc = "MarkdownPreview close" })

-- Other
-- map("n", "<leader>zm", function() vim.cmd("ZenMode") end, { desc = "Mode Zen" })
