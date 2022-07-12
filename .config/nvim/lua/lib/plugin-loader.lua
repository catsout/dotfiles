local PluginLoader = {}

function PluginLoader:init()
  vim.cmd("packadd packer.nvim")
  self.packer = require('packer')
  self.packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }

  return self
end

function PluginLoader:loads(m_pathes, context)
  local m_objs = vim.tbl_map(function(p) return require(p) end, m_pathes)
  -- require lazy load
  self.packer.startup(function (use)
    use 'wbthomason/packer.nvim'

    for _,m in ipairs(m_objs) do
      use(m.register())
    end
  end)

  for _,m in ipairs(m_objs) do
    if m.config then m.config(context) end
  end

  return self
end

return PluginLoader:init()
