return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
        checkThirdParty = false,
      },
    },
  },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.find_git_ancestor(fname) or vim.fn.stdpath("config")
  end,
}
