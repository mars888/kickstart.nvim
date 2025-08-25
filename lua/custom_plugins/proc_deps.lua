local M = {}

---@class FoundItem
---@field project string
---@field dll string
---@field version1 string
---@field version2 string

local OK = 'ok'
local ERROR = 'error'
local NS_ID = vim.api.nvim_create_namespace 'proc_deps'

vim.api.nvim_set_hl(0, OK, { fg = '#00FF00', bold = true })
vim.api.nvim_set_hl(0, ERROR, { fg = '#FF0000', bold = true })

-- local function append_to_buffer(buf, text)
--   local line_count = vim.api.nvim_buf_line_count(buf) - 1 -- Buffers are 0 based?
--   vim.api.nvim_buf_set_lines(buf, line_count, line_count, true, { text })
-- end

local function append_to_buffer(buf, text, hl_group)
  local lines = {}
  for line in text:gmatch '[^\r\n]+' do
    table.insert(lines, line)
  end
  vim.schedule(function()
    local line_count = vim.api.nvim_buf_line_count(buf) - 1 -- Buffers are 0 based?
    vim.api.nvim_buf_set_lines(buf, line_count, line_count, true, lines)
    if hl_group then
      vim.api.nvim_buf_set_extmark(buf, NS_ID, line_count, 0, {
        hl_group = hl_group,
        end_line = line_count + #lines - 1,
        end_col = #lines[#lines],
        hl_eol = true,
      })
    end
  end)
end

---@param items FoundItem[]
local function process_items(items)
  local output_buf = vim.api.nvim_create_buf(true, true)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, output_buf)

  append_to_buffer(output_buf, 'Processing #' .. #items .. ' items', OK)
  for i, item in ipairs(items) do
    append_to_buffer(output_buf, i .. ': ' .. item.version1 .. ' -> ' .. item.version2 .. ' : ' .. item.project .. ' [' .. item.dll .. ']')
  end

  append_to_buffer(output_buf, '')
  append_to_buffer(output_buf, 'Starting processing...', OK)

  local i_current = 1

  local function process_next()
    if i_current > #items then
      append_to_buffer(output_buf, 'All done!', OK)
      return
    end

    local current_item = items[i_current]

    append_to_buffer(output_buf, 'Starting item ' .. i_current .. '/' .. #items .. ': ' .. current_item.project .. ': ' .. current_item.dll)
    vim.system({
      'dotnet',
      'paket',
      'add',
      '--project',
      current_item.project,
      current_item.dll,
      -- 'dotnet',
      -- '--help',
    }, {
      text = true,
      stdout = function(err, data)
        if err then
          append_to_buffer(output_buf, 'Error: ' .. err, ERROR)
        elseif data and #data > 0 then
          append_to_buffer(output_buf, data)
        else
          append_to_buffer(
            output_buf,
            'Updated: ' .. i_current .. '/' .. #items .. current_item.project .. ': ' .. current_item.dll .. ' (' .. current_item.version1 .. ' => ' .. current_item.version2 .. ')',
            OK
          )
        end
      end,
      stderr = function(err, data)
        if err then
          append_to_buffer(output_buf, 'Error: ' .. err, ERROR)
        elseif data and #data > 0 then
          append_to_buffer(output_buf, 'Stderr: ' .. data, ERROR)
        end
      end,
    }, function()
      i_current = i_current + 1
      process_next()
    end)
  end

  process_next()
end

function M.test()
  local buffer = vim.api.nvim_get_current_buf()
  local last_line = vim.api.nvim_buf_line_count(buffer)
  vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, last_line, true)

  ---@type FoundItem[]
  local found_items = {}
  for _, line in ipairs(vim.api.nvim_buf_get_lines(buffer, 0, last_line, true)) do
    if line:match 'MSB3277: There was a conflict between' then
      ---
      ---@type string
      local project = line:match '%[.+%]'
      project = project:sub(2, #project - 1)

      local dll = line:match '"[%a.]+,'
      dll = dll:sub(2, #dll - 1)
      print('dll' .. dll)

      local versions = line:gmatch 'Version=[%d.]+'
      local version1 = versions():match '[%d.]+'
      local version2 = versions():match '[%d.]+'
      -- print(i .. ' project: ' .. project)
      found_items[#found_items + 1] = {
        project = project,
        dll = dll,
        version1 = version1,
        version2 = version2,
      }
    end
  end

  -- local test_items = { found_items[1], found_items[2], found_items[3] }

  process_items(found_items)

  -- for i, entry in ipairs(found_items) do
  --   local pr = entry.project:match '[%a%.]+.csproj' or entry.project:match '[%a%.]+.fsproj'
  --   local line = (pr or entry.project) .. ': ' .. entry.dll .. ' (' .. entry.version1 .. ' => ' .. entry.version2 .. ')'
  --
  --   -- dotnet paket add --project Colorware.Server.Base Microsoft.Extensions.Logging.Abstractions
  --   -- local update_cmd = 'dotnet paket add --project "' .. entry.project .. '" ' .. entry.dll
  --   -- line = update_cmd
  --
  --   -- local line = entry.dll
  --   -- vim.api.nvim_buf_set_lines(new_buf, i-1, i-1, true, { [1] = line })
  --   print('Running paket add for ' .. line)
  --   local sys_call = vim.system({ 'dotnet', 'paket', 'add', '--project', entry.project, entry.dll }, {
  --     text = true,
  --     stdout = function(err, data)
  --       if err then
  --         vim.api.nvim_buf_set_lines(new_buf, i - 1, i - 1, true, { [1] = 'Error: ' .. err })
  --       elseif data and #data > 0 then
  --         vim.api.nvim_buf_set_lines(new_buf, i - 1, i - 1, true, { [1] = data })
  --       else
  --         vim.api.nvim_buf_set_lines(new_buf, i - 1, i - 1, true, { [1] = 'Updated: ' .. line })
  --       end
  --     end,
  --     stderr = function(err, data)
  --       if err then
  --         vim.api.nvim_buf_set_lines(new_buf, i - 1, i - 1, true, { [1] = 'Error: ' .. err })
  --       elseif data and #data > 0 then
  --         vim.api.nvim_buf_set_lines(new_buf, i - 1, i - 1, true, { [1] = 'Stderr: ' .. data })
  --       end
  --     end,
  --   })
  --   sys_call:wait()
  -- end
end

-- lua vim.keymap.set('n', '<leader>i', function() package.loaded['custom_plugins.proc_deps'] = nil require('custom_plugins.proc_deps').test() end, { desc = 'Testing stuff' })

return M
