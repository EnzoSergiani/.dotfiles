require "nvchad.mappings"

local map = vim.keymap.set
local cmp = require "cmp"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- nvim-cmp
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
  },
}

-- Line
map("n", "<C-l>", function()
  vim.cmd "normal! V"
end, { desc = "Select entire line" })
map("v", "<C-c>", function()
  vim.cmd 'normal! "+y'
end, { desc = "Line copied" })
map("n", "<C-v>", function()
  vim.cmd "normal! +p"
end, { desc = "Line pasted" })
map("v", "<C-x>", function()
  vim.cmd 'normal! "+x'
end, { desc = "Line cut" })
map("n", "<C-d>", function()
  vim.cmd 'normal! "+yyp'
end, { desc = "Line duplicated" })

-- Action
map("n", "<C-z>", function()
  vim.cmd "undo"
end, { desc = "Action undo" })
map("n", "<C-e>", function()
  vim.cmd "redo"
end, { desc = "Action redo" })
map("n", "<C-a>", function()
  vim.cmd "normal! ggVG"
end, { desc = "Action select all" })
map("n", "<C-w>", function()
  vim.cmd "bd"
end, { desc = "Action close buffer" })
map("n", "<C-s>", function()
  vim.cmd "w"
end, { desc = "Action save" })

-- Move
map("n", "<C-S-Left>", function()
  vim.cmd "wincmd h"
end, { desc = "Move to window left" })
map("n", "<C-S-Right>", function()
  vim.cmd "wincmd l"
end, { desc = "Move to window right" })
map("n", "<C-left>", function()
  vim.cmd "normal! b"
end, { desc = "Move cursor to the left of the word" })
map("n", "<C-right>", function()
  vim.cmd "normal! e"
end, { desc = "Move cursor to the right of the word" })
map("n", "<C-S-Up>", function()
  vim.cmd "normal! gg"
end, { desc = "Move cursor to the top of the page" })
map("n", "<C-S-Down>", function()
  vim.cmd "normal! G"
end, { desc = "Move cursor to the bottom of the page" })
map("n", "<C-Up>", function()
  vim.cmd "normal! 10k"
end, { desc = "Move cursor 10 lines up" })
map("n", "<C-Down>", function()
  vim.cmd "normal! 10j"
end, { desc = "Move cursor 10 lines down" })

-- Telescope
map("n", "<leader>ff", function()
  vim.cmd "Telescope find_files"
end, { desc = "Find files" })
map("n", "<leader>td", function()
  vim.cmd "TodoTelescope"
end, { desc = "Find TODO" })
map("n", "<leader>fb", function()
  vim.cmd "Telescope file_browser path=%:p:h select_buffer=true"
end, { desc = "Folder" })

-- Copilot
vim.keymap.set("i", "<M-m>", "copilot#AcceptWord()", {
  desc = "Copilot Accept word",
  expr = true,
  silent = true,
  replace_keycodes = false,
})
vim.keymap.set("i", "<M-l>", "copilot#AcceptLine()", {
  desc = "Copilot Accept line",
  expr = true,
  silent = true,
  replace_keycodes = false,
})

-- LaTeX / VimTex
map("n", "<leader>ll", "<cmd>VimtexCompile<cr>", { desc = "LaTeX Compile (continuous)" })
map("n", "<leader>lk", "<cmd>VimtexStop<cr>", { desc = "LaTeX Stop" })
map("n", "<leader>lv", "<cmd>VimtexView<cr>", { desc = "LaTeX View build/main.pdf (SyncTeX)" })
map("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", { desc = "LaTeX TOC" })
map("n", "<leader>le", "<cmd>VimtexErrors<cr>", { desc = "LaTeX Errors" })
map("n", "<leader>li", "<cmd>VimtexInfo<cr>", { desc = "LaTeX Info" })
map("n", "<leader>lb", function()
  vim.cmd "write"
  vim.cmd "!latexmk"
end, { desc = "LaTeX Build (biber + glossaries)" })
map("n", "<leader>lx", function()
  vim.cmd "write"
  local output_name =
    vim.fn.system('grep "my \\$output_name" .latexmkrc | sed "s/.*= \'\\(.*\\)\';.*/\\1/"'):gsub("%s+", "")
  if output_name == "" then
    output_name = "report"
  end
  vim.notify("Compression vers " .. output_name .. ".pdf...", vim.log.levels.INFO)
  vim.cmd(
    "!gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile="
      .. vim.fn.shellescape(output_name)
      .. ".pdf build/main.pdf"
  )
  local size_before = vim.fn.system("du -h build/main.pdf | cut -f1"):gsub("%s+", "")
  local size_after = vim.fn.system("du -h " .. output_name .. ".pdf 2>/dev/null | cut -f1"):gsub("%s+", "")
  if size_after ~= "" then
    vim.notify(output_name .. ".pdf créé (" .. size_before .. " → " .. size_after .. ")", vim.log.levels.INFO)
    vim.cmd("!zathura " .. vim.fn.shellescape(output_name) .. ".pdf &")
  else
    vim.notify("Erreur lors de la compression", vim.log.levels.ERROR)
  end
end, { desc = "LaTeX Compress (from .latexmkrc)" })
map("n", "<leader>lc", function()
  vim.cmd "!latexmk -c"
end, { desc = "LaTeX Clean aux files" })
map("n", "<leader>lC", function()
  vim.cmd "!latexmk -C"
  vim.notify("Nettoyage complet", vim.log.levels.INFO)
end, { desc = "LaTeX Clean all" })
