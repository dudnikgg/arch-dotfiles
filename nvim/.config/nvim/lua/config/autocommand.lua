local augroup = vim.api.nvim_create_augroup("user_config_autocommand", { clear = true })

-- Use 'q' to close specific buffer types (help, lspinfo, neo-tree, quickfix)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  desc = "Use 'q' to close specific buffers",
  pattern = { "help", "lspinfo", "qf", "" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Return the cursor to the last known position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Go to last location when reopening a file",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

local Prettier = vim.api.nvim_create_augroup("Prettier", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
  group = Prettier,
  pattern = "*.vue",
  command = "silent !node_modules/.bin/prettier % -w",
})

-- Enable JSON folding
-- `zc` to close a fold
-- `zo` to open a fold
-- `za` to toggle a fold
-- `zR` to open all folds
-- `zM` to close all folds
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.json",
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99 -- Start with all folds open
  end,
})
