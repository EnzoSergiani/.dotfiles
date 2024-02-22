local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { 
    filetypes = { 
      "html", 
      "markdown", 
      "css",
      "json", 
      "javascript", 
      "typescript" 
  } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- python
  b.formatting.black,

  -- LaTex
  b.formatting.latexindent,

  -- Assembler
  b.formatting.asmfmt.with { filetypes= {"asm"} },
}

null_ls.setup {
  debug = true,
  sources = sources,
  -- formatting on save
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
