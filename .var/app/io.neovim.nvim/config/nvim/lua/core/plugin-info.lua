local M = {}

M.infos = {
  nightfox   = require('plugins.color.nightfox').info(),

  lsp        = require('plugins.lsp').info(),
  cmp        = require('plugins.nvim-cmp').info(),
  ts         = require('plugins.treesitter').info(),
  lualing    = require('plugins.lualine').info(),
  nvim_tree  = require('plugins.nvim-tree').info(),
  toggleterm = require('plugins.toggleterm').info(),
  qml        = require('plugins.vim-qml').info(),
  nftable    = require('plugins.nftable').info(),
  gitsigns   = require('plugins.gitsigns').info(),
  sym        = require('plugins.symbols-outline').info(),
}

return M
