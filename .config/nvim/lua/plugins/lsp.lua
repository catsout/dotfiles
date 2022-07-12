local M = {}

function M.register()
  return {
    'neovim/nvim-lspconfig',
    requires = {
      {'ms-jpq/coq_nvim', branch = 'coq'},
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
                globals = {'vim'},
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

      vim.g.coq_settings = {
        auto_start = 'shut-up',
        clients = {
          snippets = { warn = {}}
        }
      }
      local coq = require('coq')
      local buf_map_op = require('core.keymaps').lsp_bufmap

      require('nvim-lsp-installer').setup {
        automatic_installation = true
      }

      local on_attach = function (client, bufnr)
        buf_map_op(bufnr)
      end

      for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities({
          on_attach = on_attach,
          settings = settings[lsp]
        }))
      end
    end
  }
end

return M
