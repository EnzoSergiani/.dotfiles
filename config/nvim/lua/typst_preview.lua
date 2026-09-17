local M = {}
local watch_jobs = {}

function M.start()
  local bufnr = vim.api.nvim_get_current_buf()
  if watch_jobs[bufnr] then
    vim.notify("Typst watch déjà actif", vim.log.levels.WARN)
    return
  end

  -- On force main.typ comme racine, peu importe le buffer actif
  local root = vim.fn.getcwd() .. "/main.typ"
  local pdf = vim.fn.fnamemodify(root, ":r") .. ".pdf"

  watch_jobs[bufnr] = vim.fn.jobstart({ "typst", "watch", root, pdf }, {
    on_exit = function()
      watch_jobs[bufnr] = nil
    end,
  })

  vim.fn.jobstart({ "zathura", pdf }, { detach = true })
  vim.notify "Compilation continue + Zathura lancés"
end

function M.stop()
  local bufnr = vim.api.nvim_get_current_buf()
  if watch_jobs[bufnr] then
    vim.fn.jobstop(watch_jobs[bufnr])
    watch_jobs[bufnr] = nil
  end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    for _, id in pairs(watch_jobs) do
      vim.fn.jobstop(id)
    end
  end,
})

return M
