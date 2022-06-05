vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use {
    'neovim/nvim-lspconfig',
    requires = {
      {'ms-jpq/coq_nvim', branch = 'coq'},
      'williamboman/nvim-lsp-installer'
--      {'ms-jpq/coq.thirdparty'}
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }


end)
