-- https://github.com/rcarriga/nvim-dap-ui
-- A UI for nvim-dap which provides a good out of the box configuration.

return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    dapui.setup()

    vim.keymap.set('n', '<leader>dd', dapui.toggle, { desc = 'Toggle DAP UI' })
    vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Evaluate expression' })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
