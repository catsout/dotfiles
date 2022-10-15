local M = {}

---@class Plugin.nvim-tree.keymap
---@field toggle  Array<string>
---@field refresh Array<string>


function M.info()
  return {
    name = 'nvim-tree.lua',
    module = 'plugins.nvim-tree',
    ---@type Plugin.nvim-tree.keymap
    keymap = {},
    fullname = 'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end

function M.setup(info)
  require('nvim-tree').setup {}
  local kmap = require('lib.kmap').domap
  ---@type Plugin.nvim-tree.keymap
  local keys = info.keymap
  kmap.ncmd(keys.toggle, 'NvimTreeToggle', { 'noremap' })
  kmap.ncmd(keys.refresh, 'NvimTreeRefresh', { 'noremap' })
end

function M.register(info)
  return {
    info.fullname,
    requires = info.requires
  }
end

return M
