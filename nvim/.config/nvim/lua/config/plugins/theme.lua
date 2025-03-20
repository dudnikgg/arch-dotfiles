return {
  {
    'maxmx03/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      ---@type dracula
      local dracula = require "dracula"

      dracula.setup({
      -- styles = {
      --   Type = {},
      --   Function = {},
      --   Parameter = {},
      --   Property = {},
      --   Comment = {},
      --   String = {},
      --   Keyword = {},
      --   Identifier = {},
      --   Constant = {},
      -- },
      transparent = true,
      on_colors = function (colors, color)
        ---@type dracula.palette
        return {
          -- override or create new colors
          -- selectionBg = "#231739",
          -- mycolor = 0xffffff,
        }
      end,
      on_highlights = function (colors, color)
        ---@type dracula.highlights
        return {
          ---@type vim.api.keyset.highlight
          -- Normal = { bg = colors.selectionBg }
          -- Visual = { bg = colors.selectionBg }
        }
      end,
      plugins = {
        ["nvim-treesitter"] = true,
        -- ["rainbow-delimiters"] = true,
        -- ["nvim-lspconfig"] = true,
        -- ["nvim-navic"] = true,
        -- ["nvim-cmp"] = true,
        -- ["indent-blankline.nvim"] = true,
        ["neo-tree.nvim"] = true,
        -- ["which-key.nvim"] = true,
        -- ["dashboard-nvim"] = true,
        -- ["gitsigns.nvim"] = true,
        -- ["neogit"] = true,
        -- ["todo-comments.nvim"] = true,
        ["lazy.nvim"] = true,
        -- ["telescope.nvim"] = true,
        -- ["noice.nvim"] = true,
        -- ["hop.nvim"] = true,
        -- ["mini.statusline"] = true,
        -- ["mini.tabline"] = true,
        -- ["mini.starter"] = true,
        -- ["mini.cursorword"] = true,
        -- ['bufferline.nvim'] = true,
      }
      })
      vim.cmd.colorscheme 'dracula'
      -- vim.cmd.colorscheme 'dracula-soft'
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = vim.g.colors_name,
        refresh = {
          statusline = 1000,
        },
      },
    },
  }
}
