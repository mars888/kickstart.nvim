-- https://github.com/nvim-telescope/telescope-project.nvim
-- An extension for telescope.nvim that allows you to switch between projects

return {
  'nvim-telescope/telescope-project.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension('project')

    vim.keymap.set('n', '<leader>sw', function() require('telescope').extensions.project.project { hide_workspace = false, display_type = 'full' } end, { desc = 'Search projects' })
  end,
}
