-- https://github.com/jameswolensky/marker-groups.nvim
-- For organizing and annotating code with grouped markers.

return {
  'jameswolensky/marker-groups.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('marker-groups').setup({
      drawer_config = {
        width = 100,
      },
      max_annotation_display = 50,
    })
  end,
}
