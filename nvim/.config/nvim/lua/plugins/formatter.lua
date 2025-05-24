return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo", "ConformFormat" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
        vim.cmd("redraw")
      end,
      mode = { "n", "v" },
      desc = "Format buffer (conform)",
    },
    {
      "<leader>F",
      function()
        vim.lsp.buf.format()
      end,
      mode = "n",
      desc = "Format buffer (LSP only)",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
