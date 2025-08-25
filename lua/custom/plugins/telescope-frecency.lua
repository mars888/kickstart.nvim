-- https://github.com/nvim-telescope/telescope-frecency.nvim
-- Frecency implementation for Telescope.

return {
  'nvim-telescope/telescope-frecency.nvim',
  -- install the latest stable version
  version = '*',
  config = function()
    require('telescope').load_extension 'frecency'

    -- Override mapping in lua\custom\plugins\telescope.lua:
    vim.keymap.set('n', '<leader>sf', '<Cmd>Telescope frecency workspace=CWD<CR>', { desc = '[S]earch [F]iles (frecency)' })
  end,
}
