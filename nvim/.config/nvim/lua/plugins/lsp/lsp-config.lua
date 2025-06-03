return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    servers = {
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "vue" },
      },
      lua_ls = {
        settings = {
          Lua = {
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
      },
      intelephense = {
        settings = {
          intelephense = {
            stubs = {
              "amqp",
              "apache",
              "apcu",
              "bcmath",
              "blackfire",
              "bz2",
              "calendar",
              "cassandra",
              "com_dotnet",
              "Core",
              "couchbase",
              "crypto",
              "ctype",
              "cubrid",
              "curl",
              "date",
              "dba",
              "decimal",
              "dom",
              "ds",
              "enchant",
              "Ev",
              "event",
              "exif",
              "fann",
              "FFI",
              "ffmpeg",
              "fileinfo",
              "filter",
              "fpm",
              "ftp",
              "gd",
              "gearman",
              "geoip",
              "geos",
              "gettext",
              "gmagick",
              "gmp",
              "gnupg",
              "grpc",
              "hash",
              "http",
              "ibm_db2",
              "iconv",
              "igbinary",
              "imagick",
              "imap",
              "inotify",
              "interbase",
              "intl",
              "json",
              "judy",
              "ldap",
              "leveldb",
              "libevent",
              "libsodium",
              "libxml",
              "lua",
              "lzf",
              "mailparse",
              "mapscript",
              "mbstring",
              "mcrypt",
              "memcache",
              "memcached",
              "meminfo",
              "meta",
              "ming",
              "mongo",
              "mongodb",
              "mosquitto-php",
              "mqseries",
              "msgpack",
              "mssql",
              "mysql",
              "mysql_xdevapi",
              "mysqli",
              "ncurses",
              "newrelic",
              "oauth",
              "oci8",
              "odbc",
              "openssl",
              "parallel",
              "Parle",
              "pcntl",
              "pcov",
              "pcre",
              "pdflib",
              "PDO",
              "pdo_ibm",
              "pdo_mysql",
              "pdo_pgsql",
              "pdo_sqlite",
              "pgsql",
              "Phar",
              "phpdbg",
              "posix",
              "pspell",
              "pthreads",
              "radius",
              "rar",
              "rdkafka",
              "readline",
              "recode",
              "redis",
              "Reflection",
              "regex",
              "rpminfo",
              "rrd",
              "SaxonC",
              "session",
              "shmop",
              "SimpleXML",
              "snmp",
              "soap",
              "sockets",
              "sodium",
              "solr",
              "SPL",
              "SplType",
              "SQLite",
              "sqlite3",
              "sqlsrv",
              "ssh2",
              "standard",
              "stats",
              "stomp",
              "suhosin",
              "superglobals",
              "svn",
              "sybase",
              "sync",
              "sysvmsg",
              "sysvsem",
              "sysvshm",
              "tidy",
              "tokenizer",
              "uopz",
              "uv",
              "v8js",
              "wddx",
              "win32service",
              "winbinder",
              "wincache",
              "xcache",
              "xdebug",
              "xhprof",
              "xml",
              "xmlreader",
              "xmlrpc",
              "xmlwriter",
              "xsl",
              "xxtea",
              "yaf",
              "yaml",
              "yar",
              "zend",
              "Zend OPcache",
              "ZendCache",
              "ZendDebugger",
              "ZendUtils",
              "zip",
              "zlib",
              "zmq",
              "zookeeper",
              "wordpress",
              "woocommerce",
              "acf-pro",
              "wordpress-globals",
              "wp-cli",
              "genesis",
              "polylang",
            },
            environment = {
              includePaths = {
                "/home/dudnikgg/dd-dev/php-stubs/",
              },
            },
            files = {
              maxSize = 5000000,
            },
          },
        },
      },
      html = {
        filetypes = { "php", "html", "vue" },
      },
      eslint = {
        settings = {
          experimental = {
            useFlatConfig = false,
          },
        },
      },
      vue_ls = {},
      bashls = {},
      cssls = {
        settings = { css = { lint = { unknownAtRules = "ignore" } } },
      },
      tailwindcss = {},
      gopls = {},
      emmet_language_server = {},
      marksman = {},
    },
  },
  config = function(_, opts)
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")

    -- Ensure Mason to install servers
    mason_lspconfig.setup({
      automatic_enable = false,
      ensure_installed = vim.tbl_keys(opts.servers or {}),
    })

    -- Enable lsp
    for server, config in pairs(opts.servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

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

    -- Eslint lsp format on save
    local base_on_attach = vim.lsp.config.eslint.on_attach
    vim.lsp.config("eslint", {
      on_attach = function(client, bufnr)
        if not base_on_attach then
          return
        end

        base_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "LspEslintFixAll",
        })
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
      virtual_text = false, -- false for diagnostice plugin. Specify Enable virtual text for diagnostics
      underline = true, -- Specify Underline diagnostics
      update_in_insert = false, -- Keep diagnostics active in insert mode
    })
  end,
}
