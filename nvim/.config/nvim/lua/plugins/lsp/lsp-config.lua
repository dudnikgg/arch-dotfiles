return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Allows extra capabilities provided by blink.cmp
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    -- NOTE: seems like not needed anymore
    --
    -- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp
    -- vim.lsp.config("*", {
    --   capabilities = capabilities,
    -- })

    -- Add other LSP servers as needed, e.g., gopls, eslint, html, etc.
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("html")
    vim.lsp.enable("vue_ls")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("bashls")
    vim.lsp.enable("cssls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("gopls")
    vim.lsp.enable("emmet_ls")
    vim.lsp.enable("emmet_language_server")
    vim.lsp.enable("marksman")

    local vue_ls_share = vim.fn.expand("$MASON/packages/vue-language-server")
    local vue_plugin_path = vue_ls_share .. "/node_modules/@vue/language-server"

    require("lspconfig").ts_ls.setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_plugin_path,
            languages = { "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "vue" },
    })

    -- Configure eash LSP
    vim.lsp.config("lua_ls", {
      settings = {
        ["Lua"] = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- NOTE: LSP Keybidings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        -- Check `:help vim.lsp.*` for documentation on any of the below functions
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- keymaps
        map("gR", require("fzf-lua").files, "[G]oto LSP [R]eferences")

        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration") -- go to declaration

        map("gd", require("fzf-lua").lsp_definitions, "[G]oto LSP [D]efinitions") -- show lsp definitions

        map("gi", require("fzf-lua").lsp_implementations, "[G]oto LSP [I]mplementations") -- show lsp implementations

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("gT", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")

        map("<leader>vca", vim.lsp.buf.code_action, "See available code actions", { "n", "v" }) -- see available code actions, in visual mode will apply to selection

        map("<leader>rn", vim.lsp.buf.rename, "Smart [R]e[N]ame") -- smart rename

        map("<leader>dq", require("fzf-lua").loclist, "Open diagnostic [Q]uickfix list")
        map("<leader>ds", vim.diagnostic.open_float, "Show line diagnostics") -- show diagnostics for line

        -- Toggle LSP diagnostics visibility
        local isLspDiagnosticsVisible = true
        vim.keymap.set("n", "<leader>lx", function()
          isLspDiagnosticsVisible = not isLspDiagnosticsVisible
          vim.diagnostic.config({
            virtual_text = isLspDiagnosticsVisible,
            underline = isLspDiagnosticsVisible,
          })
        end, { desc = "Toggle LSP diagnostics" })

        map("<leader>dk", function()
          vim.lsp.buf.hover({ border = "bold", max_height = 25, max_width = 120 })
        end, "Show documentation for what is under cursor") -- show documentation for what is under cursor

        map("<leader>rs", ":LspRestart<CR>", "Restart LSP") -- mapping to restart lsp if necessary

        map("<C-h>", vim.lsp.buf.signature_help, "", { "i" })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        -- local highlight_augroup = vim.api.nvim_create_augroup("UserLSPHighlight", { clear = false })
        -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --   buffer = event.buf,
        --   group = highlight_augroup,
        --   callback = vim.lsp.buf.document_highlight,
        -- })
        --
        -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --   buffer = event.buf,
        --   group = highlight_augroup,
        --   callback = vim.lsp.buf.clear_references,
        -- })
        --
        -- vim.api.nvim_create_autocmd("LspDetach", {
        --   group = vim.api.nvim_create_augroup("UserLSPHighlight", { clear = true }),
        --   callback = function(event2)
        --     vim.lsp.buf.clear_references()
        --     vim.api.nvim_clear_autocmds({ group = "UserLSPHighlight", buffer = event2.buf })
        --   end,
        -- })
        --
        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end,
    })

    -- Set the diagnostic config with all icons
    vim.diagnostic.config({
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
      virtual_text = true, -- Specify Enable virtual text for diagnostics
      underline = true, -- Specify Underline diagnostics
      update_in_insert = false, -- Keep diagnostics active in insert mode
    })
  end,
}
