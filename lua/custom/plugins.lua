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
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"

    end
  },
  {
    "williamboman/mason.nvim",
    opts={
      ensure_installed = {
        "clangd",
        "clang-format",
        "mypy",
        "ruff",
        "black",
        "pyright",
        "ripgrep",
      }
    }
  }

}
local builtin = require ('telescope.builtin')
vim.keymap.set('n', '<leader>ps', function()
       builtin.grep_string({search = vim.fn.input("Grep > ")});
end)
return plugins
