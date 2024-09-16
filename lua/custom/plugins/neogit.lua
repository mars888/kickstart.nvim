-- NeoGit
-- https://github.com/NeogitOrg/neogit
-- Git interface for NeoVim

return {
  "NeogitOrg/neogit",
  lazy = true,
  cmd = {
    'Neogit'
  },
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
  },
  config = true
}
