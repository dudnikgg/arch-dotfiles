return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup({
      -- Style preset for diagnostic messages
      -- Available options:
      -- "modern", "classic", "minimal", "powerline",
      -- "ghost", "simple", "nonerdfont", "amongus"
      preset = "powerline",
      options = {
        show_source = {
          enabled = true,
          if_many = false,
        },

        -- Use icons defined in the diagnostic configuration
        use_icons_from_diagnostic = true,

        -- Time (in milliseconds) to throttle updates while moving the cursor
        -- Increase this value for better performance if your computer is slow
        -- or set to 0 for immediate updates and better visual
        throttle = 0,

        -- Minimum message length before wrapping to a new line
        softwrap = 30,

        overflow = {
          padding = 5,
        },
      },
    })
  end,
}
