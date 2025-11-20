-- https://github.com/norcalli/nvim-colorizer.lua
-- A high-performance color highlighter for Neovim

return {
  'norcalli/nvim-colorizer.lua',
  config = function ()
    require('colorizer').setup()
  end
}
