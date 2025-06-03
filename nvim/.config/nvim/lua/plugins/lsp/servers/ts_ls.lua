local M = {}

M.ts_ls = {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "vue" },
}

return M
