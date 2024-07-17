require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Line
map("n", "<C-l>", "V", { desc = " Line selected" })
map("v", "<C-c>", "+y", { desc = "Line copied" })
map("i", "<C-v>", "+p", { desc = "Line pasted" })
map("v", "<C-x>", "+x", { desc = "Line cuted" })
map("i", "<C-d>", "+yyp", { desc = "Line duplicated" })
map("v", "<Up>", ":move '>-2<CR>gv=gv", { desc = "Line move up" })
map("v", "<Down>", ":move '>+1<CR>gv=gv", { desc = "Line move down" })

-- Action
map("n", "<C-a>", "ggVG", { desc = "Action select all" })
map("n", "<C-z>", ":undo<CR>", { desc = "Action undo" })
map("n", "<C-e>", ":redo<CR>", { desc = "Action redo" })
map("i", "<C-z>", "<Esc>:undo<CR>i", { desc = "Action undo" })
map("i", "<C-e>", "<Esc>:redo<CR>i", { desc = "Action redo" })
map("n", "<C-w>", ":bd<CR>", { desc = "Action close buffer" })

-- Move
map("n", "<C-S-Left>", "<C-w>h", { desc = "Move to window left" })
map("n", "<C-S-Right>", "<C-w>l", { desc = "Move ro window right" })
map("n", "<C-left>", "b", { desc = "Move cursor to the left of the word" })
map("n", "<C-right>", "e", { desc = "Move cursor to the right of the word" })
map("n", "<C-S-Up>", ":1<CR>", { desc = "Move cursor to the top of the page" })
map("n", "<C-S-Down>", ":$<CR>", { desc = "Move cursor to the bottom of the page" })
map("n", "<C-Up>", ":<C-U>execute 'normal! ' . (v:count1 * 10) . 'k'<CR>", { desc = "Move cursor 10 lines up" })
map("n", "<C-Down>", ":<C-U>execute 'normal! ' . (v:count1 * 10) . 'j'<CR>", { desc = "Move cursor 10 lines down" })

-- Mapping
-- map("n", "<C-:>", "gcc", { desc="Comment the current line"} )

-- Telescope
map("n", "<leader>ff", ":Telescope <cr>", { desc = " Find files" })
map("n", "<leader>td", ":TodoTelescope<CR>", { desc = "Find TODO " })
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = " Folder " })

-- Markdown preview
map("n", "<leader>mp", "<cmd> MarkdownPreview<CR>", { desc = "MarkdownPreview start" })
map("n", "<leader>mc", "<cmd> MarkdownPreviewStop<CR>", { desc = "MarkdownPreview close" })

-- Other
map("n", "<leader>zm", "<cmd>ZenMode<CR>", { desc = "Mode Zen" })
