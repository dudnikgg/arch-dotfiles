return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      vue = {},
      php = { "phpcbf" },
      json = { "jq" },
    },
    -- default_format_opts = {
    --   lsp_format = "fallback",
    -- },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    log_level = vim.log.levels.DEBUG,
  },
  init = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "ConformLoaded" })
  end,
}
