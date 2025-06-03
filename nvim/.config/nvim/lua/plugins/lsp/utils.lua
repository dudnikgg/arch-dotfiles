local M = {}

function M.load_all_server_configs()
  local servers = {}
  local config_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/servers"
  local scan = require("plenary.scandir")

  for _, file in ipairs(scan.scan_dir(config_path, { depth = 1, add_dirs = false })) do
    if file:match("%.lua$") then
      local modname = file:match("plugins/lsp/servers/(.+)%.lua$")
      if modname then
        local ok, mod = pcall(require, "plugins.lsp.servers." .. modname)
        if ok and type(mod) == "table" then
          servers = vim.tbl_deep_extend("force", servers, mod)
        else
          vim.notify("Failed to load server config: " .. modname, vim.log.levels.ERROR)
        end
      else
        vim.notify("Failed to load server config: ", vim.log.levels.ERROR)
      end
    end
  end

  return servers
end

return M
