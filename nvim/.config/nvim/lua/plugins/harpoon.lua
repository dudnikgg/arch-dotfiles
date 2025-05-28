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

    -- NOTE:
    -- fzf-lua into Harpoon function
    -- local function toogle_fzf(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("fzf-lua").fzf_exec(file_paths, {
    --     prompt = "Harpoon> ",
    --     previewer = "builtin", -- can be "builtin", "bat", or your custom preview
    --     actions = {
    --       ["default"] = function(selected)
    --         if selected and selected[1] then
    --           vim.cmd("edit " .. selected[1])
    --         end
    --       end,
    --     },
    --   })
    -- end

    --Harpoon Nav Interface
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "[H]arpoon [A]dd file to the list" })

    vim.keymap.set("n", "<leader>hd", function()
      harpoon:list():remove()
    end, { desc = "[H]arpoon [D]elete file from the list" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    --Harpoon marked files
    vim.keymap.set("n", "<C-1>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-2>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-3>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-4>", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-p>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():next()
    end)
  end,
}
