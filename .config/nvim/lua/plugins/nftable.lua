local M = {}

function M.info()
  return {
    name = 'vim-nftables',
    module = 'plugins.nftable'
  }
end


function M.register()
  return {
    'nfnty/vim-nftables',
    config = function ()
    end
  }
end

return M
