return {
  "ibhagwan/fzf-lua",
  lazy = false,
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
    -- keymaps
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "[F]ind [F]iles in Project Directory",
    },
    {
      "<leader>fz",
      function()
        require("fzf-lua").live_grep_native()
      end,
      desc = "[F]ind by [G]repping inside Project Directory",
    },
    {
      "<leader>fgd",
      function()
        require("fzf-lua").git_diff()
      end,
      desc = "[F]ind [G]it [D]iff",
    },
    {
      "<leader>fgb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "[F]ind [G]it [B]ranches",
    },
    {
      "<leader>fgc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "[F]ind [G]it [C]ommits",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "[F]ind current [W]ord",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "[/] Live grep the current buffer",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "[F]ind [B]uiltin",
    },
  },

  config = function()
    require("fzf-lua").register_ui_select({
      winopts = {},
    })
  end,
}
