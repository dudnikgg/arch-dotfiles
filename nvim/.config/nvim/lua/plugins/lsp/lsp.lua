return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local utils = require("plugins.lsp.utils")
    local servers = utils.load_all_server_configs()

    -- Enable lsp
    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
