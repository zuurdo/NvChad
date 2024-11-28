
  return{
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    event = "User FilePost",
    opts = {
      buftype_exclude = { "terminal" },
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      indentLine_enabled = 1,
      show_current_context = true,
      show_current_context_start = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
    }, 
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      dofile(vim.g.base46_cache .. "blankline")
      require("indent_blankline").setup(opts)
    end,
  }
