local M = {}

M.vue_ls = {
  init_options = {
    vue = { hybridMode = true },
  },
  before_init = function(_, config)
    if config.init_options and config.init_options.typescript and config.init_options.typescript.tsdk == "" then
      local root_dir = config.root_dir
      local mason_packages = vim.fn.expand("$MASON/packages")

      local function get_local_tsdk()
        local found = vim.fs.find("node_modules", { path = root_dir, upward = true })[1]
        if not found then
          return nil
        end
        return vim.fs.joinpath(vim.fs.dirname(found), "node_modules", "typescript", "lib")
      end

      local candidate_paths = {
        get_local_tsdk(),
        mason_packages .. "/typescript-language-server/node_modules/typescript/lib",
        mason_packages .. "/vue-language-server/node_modules/typescript/lib",
      }

      local firstValidPath = vim.iter(candidate_paths):find(function(path)
        local abs = vim.fn.fnamemodify(path, ":p")
        local stat = vim.uv.fs_stat(abs)
        return stat and stat.type == "directory"
      end)

      if firstValidPath then
        config.init_options.typescript.tsdk = firstValidPath
        vim.notify("[vue_ls] ✅ TypeScript SDK set to: " .. firstValidPath)
      else
        vim.notify("[vue_ls] ⚠️ Could not find a valid TypeScript SDK path", vim.log.levels.WARN)
      end
    end
  end,
}
return M
