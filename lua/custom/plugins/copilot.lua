-- https://github.com/github/copilot.vim
-- GitHub Copilot integration.

return {
  'github/copilot.vim',
  VeryLazy = true,
  config = function()
    vim.g.copilot_enabled = false
    vim.keymap.set('i', '<M-l>', '<Plug>(copilot-suggest)', { desc = 'Copilot suggest' })
  end,
}
