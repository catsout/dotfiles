local M = {}

function M.setup()
  require('nvim-tree').setup {}
end

function M.register()
  return {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end

return M
