local M = {}

function M.register()
  return {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },

    config = function ()
      require('lualine').setup {}
    end
  }
end

return M
