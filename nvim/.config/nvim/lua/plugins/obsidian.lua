return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "md-vault",
          path = "~/Documents/ObsidianVault/md-vault/",
        },
      },
      notes_subdir = "_inbox",
      new_notes_location = "_inbox",

      disable_frontmatter = true,
      templates = {
        subdir = "_templates",
        date_format = "%Y-%m-%d",
        -- time_format = "%H:%M:%S",
      },

      -- key mappings, below are the defaults
      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- toggle check-boxes
        ["<leader>ct"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
      },
    })
  end,
}
