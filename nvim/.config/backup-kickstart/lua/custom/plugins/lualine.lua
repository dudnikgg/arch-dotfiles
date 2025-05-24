return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          globalstatus = true,
          component_separators = { left = '|', right = '|' },
        },

        sections = {
          lualine_b = { 'branch', 'diff' },
          -- lualine_x = { 'diagnostics', attached_clients, 'filetype' },
          lualine_c = {
            -- ...other lualine components
            {
              require('tmux-status').tmux_windows,
              cond = require('tmux-status').show,
              padding = { left = 3 },
            },
          },
          lualine_z = {
            -- ...other lualine components
            {
              require('tmux-status').tmux_session,
              cond = require('tmux-status').show,
              padding = { left = 3 },
            },
          },
        },
      }
    end,
  },
}
