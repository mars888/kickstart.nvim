-- https://github.com/stevearc/conform.nvim
-- Formatter plugin

return {
  'stevearc/conform.nvim',

  -- event = { "BufWritePre" },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>cf',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format buffer using conform',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      -- lua = { "stylua" },
      -- python = { "isort", "black" },
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      xml = { 'xmllint' },
      xsd = { 'xmllint' },
    },
    -- Set default options
    -- default_format_opts = {
    --   lsp_format = 'fallback',
    -- },
    -- Set up format-on-save
    -- format_on_save = { timeout_ms = 500 },
    format_on_save = function(_bufnr) end,
    -- Customize formatters
    formatters = {
      -- shfmt = {
      --   prepend_args = { '-i', '2' },
      -- },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
