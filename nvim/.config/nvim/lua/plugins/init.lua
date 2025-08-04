return {
  require("plugins.sleuth"), -- Dynamically adjust tabs/spacings for the current buff

  -- UI
  require("plugins.noice"), -- Nice messages and notifications
  require("plugins.which-key"), -- Shows keys helper ui
  require("plugins.colorscheme"), -- Color theme
  require("plugins.todo-comments"),
  require("plugins.twilight"), -- Dimming effect
  require("plugins.highlight-colors"), -- Adds icon to colors
  require("plugins.tailwind-tools"), -- Tailwind features, extends tailwindcss lsp
  require("plugins.diagnostic-inline"), -- Styles for Diagnostic
  -- require("plugins.quick-todo"), -- Quik todo list

  -- Git
  require("plugins.gitsigns"), -- Git things
  require("plugins.neogit"), -- Git integration

  -- Files/search
  require("plugins.oil"), -- File browser
  require("plugins.fzf-lua"), -- FZF search, pickers
  require("plugins.fyler"), -- Nice filetree to pair with oil
  require("plugins.harpoon"), -- Mark files and jump between them
  require("plugins.lazygit"), -- Git

  -- Mini modules
  require("plugins.mini-ai"),
  require("plugins.mini-autopair"),
  require("plugins.mini-surround"),
  require("plugins.mini-scope"),
  require("plugins.mini-statusline"), -- status bar

  -- Other things, code related things
  require("plugins.treesitter"), -- Syntax highlighting and more
  require("plugins.formatter"), -- Code formatter
  require("plugins.flash"), -- Code jumping, better fFtT
  require("plugins.ufo"), -- Code folding
  -- require("plugins.mathup"),

  -- Obsidian
  require("plugins.obsidian"),
  require("plugins.markdown-preview"),

  -- LSP
  require("plugins.lsp.lsp"),
  require("plugins.lsp.mason"),

  -- Autocompletion
  require("plugins.autocompletion"),
  require("plugins.html-css-cmp"),
  require("plugins.copilot"),
}
