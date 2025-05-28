return {
  "folke/twilight.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },

  config = function()
    local twilight = require("twilight")

    vim.keymap.set("n", "<leader>de", "<cmd>:TwilightEnable<CR><cmd>", { desc = "[D]im [E]nable" })
  end,
}
