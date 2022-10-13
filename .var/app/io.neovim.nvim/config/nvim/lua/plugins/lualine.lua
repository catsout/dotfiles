local M = {}

function M.register(cnt)
  return {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    after = cnt.color.plugin,
    config = function ()
      require('lualine').setup {
      }
    end
  }
end

return M
