return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },

  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  config = function()
    local oil = require("oil")

    oil.setup(DD.oil)

    -- opens parent dir over current active window
    vim.keymap.set("n", "<leader>-", function()
      local util = require("oil.util")
      oil.open()
      util.run_after_load(0, function()
        oil.open_preview()
      end)
    end, { desc = "oil: open file explorer with preview" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil", -- Adjust if Oil uses a specific file type identifier
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
