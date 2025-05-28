--------------
-- obsidian --
--------------
--
-- >>> ov # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> `$ on "Note Name"` # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> <leader>on # inside nvim now, format note as template
-- >>> <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>odd # delete current note
--

-- convert note to template and remove leading white space
vim.keymap.set(
  "n",
  "<leader>on",
  ":ObsidianTemplate new-note-template<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>"
)
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
-- vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--
-- search for files in full vault
vim.keymap.set("n", "<leader>os", ":FzfLua files cwd=~/Documents/ObsidianVault/md-vault <cr>")
vim.keymap.set("n", "<leader>oz", ":FzfLua live_grep cwd=~/Documents/ObsidianVault/md-vault <cr>")

-- delete file in current buffer
vim.keymap.set("n", "<leader>od", ":!rm '%:p'<cr>:bd<cr>")

-- checkbox create empty/done
vim.keymap.set("n", "<leader>cc", [[:s/\[x\]/[ ]/<cr>]], { silent = true })
vim.keymap.set("n", "<leader>ccd", [[:s/\[\s\]/[x]/<cr>]], { silent = true })

-- Toggle checkbox values
local function toggle_checkbox()
  -- Get the current line
  local line = vim.api.nvim_get_current_line()

  -- Check if line contains unchecked checkbox
  if line:match("^%s*-%s*%[ %]") then
    -- Replace unchecked with checked
    local new_line = line:gsub("%[ %]", "[x]")
    vim.api.nvim_set_current_line(new_line)

    -- Check if line contains checked checkbox
  elseif line:match("^%s*-%s*%[x%]") then
    -- Replace checked with unchecked
    local new_line = line:gsub("%[x%]", "[ ]")
    vim.api.nvim_set_current_line(new_line)

    -- If no checkbox, do nothing
  else
    print("No checkbox found on this line")
  end
end

vim.keymap.set("n", "<leader>ct", toggle_checkbox, { noremap = true, silent = true })
