-- https://github.com/GustavEikaas/easy-dotnet.nvim?tab=readme-ov-file
-- Simplifying .NET development in Neovim

return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local edotnet = require 'easy-dotnet'
    edotnet.setup {
      lsp = {
        enabled = false,
      },
    }
      --   server = {
      --     log_level = 'Verbose',
      --   },
      --@type TestRunnerOptions
      test_runner = {
        mappings = {
          debug_test = { lhs = '<leader>dt', desc = 'debug test' },
        },
      },
    }

    local build = function()
      require('easy-dotnet.actions').build(nil, false)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('easy-dotnet-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end
        if client.name ~= 'roslyn' then
          return
        end
        -- Keymaps for working with dotnet:
        vim.keymap.set({ 'n', 'i' }, '<C-S-b>', build, { desc = 'Build solution' })
        vim.keymap.set({ 'n', 'i' }, '<C-S-m>', function()
          vim.cmd.make()
        end, { desc = 'Make' })
        vim.keymap.set({ 'n' }, '<leader>dr', edotnet.testrunner, { desc = 'Toggle EasyDotnet testrunner' })

        -- Set compiler:
        vim.cmd.compiler 'dotnet'
      end,
    })
  end,
}
