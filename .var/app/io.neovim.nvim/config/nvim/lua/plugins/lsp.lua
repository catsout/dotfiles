local M = {}

function M.register()
  return {
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/nvim-lsp-installer'
      --      {'ms-jpq/coq.thirdparty'}
    },

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

      local buf_map_op = require('core.keymaps').lsp_bufmap

      require('nvim-lsp-installer').setup {
        automatic_installation = true
      }

      local on_attach = function(client, bufnr)
        buf_map_op(bufnr)
      end

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      local lspconfig = require('lspconfig')
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          settings = settings[lsp],
          capabilities =  capabilities
        })
      end
    end
  }
end

return M
