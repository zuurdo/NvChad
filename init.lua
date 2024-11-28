-- Load core configuration
require "core"

-- Check for a custom init file and load it if available
local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]
if custom_init_path then
  dofile(custom_init_path)
end

-- Enable relative number globally
vim.opt.relativenumber = true

-- Load custom mappings
require("core.utils").load_mappings()

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim plugins
require("lazy").setup("plugins")

-- Optional: Load base46 defaults if the cache exists
if vim.g.base46_cache then
  local ok, err = pcall(dofile, vim.g.base46_cache .. "defaults")
  if not ok then
    vim.notify("Error loading base46 defaults: " .. err, vim.log.levels.ERROR)
  end
end

-- Load additional configuration if the files exist
local function safe_require(module)
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Error loading module: " .. module .. "\n" .. err, vim.log.levels.ERROR)
  end
end

safe_require("custom.configs.set")
safe_require("vim-options")
