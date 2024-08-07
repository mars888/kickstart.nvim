-- https://github.com/epwalsh/obsidian.nvim
-- Use Obsidian vaults in NeoVim

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { 'ObsidianOpen' },
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = 'c:\\Projects\\Notes\\colorware_obsidian',
      },
    },

    follow_url_func = function(url)
      -- print('Opening URL: ' .. url)
      vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows: Open URL in default browser.
    end,
  },

  ---@param url string
}
