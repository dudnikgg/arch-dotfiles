local opts = { noremap = true, silent = true }

local function with_desc(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- NOTE:
-- General keymaps

-- save, quit
vim.keymap.set("n", "<leader>w", ":w<cr>", opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", opts)

-- Go to start/end of the line
vim.keymap.set({ "n", "v" }, "gh", "^", with_desc("[G]o to the beginning line"))
vim.keymap.set("n", "gl", "$", with_desc("[G]o to the end of the line"))
-- In visual mode, after going to the end of the line, come back 1 character (land on new line by default)
vim.keymap.set("v", "gl", "$h", with_desc("[G]o to the end of the line"))

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Split Navigation
-- See `:help wincmd` for a list of all window commands
--
-- split window vertically
vim.keymap.set("n", "<leader>sv", "<C-w>v", with_desc("[S]plit window [V]ertically"))
-- split window horizontally
vim.keymap.set("n", "<leader>sh", "<C-w>s", with_desc("[S]plit window [H]orizontally"))
-- make split windows equal width & height
vim.keymap.set("n", "<leader>se", "<C-w>=", with_desc("Make [S]plits [E]qual size"))
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", with_desc("[S]plit e[X]it"))

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

-- Tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>") --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>") --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>") --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

-- Move line in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts) -- moves lines down in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts) -- moves lines up in visual mode

-- Centered Movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- move down in buffer with cursor centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts) -- move up in buffer with cursor centered

-- Centered next/prev search
vim.keymap.set("n", "n", "nzzzv", opts) -- loop through search result with cursor centered
vim.keymap.set("n", "N", "Nzzzv", opts) -- loop through search result backwards with cursor centered

-- Indent without exiting visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without replacing clipboard content
vim.keymap.set("x", "<leader>p", [["_P]])

-- Paste text instead of selection without copying the replaced selection text
vim.keymap.set("v", "p", '"_dp', opts)

-- Replace 'c' with black-hole 'c' in normal and visual mode
vim.keymap.set("n", "c", '"_c', opts)
vim.keymap.set("n", "C", '"_C', opts)
vim.keymap.set("n", "cc", '"_cc', opts)
vim.keymap.set("v", "c", '"_c', opts)
vim.keymap.set("v", "C", '"_C', opts)
-- For operator-pending text objects like `ci{`, `ciw`, etc.
vim.keymap.set("o", "c", '"_c', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })

-- Delete without copying
-- vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]])
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "Q", "<nop>")

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

-- Search selected text in the current buffer
vim.keymap.set("v", "<Space>/", function()
  -- Yank the visually selected text without affecting system clipboard
  vim.cmd('normal! "vy')

  -- Escape any special characters in the selection for literal search
  local text = vim.fn.escape(vim.fn.getreg("v"), [[\/.*$^~[]])

  -- Start a search for the literal string
  vim.fn.setreg("/", text)
  vim.cmd("normal! n")
end, { noremap = true, silent = true })

-- Functions to toggle comments in JavaScript
-- (for use in Vue files, where comment.nvim is not working for me)
vim.keymap.set({ "n", "v" }, "<leader>jc", [[:s/^/\/\//g<cr>]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>jd", [[:s/\/\///g<cr>]], { silent = true })

-- NOTE: LSP Keybidings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("DDLspConfig", {}),
  callback = function(event)
    local buf = event.buf
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
    end

    -- stylua: ignore
    local keymaps = {

      -- Navigation
      { "gD",         vim.lsp.buf.declaration,                "Go to Declaration" },
      { "gd",         require("fzf-lua").lsp_definitions,     "Go to Definitions" },
      { "gT",         require("fzf-lua").lsp_typedefs,        "Go to Type Definition" },
      { "gi",         require("fzf-lua").lsp_implementations, "Go to Implementations" },
      { "gr",         require("fzf-lua").lsp_references,      "Go to References" },

      -- Actions
      { "<leader>ca", vim.lsp.buf.code_action,                "Code Actions",             { "n", "v" } },
      { "<leader>rn", vim.lsp.buf.rename,                     "Rename Symbol" },

      -- Diagnostics
      { "<leader>ds", vim.diagnostic.open_float,              "Show Line Diagnostics" },
      { "<leader>dq", require("fzf-lua").loclist,             "Diagnostics Quickfix List" },

      -- Documentation & Help
      { "<leader>k", function() vim.lsp.buf.hover() end,     "Hover Documentation", },
      { "<C-h>",      vim.lsp.buf.signature_help,             "Signature Help",           { "i" } },

      -- LSP Tools
      { "<leader>rs", ":LspRestart<CR>",                      "Restart LSP" },
      {
        "<leader>th",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
        end,
        "Toggle Inlay Hints",
      },
    }

    for _, km in ipairs(keymaps) do
      map(km[1], km[2], km[3], km[4])
    end

    -- Global toggle for LSP diagnostics
    local diagnostics_enabled = true
    vim.keymap.set("n", "<leader>lx", function()
      diagnostics_enabled = not diagnostics_enabled
      require("tiny-inline-diagnostic").toggle()
    end, { desc = "Toggle LSP Diagnostics" })
  end,
})

-- NOTE:
-- FZF-lua keys
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("FzfLuaConfig", {}),
  pattern = "VeryLazy",
  callback = function()
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    local fzf = require("fzf-lua")
    -- stylua: ignore
    local keymaps = {
      { "<leader>ff",  function() fzf.files() end,            "[F]ind [F]iles in Project Directory" },
      { "<leader>fz",  function() fzf.live_grep({resume=true}) end, "[F]ind by [G]repping inside Project Directory" },
      { "<leader>fgd", function() fzf.git_diff() end,         "[F]ind [G]it [D]iff" },
      { "<leader>fgb", function() fzf.git_branches() end,     "[F]ind [G]it [B]ranches" },
      { "<leader>fgc", function() fzf.git_commits() end,      "[F]ind [G]it [C]ommits" },
      { "<leader>fw",  function() fzf.grep_cword() end,       "[F]ind current [W]ord" },
      { "<leader>/",   function() fzf.lgrep_curbuf() end,     "[/] Live grep the current buffer" },
      { "<leader>fb",  function() fzf.builtin() end,          "[F]ind [B]uiltin" },
    }

    for _, km in ipairs(keymaps) do
      map(km[1], km[2], km[3])
    end
  end,
})

-- NOTE:
-- Flash keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "FlashLoaded",
  group = vim.api.nvim_create_augroup("FlashKeymaps", {}),
  callback = function()
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    local ok, flash = pcall(require, "flash")
    if not ok then
      return
    end

    map("<C-s>", flash.jump, "Flash", { "n", "x", "o" })
    map("<C-S-S>", flash.treesitter, "Flash Treesitter", { "n", "x", "o" })
    map("rf", flash.remote, "Remote Flash", "o")
    map("Rf", flash.treesitter_search, "Treesitter Search", { "o", "x" })
    map("<C-s>", flash.toggle, "Toggle Flash Search", "c")
  end,
})

-- NOTE:
-- Conform keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "ConformLoaded",
  group = vim.api.nvim_create_augroup("ConformConfig", {}),
  callback = function()
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    local ok, conform = pcall(require, "conform")
    if not ok then
      return
    end

    -- stylua: ignore
    map("<leader>cf", function() conform.format({ async = true, lsp_fallback = true }) vim.cmd("redraw") end,"Format buffer (conform)", { "n", "v" } )

    -- stylua: ignore
    map("<leader>F", function() vim.lsp.buf.format() end,"Format buffer (LSP only)", "n" )
  end,
})

-- NOTE:
-- Harpoon Keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "HarpoonLoaded",
  group = vim.api.nvim_create_augroup("HarpoonConfig", {}),
  callback = function()
    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { desc = desc })
    end

    local ok, harpoon = pcall(require, "harpoon")
    if not ok then
      return
    end

    map("<leader>ha", function()
      harpoon:list():add()
    end, "[H]arpoon [A]dd file to the list", "n")

    map("<leader>hd", function()
      harpoon:list():remove()
    end, "[H]arpoon [D]elete file from the list", "n")

    map("<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "n")

    -- Toggle previous & next buffers stored within Harpoon list
    map("<C-p>", function()
      harpoon:list():prev()
    end, "n")
    map("<C-n>", function()
      harpoon:list():next()
    end, "n")
  end,
})

-- NOTE:
-- Open Lazy and Mason keybinds
vim.keymap.set("n", "<leader>M", function()
  vim.cmd("Mason")
end, with_desc("Open [M]ason"))

vim.keymap.set("n", "<leader>L", function()
  vim.cmd("Lazy")
end, with_desc("Open [L]azy"))

-- NOTE:
-- Fyles keybinds
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("Fyler kind=split:right")
end, with_desc("Open [F]yler"))
