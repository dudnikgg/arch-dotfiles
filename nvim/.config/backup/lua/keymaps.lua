-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behaviour in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For consiseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
-- vim.keymap.set('n', '<C-ss>', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<leader>w', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center (works when you search and then jump between results)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<k>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<j>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<h>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<l>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
-- TODO: check for better command which can jump into next opened tab/buffer
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts)   -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>sv', '<C-w>v', opts)      -- split window vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', opts)      -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts)     -- make split windows equal width & height
vim.keymap.set('n', '<leader>sq', ':close<CR>', opts) -- close current split window

-- Navigate between splits
-- vim.keymap.set('n', '<C-Up>', ':wincmd k<CR>', opts)
-- vim.keymap.set('n', '<C-Down>', ':wincmd j<CR>', opts)
-- vim.keymap.set('n', '<C-Left>', ':wincmd h<CR>', opts)
-- vim.keymap.set('n', '<C-Right>', ':wincmd l<CR>', opts)

vim.keymap.set('n', '<leader><Up>', '<C-w>k', opts)    -- Move to the split above
vim.keymap.set('n', '<leader><Down>', '<C-w>j', opts)  -- Move to the split below
vim.keymap.set('n', '<leader><Left>', '<C-w>h', opts)  -- Move to the left split
vim.keymap.set('n', '<leader><Right>', '<C-w>l', opts) -- Move to the right split


-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
