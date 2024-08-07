-- https://github.com/pwntester/octo.nvim?tab=readme-ov-file
-- Edit and review GitHub issues and pull requests from the comfort of your favorite editor.

return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = { 'Octo' },
  opts = {},
}
