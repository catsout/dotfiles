-- basics
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.termguicolors   = true
vim.opt.shiftround      = true
vim.opt.updatetime      = 100
vim.opt.cursorline      = true
vim.opt.autowrite       = true
vim.opt.ignorecase      = true
vim.opt.smartcase       = true

-- auto indent, other auto-intend-method is used through builin indent plugin
vim.opt.autoindent      = false -- uses the indent from the previous line
vim.opt.smartindent     = false -- like 'autoindent' but also recognizes some C syntax

-- tabs
vim.opt.tabstop         = 4
vim.opt.softtabstop     = -1   -- keep same as shiftwidth
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true

-- user cmd
vim.cmd([[
]])

-- plugin and keymap
local kmap = require('core.keymaps')

local plugin_context = {
  kmap = kmap
}
require('lib.plugin-loader'):loads ({
  'plugins.lsp',
  'plugins.treesitter',
  'plugins.lualine',
  'plugins.nvim-tree',
  'plugins.toggleterm',
  'plugins.vim-qml',
  'plugins.nftable',
  'plugins.gitsigns'
}, plugin_context)

kmap.setup()

-- disable some useless standard plugins to save startup time
-- these features have been better covered by plugins
-- vim.g.loaded_matchparen        = 1
-- vim.g.loaded_matchit           = 1
-- vim.g.loaded_logiPat           = 1
-- vim.g.loaded_rrhelper          = 1
-- vim.g.loaded_tarPlugin         = 1
-- vim.g.loaded_gzip              = 1
-- vim.g.loaded_zipPlugin         = 1
-- vim.g.loaded_2html_plugin      = 1
-- vim.g.loaded_shada_plugin      = 1
-- vim.g.loaded_spellfile_plugin  = 1
-- vim.g.loaded_netrw             = 1
-- vim.g.loaded_netrwPlugin       = 1
-- vim.g.loaded_tutor_mode_plugin = 1
-- vim.g.loaded_remote_plugins    = 1
