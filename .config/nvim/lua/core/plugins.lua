vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use {
    'neovim/nvim-lspconfig',
    requires = {
      {'ms-jpq/coq_nvim', branch = 'coq'},
--      {'ms-jpq/coq.thirdparty'}
    }
  }
  use 'williamboman/nvim-lsp-installer'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

end)
