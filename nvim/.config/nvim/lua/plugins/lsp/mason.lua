return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        border = DD.ui.float.border,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd", -- prettier formatter
        "stylua", -- lua formatter
        "beautysh",
        "eslint_d",
        -- { 'eslint_d', version = '13.1.2' },
        "phpcs",
        "phpcbf",
      },
    })
  end,
}
