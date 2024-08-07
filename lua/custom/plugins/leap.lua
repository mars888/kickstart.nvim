-- From http://www.lazyvim.org/extras/editor/leap#leapnvim
return {
  'ggandor/leap.nvim',
  enabled = true,
  config = function(_, opts)
    local leap = require 'leap'
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    -- leap.add_default_mappings(true)
    vim.keymap.set({ 'n', 'x', 'o' }, '<C-S>', '<Plug>(leap-forward)')
    vim.keymap.set({ 'n', 'x', 'o' }, '<CS-S>', '<Plug>(leap)')
    vim.keymap.set({ 'n', 'x', 'o' }, '<C-;>', '<Plug>(leap-backward)')
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    -- vim.keymap.del({ 'x', 'o' }, 'x')
    -- vim.keymap.del({ 'x', 'o' }, 'X')
  end,
}
