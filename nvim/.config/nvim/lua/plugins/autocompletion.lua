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
    dependencies = { "fang2hou/blink-copilot" },
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
        documentation = {
          auto_show = true,
          treesitter_highlighting = true,
          window = {
            min_width = 10,
            max_width = 60,
            max_height = 20,
            border = DD.ui.float.border,
            scrollbar = true,
          },
        },
        list = {
          max_items = 50,
          selection = {
            preselect = true,
            auto_insert = false,
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
            columns = {
              { "label", gap = 1 },
              { "kind_icon", gap = 1 },
              { "source_name" },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "snippets", "lsp", "copilot", "path", "buffer", "html-css" },
        providers = {
          snippets = {
            min_keyword_length = 2,
            fallbacks = {},
            max_items = 2,
            score_offset = 100,
          },
          lsp = {
            min_keyword_length = 0,
            fallbacks = {},
            max_items = 3,
            score_offset = 50,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            async = true,
            max_items = 2,
            score_offset = 0,
          },
          ["html-css"] = {
            name = "html-css",
            module = "blink.compat.source",
          },

          path = {
            min_keyword_length = 1,
            fallbacks = {},
          },

          buffer = {
            min_keyword_length = 3,
            fallbacks = {},
            max_items = 2,
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
        implementation = "prefer_rust_with_warning",
        -- Frecency tracks the most recently/frequently used items and boosts the score of the item
        -- Note, this does not apply when using the Lua implementation.
        use_frecency = false,

        -- Proximity bonus boosts the score of items matching nearby words
        -- Note, this does not apply when using the Lua implementation.
        use_proximity = false,
        -- sorts = {

        -- Deprioritize 'emmet_ls' suggestions. Good when working with vue/svelte/jsx components
        -- function(a, b)
        --   local a_client = a.client_name
        --   local b_client = b.client_name
        --
        --   if not a_client or not b_client or a_client == b_client then
        --     return
        --   end
        --
        --   -- Prioritize vue_ls
        --   if a_client == "vue_ls" and b_client ~= "vue_ls" then
        --     return true
        --   elseif b_client == "vue_ls" and a_client ~= "vue_ls" then
        --     return false
        --   end
        --
        --   -- Deprioritize emmet_ls
        --   if a_client == "emmet_ls" or a_client == "emmet_language_server" then
        --     return false
        --   elseif b_client == "emmet_ls" or b_client == "emmet_language_server" then
        --     return true
        --   end
        -- end,
        --   "score",
        --   "exact",
        -- },
      },
    },
    opts_extend = { "sources.default" },
  },
}
