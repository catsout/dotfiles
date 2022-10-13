local M = {}
function M.register()
  return {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',

    config = function ()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'bash', 'lua',
          'c', 'cpp', 'rust', 'java',
          'python', 'scheme', 'javascript',
          'yaml', 'json', 'toml'
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { },

        highlight = {
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype.
          disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true
        },
      }
    end
  }
end

return M
