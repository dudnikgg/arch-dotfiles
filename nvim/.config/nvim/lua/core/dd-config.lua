-- Main Config

local icons = require("icons")

DD = {
  icons = icons,
  colorscheme = "dracula",
  ui = {
    float = {
      border = "bold",
    },
  },
  plugins = {
    -- Enables moving by subwords and skips significant punctuation with w, e, b motions
    jump_by_subwords = {
      -- enabled = false,
    },
    rooter = {
      -- Removing package.json from list in Monorepo Frontend Project can be helpful
      -- By that your live_grep will work related to whole project, not specific package
      -- patterns = { ".git", "package.json", "_darcs", ".bzr", ".svn", "Makefile" }, -- Default
    },
  },
  -- Oil configuration
  oil = {
    default_file_explorer = true, -- start up nvim with oil instead of netrw
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-c>"] = false, -- prevent from closing Oil as <C-c> is esc key
      ["<M-h>"] = "actions.select_split",
      ["q"] = "actions.close",
    },
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
    float = {
      border = "bold",
    },
  },
  -- Statusline configuration
  statusline = {
    path_enabled = false,
    path = "relative", -- absolute/relative
  },
}
