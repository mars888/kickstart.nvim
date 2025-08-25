-- Originally: https://github.com/epwalsh/obsidian.nvim
-- New: https://github.coml/obsidian-nvim/obsidian.nvim
-- Use Obsidian vaults in NeoVim



return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  cmd = { 'ObsidianOpen' },
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    -- "BufReadPre path/to/my-vault/*.md",
    -- "BufNewFile path/to/my-vault/*.md",
    "BufReadPre c:/Projects/Notes/colorware_obsidian/*.md",
    "BufNewFile c:/Projects/Notes/colorware_obsidian/*.md",
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    enabled = false,

    workspaces = {
      {
        name = 'personal',
        path = 'c:\\Projects\\Notes\\colorware_obsidian',
      },
      {
        name = "no-vault",
        path = function()
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
        overrides = {
          notes_subdir = vim.NIL,
          templates = {
            folder = vim.NIL,
          },
          -- disable_frontmatter = true,
          disable_frontmatter = true,
        }
      },
    },

    templates = {
      folder = 'Templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },

    completion = {
      nvim_cmp = false,
      blink = true,
    },

    -- daily_notes = {
    --   -- folder = './1. 🗺 Areas/📝 Logs/DailyNotes/2021-01-15.md',
    --   folder = "1. 🗺 Areas\\📝 Logs\\DailyNotes"
    -- },

    follow_url_func = function(url)
      -- print('Opening URL: ' .. url)
      vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows: Open URL in default browser.
    end,
  },
}
