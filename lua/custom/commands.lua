local separator = '\\'
local wezterm_location = 'C:\\Program Files\\WezTerm\\wezterm.exe'

--- Remove last part from a path string.
--- @param dir_to_remove_from string
--- @return string
local remove_last_path_part = function(dir_to_remove_from)
  -- Remove any trailing slash
  if dir_to_remove_from:find '[/\\]$' then
    dir_to_remove_from = dir_to_remove_from:sub(1, -2)
  end
  local last_slash = dir_to_remove_from:find '[^/\\]*$'
  return dir_to_remove_from:sub(1, last_slash - 1)
end

--- Determines if given dir contains a .git sub directory.
--- @param test_for_git_dir string
--- @return boolean|nil
local is_git_dir = function(test_for_git_dir)
  local maybe_git_dir = test_for_git_dir .. separator .. '.git'
  local stat = vim.uv.fs_stat(maybe_git_dir)
  return stat and stat.type == 'directory'
end

---Try to walk up the directory tree given by dir until a directory with a .git subdir has been found
---return thit directory if found, otherwise produce and error.
---@param dir string
---@return string
local function find_git_repo_dir_starting_from(dir)
  -- Check that current dir is actually a directory.
  local stat = vim.uv.fs_stat(dir)
  -- print("CHECKING '" .. dir .. "'")
  if not stat or stat.type ~= 'directory' then
    error 'Could not determine directory with ".git" from current file'
  end

  if is_git_dir(dir) then
    -- print("FOUND GIT DIR @ " .. dir)
    return dir
  else
    local one_dir_up = remove_last_path_part(dir)
    -- print("Could not find git dir, trying next: " .. one_dir_up)
    return find_git_repo_dir_starting_from(one_dir_up)
  end
end

---Start LazyGit via WezTerm.
local function start_lazy_git()
  local buffer = vim.api.nvim_get_current_buf()
  local buf_path = vim.api.nvim_buf_get_name(buffer)
  local dir = vim.fn.fnamemodify(buf_path, ':h')
  local git_dir = find_git_repo_dir_starting_from(dir)
  local cmd = { wezterm_location, 'start', 'lazygit', '-p', git_dir }
  vim.system(cmd, { detach = true })
end

local function yank_current_path_clipboard()
  local path = vim.fn.expand("%")
  vim.fn.setreg("*", path)
  vim.notify('Copied "' .. path .. '" to the clipboard')
end

vim.api.nvim_create_user_command('LazyGit', start_lazy_git, {})

vim.api.nvim_create_user_command('CopyPath', yank_current_path_clipboard, {})
