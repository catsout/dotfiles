local M = {}

function M.info()
  return {
    name = 'nvim-notify',
    module = 'plugins.nvim-notify',
    fullname = 'rcarriga/nvim-notify',
  }
end

function M.setup(info)
end

function M.register(info)
  return {
    info.fullname,
  }
end

return M
