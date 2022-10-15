local M = {}

---@class Plugin.lsp.keymap
---@field declaration Array<string>
---@field definition  Array<string>
---@field references  Array<string>
---@field hover       Array<string>
---@field help        Array<string>
---@field rename      Array<string>
---@field formatting  Array<string>


function M.info()
  return {
    name = 'nvim-lspconfig',
    ---@type Plugin.lsp.keymap
    keymap = {},
    module = 'plugins.lsp',
    fullname = 'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/nvim-lsp-installer'
      --      {'ms-jpq/coq.thirdparty'}
    },

  }
end

function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)

  return {
    info.fullname,
    requires = info.requires,

    config = function()
      local servers = { 'clangd', 'sumneko_lua', 'cmake', 'pyright' }
      local settings = {
        sumneko_lua = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }

      require('nvim-lsp-installer').setup {
        automatic_installation = true
      }

      local kmap = require('lib.kmap').domap

      ---@type Plugin.lsp.keymap | nil
      local keys = require('lib.kmap').load_cfg('plugins.lsp')
      local opts = { 'noremap' }
      local on_attach = function(client, buf)
        if not keys then return end
        kmap.nraw(keys.declaration, vim.lsp.buf.declaration, opts, buf)
        kmap.nraw(keys.definition, vim.lsp.buf.definition, opts, buf)
        kmap.nraw(keys.references, vim.lsp.buf.references, opts, buf)
        kmap.nraw(keys.hover, vim.lsp.buf.hover, opts, buf)
        kmap.nraw(keys.help, vim.lsp.buf.signature_help, opts, buf)
        -- action
        kmap.nraw(keys.rename, vim.lsp.buf.rename, opts, buf)
        kmap.nraw(keys.formatting, vim.lsp.buf.formatting, opts, buf)
      end

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      local lspconfig = require('lspconfig')
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          settings = settings[lsp],
          capabilities = capabilities
        })
      end
    end
  }
end

return M
