local plugins = {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.lspconfig"
      require "custom.configs.lspconfig"

    end
  },
  {
    "williamboman/mason.nvim",
    opts={
      ensure_installed = {
        "lua-language-server",
        "diagnostic-languageserver",
        "clangd",
        "clang-format",
        "mypy",
        "ruff",
        "black",
        "pyright",
        "isort"
      }
    }
  }

}
local builtin = require ('telescope.builtin')
vim.keymap.set('n', '<leader>ps', function()
       builtin.grep_string({search = vim.fn.input("Grep > ")});
end)
return plugins
