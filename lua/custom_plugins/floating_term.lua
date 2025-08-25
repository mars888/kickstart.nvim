---@class Keys
---@field hide? string

---@class FloatingOps
---@field width? number
---@field height? number
---@field keys? Keys

--- @type FloatingOps
local options = {
  width = nil,
  height = nil,
  keys = {
    hide = '<C-t><C-t>',
  },
}

---@class State
---@field buf? integer The terminal buffer.
local state = {
  buf = nil,
  win = nil,
}

local M = {}

function M.toggle()
  if state.win ~= nil and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    return
  end

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  if state.buf == nil or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  ---@type vim.api.keyset.win_config
  local win_opts = {
    relative = 'editor',
    col = col,
    row = row,
    width = width,
    height = height,
  }
  if state.win == nil or not vim.api.nvim_win_is_valid(state.win) then
    state.win = vim.api.nvim_open_win(state.buf, true, win_opts)
    if vim.bo[state.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    if options.keys ~= nil and options.keys.hide ~= nil then
      vim.keymap.set({ 'n', 'x', 'i', 'v' }, options.keys.hide, M.toggle, { desc = 'Hide terminal', buffer = state.buf })
      vim.keymap.set({ 'n', 'x', 'i', 'v', 't' }, '<C-`>', M.toggle, { desc = 'Toggle terminal', buffer = state.buf })
    end
    vim.cmd.startinsert()
  end
end

---@param opts table
function M.setup(opts)
  vim.keymap.set('n', '<C-`>', M.toggle, { desc = 'Toggle terminal' })
  vim.keymap.set('n', 'gut', M.toggle, { desc = 'Toggle terminal' })
end

return M
