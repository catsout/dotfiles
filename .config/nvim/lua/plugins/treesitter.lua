local M = {}

function M.info()
  return {
    name = 'nvim-treesitter',
    module = 'plugins.treesitter'
  }
end

function M.register()
  vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/treesitter')
  return {
    'nvim-treesitter/nvim-treesitter',
    --- { 'nvim-treesitter/playground', opt = false },
    run = ':TSUpdate',

    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'bash', 'lua', 'query', 'nix',
          'c', 'cpp', 'rust', 'java',
          'python', 'scheme', 'javascript',
          'yaml', 'json', 'toml'
        },

        parser_install_dir = vim.fn.stdpath('data') .. '/treesitter',

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},

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

        playground = {
          enable = false,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }
end

return M
