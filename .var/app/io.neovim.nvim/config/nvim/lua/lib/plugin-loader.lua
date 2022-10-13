local PluginLoader = {}

function PluginLoader:init()
  local ver_runtime = vim.fn.stdpath('config') .. '/ver/' .. vim.version().major .. vim.version().minor
  vim.opt.runtimepath:append(ver_runtime)

  vim.cmd("packadd packer.nvim")
  self.packer = require('packer')
  self.packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    },
    compile_path = ver_runtime .. '/plugin/packer_compiled.lua'
  }

  return self
end

function PluginLoader:loads(m_pathes, context)
  local m_objs = vim.tbl_map(function(p) return require(p) end, m_pathes)
  -- require lazy load
  self.packer.startup(function (use)
    use 'wbthomason/packer.nvim'

    for _,m in ipairs(m_objs) do
      use(m.register(context))
    end
  end)

  -- load non lazy setup
  for _,m in ipairs(m_objs) do
    if m.setup then m.setup(context) end
  end

  return self
end

return PluginLoader:init()
