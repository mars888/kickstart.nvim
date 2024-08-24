-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ TreeSitter bindings ]]
vim.keymap.set('n', '[C', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { desc = 'Jump to TreeSitter context' })

-- [[ Quickfix keymaps ]]
vim.keymap.set({ 'i', 'n' }, '<C-S-k>', '<cmd>cnext<CR>', { desc = 'Move to next quick fix item' })
vim.keymap.set({ 'i', 'n' }, '<C-S-j>', '<cmd>cprev<CR>', { desc = 'Move to previous quick fix item' })

vim.keymap.set({ 'i', 'n' }, '<C-S-h>', '<cmd>cabove<CR>', { desc = 'Move to next quick fix item' })
vim.keymap.set({ 'i', 'n' }, '<C-S-l>', '<cmd>cbelow<CR>', { desc = 'Move to previous quick fix item' })

-- [[ Convenciency keymaps ]]
vim.keymap.set('n', '<leader>eh', '<cmd>edit %:h<CR>', { desc = 'Edit here' })
vim.keymap.set('n', '<leader>ew', function()
  local pwd = vim.fn.getcwd()
  vim.cmd { cmd = 'edit', args = { pwd }}
end, { desc = 'Edit workspace' })

-- [[ Custom command bindings ]]
-- Setup command to open LazyGit.
vim.keymap.set('n', '<leader>hl', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit for current context' })

-- Setup command to copy path of current buffer.
vim.keymap.set('n', '<leader>yp', '<cmd>CopyPath<CR>', { desc = 'Copy path of current buffer' })

-- [[ Workspace commands for workspaces.nvim ]]
vim.keymap.set('n', '<leader>wo', '<cmd>WorkspacesOpen<CR>', { desc = 'Open workspace' })
