-- https://github.com/xzbdmw/colorful-menu.nvim
-- Out of box, this plugin reconstructs completion item and applies treesitter highlight queries to produce variable-size highlight ranges.

return {
  'xzbdmw/colorful-menu.nvim',
  config = function ()
    require('colorful-menu').setup()
  end
}
