return {
  "echasnovski/mini.statusline",
  version = false,
  config = function()
    local statusline = require("mini.statusline")

    local function custom_diagnostics()
      local config = vim.diagnostic.config()
      local signs = config.signs and config.signs.text
      assert(signs, "No diagnostic signs.text defined in vim.diagnostic.config!")

      local diagnostics = vim.diagnostic.get(0)
      local counts = { error = 0, warn = 0 }

      for _, d in ipairs(diagnostics) do
        if d.severity == vim.diagnostic.severity.ERROR then
          counts.error = counts.error + 1
        elseif d.severity == vim.diagnostic.severity.WARN then
          counts.warn = counts.warn + 1
        end
      end

      local result = {}
      if counts.error > 0 then
        local icon = signs[vim.diagnostic.severity.ERROR]
        assert(icon, "Missing error icon in diagnostic config!")
        table.insert(result, "%#MiniStatuslineDiagError#" .. icon .. counts.error)
      end
      if counts.warn > 0 then
        local icon = signs[vim.diagnostic.severity.WARN]
        assert(icon, "Missing warning icon in diagnostic config!")
        table.insert(result, "%#MiniStatuslineDiagWarn#" .. icon .. counts.warn)
      end

      return table.concat(result, " ")
    end

    statusline.setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local diagnostics = custom_diagnostics()

          local filename = vim.fn.expand("%:~:.")

          local raw_fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 50 })
          local filetype = raw_fileinfo:match("^%S+%s+%S+") or raw_fileinfo
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local git = MiniStatusline.section_git({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            -- LEFT: mode (dynamic color), git, diagnostics
            { hl = mode_hl, strings = { mode } },
            {
              strings = {
                "%#MiniStatuslineGitBranch#",
                git,
              },
            },
            -- CENTER: filename (centered)
            {
              hl = "MiniStatuslineFileinfo",
              strings = {
                "%=",
                filename,
                "%=",
              },
            },
            -- RIGHT: filetype
            {
              strings = {
                "%#MiniStatuslinePlaceholder#",
                " ",
                diagnostics,
                "%#MiniStatuslineDiff#",
                diff,
                "%#MiniStatuslineFileType#",
                filetype,
              },
            },
          })
        end,
        inactive = function()
          return MiniStatusline.combine_groups({
            { hl = "MiniStatuslineInactive", strings = { MiniStatusline.section_filename() } },
          })
        end,
      },
    })

    vim.cmd([[
  highlight MiniStatuslineModeNormal  guibg=#50fa7b guifg=#282a36
  highlight MiniStatuslineModeInsert  guibg=#8be9fd guifg=#282a36
  highlight MiniStatuslineModeVisual  guibg=#ffb86c guifg=#282a36
  highlight MiniStatuslineModeReplace guibg=#ff5555 guifg=#282a36
  highlight MiniStatuslineFileinfo    guibg=#282a36 guifg=#f8f8f2
  highlight MiniStatuslineInactive    guibg=#282a36 guifg=#6272a4
  highlight MiniStatuslineDiagError   guifg=#ff5555 guibg=#282a36
  highlight MiniStatuslineDiagWarn    guifg=#f1fa8c guibg=#282a36
  highlight MiniStatuslineGitBranch guibg=#f1fa8c guifg=#282a36
  highlight MiniStatuslineDiff      guibg=#ffb86c guifg=#282a36
  highlight MiniStatuslineFileType  guibg=#50fa7b guifg=#282a36
  highlight MiniStatuslinePlaceholder guibg=#282a36 guifg=#282a36
]])
  end,
}
