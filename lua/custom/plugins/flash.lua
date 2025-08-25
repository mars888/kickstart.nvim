-- https://github.com/folke/flash.nvim
-- Navigate your code with search labels, enhanced character motions and treesiter integration.

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {},
  },
  -- stylua: ignore
  keys = {
    { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<M-s>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    -- <esc> should already be mapped to `:nohlsearch`, but that stops <esc> from removing the search chars.
    -- Here we combine clearing of both the chars and the hlsearch:
    -- {
    --   '<esc>',
    --   mode = { 'n', 'x', 'o' },
    --   function()
    --     vim.cmd.nohlsearch()
    --     local char = require 'flash.plugins.char'
    --     if char.state then
    --       char.state:hide()
    --     end
    --   end,
    --   { desc = 'Cancel flash characters' },
    -- }
  },
}
