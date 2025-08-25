-- https://github.com/yetone/avante.nvim
-- avante.nvim is a Neovim plugin designed to emulate the behaviour of the Cursor AI IDE. It provides users with AI-driven code suggestions and the ability to apply these recommendations directly to their source files with minimal effort.

return {
  'yetone/avante.nvim',
  build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
  event = 'VeryLazy',
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = 'copilot',
    windows = {
      input = {
        height = 8,
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    -- 'hrsh7th/nvim-cmp',
    -- 'ibhagwan/fzf-lua',
    'zbirenbaum/copilot.lua',
    'folke/snacks.nvim',
    'stevearc/dressing.nvim',
  },
}
