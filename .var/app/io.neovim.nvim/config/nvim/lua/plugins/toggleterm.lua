local M = {}

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
