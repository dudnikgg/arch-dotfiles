local function substitute()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  local line = vim.fn.getline(start_pos[2])
  local word = vim.trim(string.sub(line, start_pos[3], end_pos[3]))

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { word })

  -- Accept input on Enter
  vim.keymap.set({ "n", "i" }, "<Enter>", function()
    local mode = vim.api.nvim_get_mode().mode

    if mode == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end

    vim.schedule(function()
      vim.cmd("q")
    end)
  end, { buffer = bufnr })

  local noop = false

  -- Clear exit on esc
  vim.keymap.set("n", "<esc>", function()
    noop = true
    vim.cmd("q")
  end, { buffer = bufnr })

  vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    buffer = bufnr,
    callback = function()
      if noop then
        return
      end
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local new_word = vim.trim(lines[1])
      vim.schedule(function()
        vim.cmd('let @/="' .. word .. '"') -- path to register to call witn n or p
        vim.cmd('let @+="' .. new_word .. '"')
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("cgn" .. new_word .. "<esc>", true, false, true), "", true)
      end)
    end,
  })

  local word_width = math.max(#word, 40)

  -- Create float window for editing
  vim.api.nvim_open_win(bufnr, true, {
    relative = "win",
    width = word_width,
    height = 1,
    bufpos = { start_pos[2] - 1, start_pos[3] - 1 },
    col = -1,
    style = "minimal",
    border = "rounded",
    title = "",
    title_pos = "left",
  })
end

-- Keymaps
vim.keymap.set("n", "<leader>uw", function()
  vim.api.nvim_input("viw")
  vim.schedule(function()
    substitute()
  end)
end)

vim.keymap.set("v", "<leader>uw", function()
  substitute()
end)
