-- SmiteshP/nvim-navic
-- Shows code context/breadcrumbs

return {
  'SmiteshP/nvim-navic',
  opts = {
    lsp = {
      auto_attach = true,
    }
  },
  init = function(_, _opts)
    -- TODO

    -- print("Loading Navic")
    -- local navic = require 'nvim-navic'
    -- local on_attach = function(client, bufnr)
    --   print("on_attach")
    --   --if client.server_capabilities.documentSymbolProider then
    --     print("on_attach inner")
    --     navic.attach(client, bufnr)
    --   --end
    -- end
    --
    -- local lspconfig = require('lspconfig')
    -- lspconfig.lua_ls.setup {
    --   on_attach = on_attach,
    -- }
  end,
}
