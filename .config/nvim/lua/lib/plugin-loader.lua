local PluginLoader = {}
local utils = require('lib.utils')

---@class Plugin
---@field name   string
---@field keymap table
---@field module string


local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end


function PluginLoader:init()
  vim.opt.runtimepath:append(utils.ver_runtime())

  ensure_packer()
  self.packer = require('packer')
  self.packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    },
    compile_path = utils.ver_runtime() .. '/plugin/packer_compiled.lua'
  }

  return self
end

function PluginLoader:loads(plugs_info)
  -- lazy load
  self.packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    for _, p_info in pairs(plugs_info) do
      use(require(p_info.module).register(p_info))
    end
  end)

  -- non lazy setup
  for _, p_info in pairs(plugs_info) do
    local m = require(p_info.module)
    if m.setup then m.setup(p_info) end
  end

  return self
end

return PluginLoader:init()
