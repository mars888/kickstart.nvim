-- https://github.com/folke/snacks.nvim
-- A collection of small QoL plugins for Neovim.
-- Use `:checkhealth snacks` to see if everything is set up correctly.

local function toggle_snacks_dim()
  local dim = require('snacks').dim
  if dim.enabled then
    dim.disable()
  else
    dim.enable()
  end
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    -- explorer = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = true },

    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ['A'] = 'explorer_add_dotnet',
              },
            },
          },
          actions = {
            explorer_add_dotnet = function(picker)
              local dir = picker:dir()
              local tree = require 'snacks.explorer.tree'
              local actions = require 'snacks.explorer.actions'
              local easydotnet = require 'easy-dotnet'

              easydotnet.create_new_item(dir, function(item_path)
                tree:open(dir)
                tree:refresh(dir)
                actions.update(picker, { target = item_path })
              end)
            end,
          },
        },
      },
    },
  },
  keys = {
    -- LazyGit
    {
      '<leader>hlg',
      function()
        require('snacks').lazygit()
      end,
      desc = 'LazyGit',
    },
    {
      '<leader>hll',
      function()
        require('snacks').lazygit.log()
      end,
      desc = 'LazyGit log',
    },
    {
      '<leader>hlf',
      function()
        require('snacks').lazygit.log_file()
      end,
      desc = 'LazyGit log file',
    },
    -- Dim
    { '<leader>td', toggle_snacks_dim, desc = 'Toggle dim' },
    -- Explorer
    -- {
    --   '\\',
    --   function()
    --     require('snacks').explorer()
    --   end,
    --   desc = 'Toggle explorer',
    -- },
    -- Notifier
    {
      '<leader>gun',
      function()
        require('snacks').notifier.show_history()
      end,
      desc = 'Notification history',
    },
    -- Scratch buffer
    {
      '<leader>.',
      function()
        require('snacks').scratch()
      end,
      desc = 'Scratch buffer',
    },
    {
      '<leader>S',
      function()
        require('snacks').scratch.select()
      end,
      desc = 'Select scratch buffer',
    },
  },
}
