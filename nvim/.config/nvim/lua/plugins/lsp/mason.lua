return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✔️",
          package_pending = "➜",
          package_uninstalled = "✘",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_enable = false,
      -- servers for mason to install
      ensure_installed = {
        "lua_ls",
        -- "ts_ls", currently using a ts plugin
        -- "html",
        -- "cssls",
        -- "tailwindcss",
        -- "gopls",
        -- "emmet_ls",
        -- "emmet_language_server",
        -- "eslint",
        -- "marksman",
      },

    })

  end,
}
