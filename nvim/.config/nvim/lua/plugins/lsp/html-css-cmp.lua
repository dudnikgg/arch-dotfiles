return {
  "Jezda1337/nvim-html-css",
  dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using blink.cmp
  opts = {
    enable_on = { -- Example file types
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
        border = "none",
        position = "cursor",
      },
    },
    documentation = {
      auto_show = true,
    },
    style_sheets = {},
  },
}
