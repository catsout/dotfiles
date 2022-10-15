local M = {}


function M.info()
  return {
    name = 'toggleterm.nvim',
    module = 'plugins.toggleterm'
  }
end


function M.register()
  return {
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
    config = function ()
      require("toggleterm").setup()
    end
  }
end

return M
