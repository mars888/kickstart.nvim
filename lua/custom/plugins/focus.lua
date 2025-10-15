-- https://github.com/cdmill/focus.nvim
-- Focus on areas of code/Zen Mode

local function toggle_narrow()
  local focus = require 'focus'
  local narrow = require 'focus.views.narrow'
  local mode = vim.api.nvim_get_mode().mode

  if narrow.is_active() then
    narrow.unfocus()
    return
  end

  -- If not in selection mode:
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then
    vim.cmd 'normal vai'
  end

  mode = vim.api.nvim_get_mode().mode
  -- If selection mode:
  if mode == 'v' or mode == 'V' or mode == '\22' then
    local start_pos = vim.fn.getpos 'v'
    local end_pos = vim.fn.getpos '.'
    focus.toggle_narrow {
      line1 = start_pos[2],
      line2 = end_pos[2],
    }
    vim.api.nvim_feedkeys('', 'n', false)
  else
    print 'Could not narrow'
  end
end

return {
  'cdmill/focus.nvim',
  cmd = { 'Focus', 'Zen', 'Narrow' },
  opts = {},
  keys = {
    { '<leader>tn', mode = { 'n', 'v' }, toggle_narrow, desc = 'Toggle Narrow' },
  },
}
