-- https://github.com/ray-x/go.nvim
-- Description: A Go development plugin for Neovim that provides features like code navigation, refactoring, and testing.

return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'go', 'gomod' },
  event = { 'CmdlineEnter' },
  build = ':lua require("go.install").update_all_sync()',
  config = function(lp, opts)
    require('go').setup(opts)
    local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require('go.format').goimports()
      end,
      group = format_sync_grp,
    })
  end,
}
