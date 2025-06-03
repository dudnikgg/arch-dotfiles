return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    dependencies = {
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
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>",
            node_incremental = "<Enter>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          disable = {}, -- optional, list of language that will be disabled
        },
      })

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
  "JoosepAlviste/nvim-ts-context-commentstring",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
