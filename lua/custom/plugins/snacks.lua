-- https://github.com/folke/snacks.nvim
-- A collection of small QoL plugins for Neovim.
-- Use `:checkhealth snacks` to see if everything is set up correctly.

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
  },
  keys = {
    -- LazyGit
    { "<leader>hlg", function() require("snacks").lazygit() end, desc = "LazyGit"  },
    { "<leader>hll", function() require("snacks").lazygit.log() end, desc = "LazyGit log" },
    { "<leader>hlf", function() require("snacks").lazygit.log_file() end, desc = "LazyGit log file" },
    -- Dim
    { "<leader>gud", function() require("snacks").dim() end, desc = "Toggle dim" },
    -- Explorer
    { "\\", function() require("snacks").explorer() end, desc = "Toggle explorer" },
    -- Notifier
    { "<leader>gun", function() require("snacks").notifier() end, desc = "Notification history" },
  }
}
