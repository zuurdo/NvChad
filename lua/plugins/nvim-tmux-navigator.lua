return {
  -- Add the nvim-tmux-navigator plugin
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>'),
    vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>'),
    vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>'),
    vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>')

  }
}

