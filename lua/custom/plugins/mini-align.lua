-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-align.md
-- Alignment related plugin

return {
  'echasnovski/mini.align',
  version = '*',
  config = function ()
    require('mini.align').setup()
  end
}
