return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    require("flash").setup({
      modes = {
        char = {
          jump_labels = true,
        },
      },
      jump = { autojump = false, nohlsearch = true },
      label = {
        uppercase = false,
        style = "inline",
      },
    })
    vim.api.nvim_exec_autocmds("User", { pattern = "FlashLoaded" })
  end,
}
