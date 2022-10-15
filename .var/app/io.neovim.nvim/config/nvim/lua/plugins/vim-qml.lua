local M = {}

function M.info()
  return {
    name = 'vim-qml',
    module = 'plugins.vim-qml'
  }
end

function M.register()
  return {
    'peterhoeg/vim-qml',
    config = function()
    end
  }
end

return M
