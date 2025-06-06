return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true, -- Automatically loads when required by blink.cmp
    opts = {
      enable_on = { "html", "php", "vue", "css" },
    },
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "super-tab",
        -- ["<C-l>"] = { "accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,

        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        prefetch_on_insert = true,
        show_on_accept_on_trigger_character = false,
        documentation = {
          auto_show = false,
          treesitter_highlighting = true,
          window = {
            min_width = 10,
            max_width = 60,
            max_height = 20,
            border = DD.ui.float.border,
            winblend = vim.o.pumblend,
            scrollbar = true,
            direction_priority = {
              menu_north = { "e", "w", "n", "s" },
              menu_south = { "e", "w", "s", "n" },
            },
          },
        },
        menu = {
          draw = {
            components = {
              -- customize the drawing of kind icons
              kind_icon = {
                text = function(ctx)
                  -- default kind icon
                  local icon = ctx.kind_icon
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr ~= "" then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  -- default highlight group
                  local highlight = "BlinkCmpKind" .. ctx.kind
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                    local color_item =
                      require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr_hl_group then
                      highlight = color_item.abbr_hl_group
                    end
                  end
                  return highlight
                end,
              },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "html-css" },
        providers = {
          ["html-css"] = {
            name = "html-css",
            module = "blink.compat.source",
            score_offset = 0,
          },
          lsp = {
            score_offset = 3,
            min_keyword_length = function(ctx)
              return ctx.trigger.kind == "manual" and 0 or 2
            end,
            fallbacks = {},
            max_items = 10,
          },
          path = {
            score_offset = 2,
            min_keyword_length = 3,
            fallbacks = {},
          },
          snippets = {
            score_offset = 1,
            min_keyword_length = 2,
            fallbacks = {},
          },
          buffer = {
            score_offset = 1,
            min_keyword_length = 3,
            fallbacks = {},
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = {
        -- sorts = { "exact", "score", "sort_text" },
        implementation = "rust",
        sorts = {
          -- Deprioritize 'emmet_ls' suggestions. Good when working with vue/svelte/jsx components
          function(a, b)
            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
              return
            end
            return b.client_name == "emmet_ls"
          end,
          -- default sorts
          "score",
          "sort_text",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
