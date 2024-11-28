return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter", -- Example additional dependency
  },
  cmd = "Telescope",
  init = function()
    require("core.utils").load_mappings "telescope"
  end,
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },
    extensions_list = { "themes", "terms" }, -- Move this outside `defaults`
  },
  config = function(_, opts)
    -- Optional: Load external settings
    if vim.g.base46_cache then
      local ok, err = pcall(dofile, vim.g.base46_cache .. "telescope")
      if not ok then
        vim.notify("Error loading Telescope cache: " .. err, vim.log.levels.ERROR)
      end
    end

    -- Setup Telescope
    local telescope = require "telescope"
    telescope.setup(opts)

    -- Load extensions
    for _, ext in ipairs(opts.extensions_list or {}) do
      telescope.load_extension(ext)
    end
  end,
}
