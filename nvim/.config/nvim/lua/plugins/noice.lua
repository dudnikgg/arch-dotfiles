return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },

  config = function()
    local noice = require("noice")

    -- require("notify").setup({
    --   background_colour = "#000000",
    -- })

    noice.setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        hover = { enabled = true },
        signature = {
          auto_open = {
            enabled = false, -- disable auto opening signature help
            trigger = true, -- auto open on trigger character
          },
        },
      },
      views = {
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        cmdline_popup = {
          relative = "editor",
          position = {
            row = "50%",
            col = "45%",
          },
        },

        mini = {
          size = {
            -- width = "auto",
            -- height = "auto",
            -- max_height = 15,
          },
          position = {
            row = -2,
            col = "100%",
          },
        },
      },
      health = {
        checker = true,
      },
      signature = {
        enabled = false,
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
  end,
}
