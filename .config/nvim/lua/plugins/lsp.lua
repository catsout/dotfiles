local M = {}

function M.register()
  return {
    'neovim/nvim-lspconfig',
    requires = {
      { 'ms-jpq/coq_nvim', branch = 'coq' },
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
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        display = {
          pum = {
            fast_close = false
          }
        },
        weights = {
          prefix_matches = 9.0,
          edit_distance = 10.0,
          -- Relative weight adjustment of recently inserted items.
          recency = 5.0,
          proximity = 5.0,
        },
        clients = {
          -- weight: [-2, 2]
          lsp = {
            enabled = true,
            weight_adjust = 1.8,
            resolve_timeout = 0.5
          },
          snippets = {
            enabled = true,
            weight_adjust = 1.2
          },
          tree_sitter = {
            enabled = false,
            weight_adjust = 0.5
          },
          buffers = {
            enabled = false,
            weight_adjust = -2.00, -- doesn't help that much
          },
          tags = {
            enabled = true,
            weight_adjust = -1.00
          }
        }
      }
      local coq = require('coq')
      local lspconfig = require('lspconfig')
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
          on_attach = on_attach,
          settings = settings[lsp]
        }))
      end
    end
  }
end

return M
