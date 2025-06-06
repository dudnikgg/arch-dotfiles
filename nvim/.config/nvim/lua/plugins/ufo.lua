return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")

        require("statuscol").setup({
          setopt = true,
          segments = {
            {
              text = { "%s" },
            },
            {
              text = { builtin.foldfunc },
              click = "v:lua.ScSa",
            },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
          --   { text = { "%s " }, click = "v:lua.ScSa" },
          --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          --   { text = { builtin.lnumfunc, "" }, click = "v:lua.ScLa" },
          -- },
          relculright = true,
        })
      end,
    },
  },
  event = "VeryLazy",
  opts = {
    provider_selector = function()
      return { "treesitter", "lsp", "indent" }
    end,
    review = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        -- winhighlight = "Normal:Folded",
        winblend = 0,
      },
    },
  },
  init = function()
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,

  config = function(_, opts)
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set("n", "zK", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })

    require("ufo").setup({})
  end,
}
