local M = {}
local utils = require('lib.utils')

---@class Plugin.nvim-cmp.keymap
---@field scroll_forward Array<string>
---@field scroll_back    Array<string>
---@field abort          Array<string>
---@field confirm        Array<string>
---@field complete       Array<string>
---@field next_item      Array<string>
---@field prev_item      Array<string>

function M.info()
  return {
    name = 'nvim-cmp',
    ---@type Plugin.nvim-cmp.keymap
    keymap = {},
    module = 'plugins.nvim-cmp',
    fullname = 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    after = 'nvim-lspconfig',
  }
end

function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)
  return {
    info.fullname,
    requires = info.requires,
    after = info.after,
    config = function()
      local cmp = require('cmp');
      local utils = require('lib.utils')

      local gen_mapping = function(keymap)
        local maps = {}

        local domap = function(keys, mapping)
          if not keys then return end
          if not vim.islist(keys) then keys = { keys } end
          for _, k in ipairs(keys) do
            maps[k] = mapping
          end
        end

        if keymap then
          domap(keymap.scroll_forward, cmp.mapping.scroll_docs(4))
          domap(keymap.scroll_back, cmp.mapping.scroll_docs(-4))
          domap(keymap.abort, cmp.mapping.abort())
          domap(keymap.complete, cmp.mapping.complete())
          domap(keymap.next_item, cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }))
          domap(keymap.prev_item, cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }))
        end
        return maps
      end

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert(
          gen_mapping(require('lib.kmap').load_cfg('plugins.nvim-cmp'))
        ),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          {
            name = 'path',
            trigger_characters = { '.', '/' }
          }
        }, {
          { name = 'buffer' }
        }),
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }
end

return M
