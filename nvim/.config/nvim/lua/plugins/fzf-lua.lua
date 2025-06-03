return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},

  config = function()
    local fzf_lua = require("fzf-lua")
    fzf_lua.setup({
      winopts = {
        border = DD.ui.float.border,
        preview = {
          border = DD.ui.float.border,
        },
      },
      git = {
        diff = {
          preview = "git diff --color {ref} {file}",
        },
      },
      fzf_colors = true,
    })

    fzf_lua.register_ui_select({
      winopts = {},
    })
  end,
}
