local M = {}

M.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" },
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}

return M
