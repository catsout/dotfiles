-- basics
vim.cmd('syntax on')
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')

vim.opt.number         = true
vim.opt.relativenumber = false
vim.opt.mouse = 'nv'

vim.opt.shiftround = true
vim.opt.updatetime = 100
vim.opt.cursorline = true
vim.opt.autowrite  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- auto indent, other auto-intend-method is used through builin indent plugin
vim.opt.autoindent  = true -- uses the indent from the previous line
vim.opt.smartindent = false -- like 'autoindent' but also recognizes some C syntax

-- tabs
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = -1 -- keep same as shiftwidth
vim.opt.expandtab   = true

-- theme
vim.opt.background    = 'dark'
vim.opt.termguicolors = true

-- user cmd
vim.cmd([[
]])

-- plugin and keymap
local utils = require('lib.utils')

vim.opt.runtimepath:append(utils.ver_runtime())

local plugin_loader = require('lib.plugin-loader')

local plugin_info = require('core.plugin-info')

require('core.keymap').load()

plugin_loader:loads(plugin_info.infos)
