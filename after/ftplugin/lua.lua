vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true

vim.keymap.set('n', '<leader>ce', ':.lua<CR>', { desc = 'Evaluate Lua', buffer = true })
vim.keymap.set('v', '<leader>ce', ':lua<CR>', { desc = 'Evaluate Lua selection', buffer = true })

