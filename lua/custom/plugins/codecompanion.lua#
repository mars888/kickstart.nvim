-- https://github.com/olimorris/codecompanion.nvim
-- Code Companion for Neovim, CoPilot like agents for code completion, suggestions, and more.

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
  opts = {

    -- Lua
    strategies = {
      chat = {
        tools = {
          cmd_runner = {
            opts = {
              -- Use Windows PowerShell
              -- shell = { 'powershell.exe', '-NoLogo', '-NoProfile', '-Command' },
              -- Or use PowerShell Core (pwsh)
              shell = { "pwsh.exe", "-NoLogo", "-NoProfile", "-Command" }
            },
          },
        },
      },
    },
  },
}
