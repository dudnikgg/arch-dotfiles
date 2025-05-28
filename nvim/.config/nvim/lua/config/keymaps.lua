local opts = { noremap = true, silent = true }

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- save, quit
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "[G]o to the beginning line" })
vim.keymap.set("n", "gl", "$", { desc = "[G]o to the end of the line" })
-- In visual mode, after going to the end of the line, come back 1 character
vim.keymap.set("v", "gl", "$h", { desc = "[G]o to the end of the line" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize with arrows
vim.keymap.set("n", "<down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<right>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<left>", ":vertical resize +2<CR>", opts)

-- Navigate between splits
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Move to the split above
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Move to the split below
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Move to the left split
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Move to the right split

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual mode" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "loop through search result with cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "loop through search result backwards with cursor centered" })

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without replacing clipboard content
vim.keymap.set("x", "<leader>p", [["_P]])

-- Paste text instead of selection without copying the replaced selection text
vim.keymap.set("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]])
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "Q", "<nop>")

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

-- Functions to toggle comments in JavaScript
-- (for use in Vue files, where comment.nvim is not working for me)
-- vim.keymap.set({'n', 'v'}, '<leader>jc', [[:s/^/\/\//g<cr>]], { silent = true })
-- vim.keymap.set({'n', 'v'}, '<leader>jd', [[:s/\/\///g<cr>]], { silent = true })
