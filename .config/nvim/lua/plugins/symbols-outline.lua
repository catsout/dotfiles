local M = {}

---@class Plugin.sym.keymap
---@field toggle         Key
---@field close          Key
---@field goto_location  Key
---@field focus_location Key
---@field hover_symbol   Key
---@field toggle_preview Key
---@field rename_symbol  Key
---@field code_actions   Key
---@field fold       Key
---@field unfold     Key
---@field fold_all   Key
---@field unfold_all Key
---@field fold_reset Key

function M.info()
  return {
    name = 'symbols-outline.nvim',
    module = 'plugins.symbols-outline',
    fullname = 'simrat39/symbols-outline.nvim',
    ---@type Plugin.sym.keymap
    keymap = {},
  }
end

function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)
  local kmap = require('lib.kmap').domap
  kmap.ncmd(info.keymap.toggle, 'SymbolsOutline')

  return {
    info.fullname,

    config = function()
      require('symbols-outline').setup {
        {
          highlight_hovered_item = true,
          show_guides = true,
          auto_preview = false,
          position = 'right',
          relative_width = true,
          width = 25,
          auto_close = false,
          show_numbers = false,
          show_relative_numbers = false,
          show_symbol_details = true,
          preview_bg_highlight = 'Pmenu',
          autofold_depth = nil,
          auto_unfold_hover = true,
          fold_markers = { '', '' },
          wrap = false,
          keymaps = require('lib.kmap').load_cfg('plugins.symbols-outline'),
          lsp_blacklist = {},
          symbol_blacklist = {},
        }
      }
    end
  }
end

return M
