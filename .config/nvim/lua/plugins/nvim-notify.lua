local M = {}

---@class Plugin.nvim-notify.keymap


function M.info()
  return {
    name = 'nvim-notify',
    module = 'plugins.nvim-notify',
    ---@type Plugin.nvim-tree.keymap
    keymap = {},
    fullname = 'rcarriga/nvim-notify',
  }
end

function M.setup(info)
  require('notify').setup {}
end

function M.register(info)
  return {
    info.fullname,
  }
end

return M
