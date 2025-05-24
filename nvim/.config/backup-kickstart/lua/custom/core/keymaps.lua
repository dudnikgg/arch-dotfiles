local opts = { noremap = true, silent = true }

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
-- split window vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
-- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- close current split window
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- tab stuff
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>') --open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>') --close current tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>') --go to next
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>') --go to pre
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>') --open current tab in new tab

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves lines down in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'moves lines up in visual mode' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move down in buffer with cursor centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move up in buffer with cursor centered' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'loop through search result with cursor centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'loop through search result backwards with cursor centered' })

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Paste without replacing clipboard content
vim.keymap.set('x', '<leader>p', [["_P]])

-- Paste text instead of selection without copying the replaced selection text
vim.keymap.set('v', 'p', '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set('n', '<leader>Y', [["+Y]], opts)

-- Prevents pasting from replacing clipboard in visual mode
vim.keymap.set('v', 'p', '"_dp', opts)

-- Delete without copying
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', 'x', '"_x', opts)

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.keymap.set('n', 'Q', '<nop>')

-- Global word replace
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word cursor is on globally' })

-- Copy filepath to the clipboard
vim.keymap.set('n', '<leader>fp', function()
  local filePath = vim.fn.expand '%:~' -- Gets the file path relative to the home directory
  vim.fn.setreg('+', filePath) -- Copy the file path to the clipboard register
  print('File path copied to clipboard: ' .. filePath) -- Optional: print message to confirm
end, { desc = 'Copy file path to clipboard' })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set('n', '<leader>lx', function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  }
end, { desc = 'Toggle LSP diagnostics' })
-----------------------------------------------------------------------------------

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
