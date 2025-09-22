local wezterm_location = 'C:\\Program Files\\WezTerm\\wezterm.exe'

local augroup = vim.api.nvim_create_augroup('presenterm', { clear = true })

local function runPresentermCommand(args)
  -- print(vim.inspect(args))
  local buffer = vim.api.nvim_get_current_buf()
  local buf_path = vim.api.nvim_buf_get_name(buffer)
  local cmd = { wezterm_location, 'start', 'presenterm.exe', buf_path }
  if args.args == 'notes' then
    -- Insert --publish-speaker-notes at the end of the command:
    table.insert(cmd, '--publish-speaker-notes')
  end
  vim.system(cmd, { detach = true })

  if args.args == 'notes' then
    local cmd2 = { wezterm_location, 'start', 'presenterm.exe', '--listen-speaker-notes', buf_path }
    vim.system(cmd2, { detach = true })
  end
end

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.md' },
  group = augroup,
  callback = function(ev)
    vim.api.nvim_buf_create_user_command(ev.buf, 'Presenterm', runPresentermCommand, {
      force = true,
      desc = 'Run presenterm presentation',
      nargs = '?',
      ---@diagnostic disable-next-line: unused-local
      complete = function(argLead, cmdLine, cursorPos)
        return { 'start', 'notes' }
      end,
    })
  end,
})

print 'EVALUATED!'
