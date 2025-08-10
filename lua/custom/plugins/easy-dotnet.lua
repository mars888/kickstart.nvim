-- https://github.com/GustavEikaas/easy-dotnet.nvim?tab=readme-ov-file
-- Simplifying .NET development in Neovim

return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('easy-dotnet').setup()
  end,
}
