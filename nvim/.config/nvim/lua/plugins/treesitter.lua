return {
  {
    "numToStr/Comment.nvim",
    config = function()
      local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = "^$",
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },
        pre_hook = prehook,
        post_hook = nil,
      })
    end,
    event = "BufReadPre",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- auto insert closing tags
      {
        "windwp/nvim-ts-autotag",
        ft = {
          "html",
          "vue",
        },
      },
    },
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter")

      require("nvim-treesitter.configs").setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<S-CR>",
            node_incremental = "<CR>",
            node_decremental = "<S-TAB>",
          },
        },
        ensure_installed = { "vue", "html", "css", "typescript", "javascript", "lua", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      })
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup({})

      -- vim.g.skip_ts_context_commentstring_module = true

      -- Disable hiding the "```" in markdown
      -- require("vim.treesitter.query").set(
      --   "markdown",
      --   "highlights",
      --   [[
      --   ;From MDeiml/tree-sitter-markdown
      --   [
      --     (fenced_code_block_delimiter)
      --   ] @punctuation.delimiter
      --   ]]
      -- )
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
}
