-- https://github.com/echasnovski/mini.files
-- Mini files explorer.

local function open_with_system()
  local mini = require 'mini.files'
  local path = (mini.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on a valid entry'
  end
  print(path)
  vim.ui.open(path)
end

local function toggle_preview()
  local mini = require 'mini.files'
  mini.config.windows.preview = not mini.config.windows.preview
  mini.refresh {}
end

local function cd_to_directory()
  local mini = require 'mini.files'
  local path = (mini.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on a valid entry'
  end
  -- Remove last path entry:
  path = vim.fn.resolve(path .. '/..')

  mini.close()
  vim.cmd.cd(path)
  mini.open(path, false)
end

-- local function location_of_current_buffer()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local path = vim.api.nvim_buf_get_name(bufnr)
--   print('BUFFER: ' .. path)
--   if path == '' then
--     return nil
--   end
--   return vim
-- end

local function open_in_new_tab()
  local mini = require 'mini.files'
  local path = (mini.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on a valid entry'
  end
  mini.close()
  vim.cmd.tabnew(path)
end

local function open_in_split()
  local mini = require 'mini.files'
  local path = (mini.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on a valid entry'
  end
  mini.close()
  vim.cmd.split(path)
end

local function open_in_vsplit()
  local mini = require 'mini.files'
  local path = (mini.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on a valid entry'
  end
  mini.close()
  vim.cmd.vsplit(path)
end

return {
  'echasnovski/mini.files',
  version = '*',

  keys = {
    {
      'g\\',
      function()
        local mini = require 'mini.files'
        if not mini.close() then
          mini.open()
        end
      end,
      desc = 'Open Mini Files',
    },
    {
      '\\',
      function()
        local mini = require 'mini.files'
        if not mini.close() then
          mini.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = 'Open Mini Files in context',
    },
  },

  config = function(_)
    require('mini.files').setup {
      windows = {
        preview = true,
        width_preview = 75,
      },
    }

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id

        -- User actions:
        vim.keymap.set('n', 'go', open_with_system, { buffer = b, desc = 'OS open' })
        vim.keymap.set('n', 'gp', toggle_preview, { buffer = b, desc = 'Toggle preview' })
        vim.keymap.set('n', 'gh', cd_to_directory, { buffer = b, desc = 'Change root ([G]o [H]ere)' })
        vim.keymap.set('n', '<C-s>', open_in_split, { buffer = b, desc = 'Split horizontal' })
        vim.keymap.set('n', '<C-v>', open_in_vsplit, { buffer = b, desc = 'Split vertical' })
        vim.keymap.set('n', '<C-t>', open_in_new_tab, { buffer = b, desc = 'Open in new tab' })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        local mini = require 'mini.files'

        -- User bookmarks:
        mini.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
        -- mini.set_bookmark('.', location_of_current_buffer, { desc = 'Current open buffer' })
      end,
    })
  end,
}
