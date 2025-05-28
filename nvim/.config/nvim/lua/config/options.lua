-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Disable netrw (use if replacing with a modern file explorer)
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
-- vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:netrw_banner = 0 ") -- Hide banner in netrw (if used)

-- Border style around floating windows
vim.o.winborder = "bold"

-- Tab size
vim.opt.tabstop = 2 -- Visual width of tab characters
vim.opt.softtabstop = 2 -- Spaces inserted when pressing Tab
vim.opt.shiftwidth = 2 -- Indent width when using >> or <<
vim.opt.expandtab = true -- Convert tabs to spaces

-- Swap and Backup
vim.opt.swapfile = false -- Don't create swap files
vim.opt.backup = false -- Don't create backup files

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Line numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.showmode = false -- Don't show mode in command line (handled by statusline)

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yanks/pastes
end)

-- Enable indentation logic
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.smartindent = true -- Smart autoindenting for new lines

vim.opt.wrap = false -- Don't wrap long lines

vim.opt.undofile = true -- Enable persistent undo across sessions

-- Search behavior
vim.opt.ignorecase = true -- Case-insensitive searching by default
vim.opt.smartcase = true -- But case-sensitive if search pattern has uppercase
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.inccommand = "split" -- Live preview of :s command in split window

vim.opt.termguicolors = true -- Enable full 24-bit color support
vim.opt.background = "dark" -- Use colors optimized for dark backgrounds

vim.opt.signcolumn = "yes" -- Always show the sign column (prevents shifting)

vim.opt.updatetime = 250 -- Delay before triggering swap/write events
vim.opt.timeoutlen = 1000 -- Time to wait for a mapped sequence to complete

-- Split behavior
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Whitespace and invisibles
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { -- Set symbols for invisible chars
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

vim.opt.cursorline = true -- Highlight the current line
vim.opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor

vim.opt.confirm = true -- Ask to save changes instead of failing commands

vim.o.conceallevel = 2 -- set conceal level for obsidian plugin

vim.opt.backspace = { "start", "eol", "indent" } -- Allow backspacing over everything in insert mode
