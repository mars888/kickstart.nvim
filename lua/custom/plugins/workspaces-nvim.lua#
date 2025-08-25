-- https://github.com/natecraddock/workspaces.nvim
-- Workspace management

return {
  'natecraddock/workspaces.nvim',
  opts = {
    path = vim.fn.stdpath 'data' .. '/workspaces',
    cd_type = 'global',
    sort = true,
    mrp_sort = true,
    auto_open = false,
    auto_dir = true,
    notify_info = true,
    hooks = {
      -- add = {},
      -- remove = {},
      -- rename = {},
      -- open_pre = {},
      open = { "Telescope find_files" },
    },
  },
  -- config = function(_, opts) end,
}
