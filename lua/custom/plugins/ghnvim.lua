-- https://github.com/ldelossa/gh.nvim
-- Plugin for interactive code reviews on GitHub

return {
  'ldelossa/gh.nvim',
  dependencies = {
    {
      'ldelossa/litee.nvim',
      config = function()
        require('litee.lib').setup()
      end,
    },
  },
  config = function()
    require('litee.gh').setup()
  end,
}
