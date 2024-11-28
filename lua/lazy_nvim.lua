-- Plugin manager setup using lazy.nvim
return {
  -- Lazy.nvim setup block
  {
    "nvchad/nvchad",  -- Your color scheme plugin (example)
    lazy = true,       -- Lazy load the color scheme plugin
    config = function()
      -- Custom configuration for the plugin
      -- This is where you can set up your colorscheme
    end,
  },

  -- UI Configuration for lazy.nvim (Icons)
  ui = {
    icons = {
      ft = "",        -- Filetype icon
      lazy = "󰂠",      -- Lazy load icon
      loaded = "",    -- Loaded icon
      not_loaded = "", -- Not loaded icon
    },
  },

  -- Performance optimizations (Disabling unused built-in plugins)
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip",
        "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
        "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball", 
        "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax", "synmenu", 
        "optwin", "compiler", "bugreport", "ftplugin"
      }
    }
  },

  -- Default setup for lazy.nvim (you can define defaults here for plugins)
  defaults = {
    lazy = true,  -- Lazy load plugins by default
  },

  -- Example install configuration (if needed, based on your setup)
  install = {
    colorscheme = { "nvchad" },  -- Install the color scheme plugin
  },
}
