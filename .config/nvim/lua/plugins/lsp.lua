local M = {}
 
---@class Plugin.lsp.keymap
---@field declaration Array<string>
---@field definition  Array<string>
---@field references  Array<string>
---@field hover       Array<string>
---@field help        Array<string>
---@field rename      Array<string>
---@field formatting  Array<string>
---@field implementation Array<string>
 
function M.info()
  return {
    name = 'mason-lspconfig.nvim',
    ---@type Plugin.lsp.keymap
    keymap = {},
    module = 'plugins.lsp',
    fullname = 'mason-org/mason-lspconfig.nvim',
    requires = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
  }
end
 
function M.register(info)
  require('lib.kmap').dump_cfg(info.module, info.keymap)
 
  return {
    info.fullname,
    requires = info.requires,
    config = function()
      require('mason').setup()
 
      local cfgs = {
        qmlls = {
          filetypes = { 'qmljs', 'qml' }
        },
        lua_ls = {
          settings = {
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
        },
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixfmt" } }
            }
          }
        },
        yamlls = {
          settings = {
            redhat = {
              telemetry = {
                enabled = false
              }
            }
          }
        }
      }
 
      local kmap = require('lib.kmap').domap
 
      ---@type Plugin.lsp.keymap | nil
      local keys = require('lib.kmap').load_cfg('plugins.lsp')
      ---@type Kmap.opts
      local opts = { 'silent' }
 
      local format = function()
        vim.lsp.buf.format { async = true }
      end
 
      local on_attach = function(client, buf)
        if not keys then return end
        kmap.nraw(keys.declaration, vim.lsp.buf.declaration, opts, buf)
        kmap.nraw(keys.definition, vim.lsp.buf.definition, opts, buf)
        kmap.nraw(keys.references, vim.lsp.buf.references, opts, buf)
        kmap.nraw(keys.implementation, vim.lsp.buf.implementation, opts, buf)
        kmap.nraw(keys.hover, vim.lsp.buf.hover, opts, buf)
        kmap.nraw(keys.help, vim.lsp.buf.signature_help, opts, buf)
        -- action
        kmap.nraw(keys.rename, vim.lsp.buf.rename, opts, buf)
        kmap.nraw(keys.formatting, format, opts, buf)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup_server(server_name)
        vim.lsp.config[server_name] = vim.tbl_extend('keep', cfgs[server_name] or {}, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end


      local auto_install = {
        'ts_ls',  'lua_ls',
        'pyright', 'yamlls', 'jsonls'
      }
      local all = vim.list_extend(vim.list_slice(auto_install), {
        'cmake', 'clangd', 'rust_analyzer'
      })
 
      require('mason-lspconfig').setup({
        ensure_installed = auto_install,
        automatic_enable = all,
        automatic_installation = true,
      })

      for _, server_name in ipairs(all) do
        setup_server(server_name)
      end
    end
  }
end
 
return M
