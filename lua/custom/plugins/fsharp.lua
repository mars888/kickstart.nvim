-- https://github.com/ionide/ionide-vim

return {
  'ionide/ionide-vim',
  -- ft = { 'fsharp', 'fs', 'fsi', 'fsx' },
  config = function()
    -- See: https://github.com/ionide/Ionide-vim/issues/93#issuecomment-3065700345
    vim.g['fsharp#lsp_codelens'] = 0
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
      pattern = { '*.fs', '*.fsx', '*.fsi' },
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      -- buffer = 0, -- current buffer
    })
  end,

  -- 'WillEhrendreich/Ionide-Nvim',
  -- dependencies = {
  --   {
  --     -- highly recommended to use Mason. very nice for lsp/linter/tool installations.
  --     'williamboman/mason.nvim',
  --     opts = {
  --       -- here we make sure fsautocomplete is downloaded by mason, which Ionide absolutely needs in order to work.
  --       ensure_installed = {
  --         'fsautocomplete',
  --       },
  --     },
  --     {
  --       -- very recommended to use nvim-lspconfig, as it takes care of much of the management of starting Ionide,
  --       'neovim/nvim-lspconfig',
  --       version = false, -- last release is way too old
  --       opts = {
  --         servers = {
  --           ---@type IonideOptions
  --           ionide = {
  --             IonideNvimSettings = {},
  --             cmd = {
  --               vim.fs.normalize(vim.fn.stdpath 'data' .. '/mason/bin/fsautocomplete.cmd'),
  --             },
  --             settings = {
  --               FSharp = {},
  --             },
  --           },
  --         },
  --         -- you can do any additional lsp server setup here
  --         -- return true if you don't want this server to be setup with lspconfig
  --         ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --         setup = {
  --           --- ***VERY IMPORTANT***
  --           --- if you don't wan't both ionide AND fsautocomplete to
  --           ---attach themselves to every fsharp file (you don't, trust me), you
  --           --- need to make sure that fsautocomplete doesn't get its setup function called.
  --           --- from within a lazy.nvim setup it simply means that you do the following:
  --           fsautocomplete = function(_, _)
  --             return true
  --           end,
  --           --- and then pass the opts in from up above.
  --           ionide = function(_, opts)
  --             require('ionide').setup(opts)
  --           end,
  --         },
  --       },
  --     },
  --   },
  -- },
}
