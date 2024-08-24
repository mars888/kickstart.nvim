-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  'ThePrimeagen/harpoon',
  enabled = false,
  branch = 'harpoon2',
  requires = { { 'nvim-lua/plenary.nvim' } },
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
    },
    {
      '<C-e>',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
    },
    {
      '<C-h>',
      function()
        require('harpoon'):list():select(1)
      end,
    },
    {
      '<C-t>',
      function()
        require('harpoon'):list():select(2)
      end,
    },
    {
      '<C-n>',
      function()
        require('harpoon'):list():select(3)
      end,
    },
    {
      '<C-s>',
      function()
        require('harpoon'):list():select(4)
      end,
    },
    {
      '<C-S-P>',
      function()
        require('harpoon'):list():prev()
      end
    },
    {
      '<C-S-N>',
      function()
        require('harpoon'):list():next()
      end
    },
  },
}
