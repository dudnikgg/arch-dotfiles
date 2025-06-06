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

-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" }
)

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

-- Show `` in specific files
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.txt", "*.md", "*.json" }, command = "setlocal conceallevel=0" }
)

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

-- Open help in a new tab
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = ":wincmd T",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "php", "css", "vue", "html", "javascript", "typescript" },
  callback = function()
    -- Set 'iskeyword' to exclude '-' and '_'
    vim.opt_local.iskeyword = "@,48-57,192-255"
  end,
})

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then
  return
end
local _, pwk = pcall(require, "plugins.which-key.setup")

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    pwk.attach_markdown(0)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "package.json" },
  callback = function()
    pwk.attach_npm(0)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*test.js", "*test.ts", "*test.tsx", "*spec.ts", "*spec.tsx" },
  callback = function()
    pwk.attach_jest(0)
  end,
})

-- File Type Plugin Lazy Loading
vim.api.nvim_create_autocmd("UIEnter", {
  group = augroup,
  pattern = { "*.test.ts", "*.test.tsx", "*.spec.ts", "*.spec.tsx", "*.test.js", "*.spec.js" },
  callback = function()
    print("lazy loading lua plugins")
    require("lazy.loader").load({
      plugins = { "neotest" },
    })
  end,
})
