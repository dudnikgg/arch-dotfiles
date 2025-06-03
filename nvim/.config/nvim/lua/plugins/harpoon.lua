return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
      },
    })

    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

    vim.api.nvim_exec_autocmds("User", { pattern = "HarpoonLoaded" })
  end,
}
