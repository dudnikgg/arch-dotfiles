return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  config = function()
    require("flash").setup()
    vim.api.nvim_exec_autocmds("User", { pattern = "FlashLoaded" })
  end,
}
