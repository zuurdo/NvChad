return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet support
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
      },
      config = function(_, opts)
        local luasnip = require("luasnip")
        luasnip.config.set_config(opts)

        -- Loaders
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
        require("luasnip.loaders.from_snipmate").load()
        require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
        require("luasnip.loaders.from_lua").load()
        require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

        vim.api.nvim_create_autocmd("InsertLeave", {
          callback = function()
            if
              luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
              and not luasnip.session.jump_active
            then
              luasnip.unlink_current()
            end
          end,
        })
      end,
    },

    -- Autopairs
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },

    -- Additional cmp sources
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function(_, opts)
    -- Formatting configuration
    local formatting_style = {
      fields = { "abbr", "kind", "menu" },
      format = function(_, item)
        local icons = require("core.utils").icons or {} -- Define or load icons
        local icon = icons[item.kind] or ""
        item.kind = string.format("%s %s", icon, item.kind or "")
        return item
      end,
    }

    -- Define cmp configuration
    opts.completion = {
      completeopt = "menu,menuone",
    }

    opts.window = {
      completion = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
        scrollbar = false,
      },
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:CmpDoc",
      },
    }

    opts.snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }

    opts.formatting = formatting_style

    opts.mapping = {
      ["<C-p>"] = require("cmp").mapping.select_prev_item(),
      ["<C-n>"] = require("cmp").mapping.select_next_item(),
      ["<C-d>"] = require("cmp").mapping.scroll_docs(-4),
      ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
      ["<C-Space>"] = require("cmp").mapping.complete(),
      ["<C-e>"] = require("cmp").mapping.close(),
      ["<CR>"] = require("cmp").mapping.confirm {
        behavior = require("cmp").ConfirmBehavior.Insert,
        select = true,
      },
      ["<Tab>"] = require("cmp").mapping(function(fallback)
        if require("cmp").visible() then
          require("cmp").select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = require("cmp").mapping(function(fallback)
        if require("cmp").visible() then
          require("cmp").select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    }

    opts.sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    }

    -- Example for additional sources (like emojis)
    table.insert(opts.sources, { name = "emoji" })
  end,
}
