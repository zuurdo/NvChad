return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "vim", "vimdoc" },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- Optionally, handle any additional configuration logic here.
    require("nvim-treesitter.configs").setup(opts)

    -- Example: Custom logic or external file
    if vim.g.base46_cache then
      dofile(vim.g.base46_cache .. "syntax")
    end
  end,
}

