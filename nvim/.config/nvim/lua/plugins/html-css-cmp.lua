return {
  "Jezda1337/nvim-html-css",
  dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" },
  opts = {
    enable_on = {
      "html",
      "svelte",
      "vue",
      "blade",
      "php",
      "astro",
      "css",
    },
    handlers = {
      definition = {
        bind = "gd",
      },
      hover = {
        bind = "K",
        wrap = true,
        border = DD.ui.float.border,
        position = "cursor",
      },
    },
    documentation = {
      auto_show = true,
    },
    style_sheets = {},
  },
}
