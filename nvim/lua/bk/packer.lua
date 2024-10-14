-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }


  use ({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  use ({
  'ThePrimeagen/vim-be-good'
})

  use ({
  'ThePrimeagen/harpoon'
})
use ({
	'mfussenegger/nvim-dap'
})
use ({
	'nvim-neotest/nvim-nio'
})
use ({
	'vimwiki/vimwiki'
})




use ({
	'rcarriga/nvim-dap-ui',
})
use ({ 'theHamsta/nvim-dap-virtual-text'})

use ({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
})
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    -- {'williamboman/mason.nvim'},
    -- {'williamboman/mason-lspconfig.nvim'},

    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}

use ({
    'nvim-telescope/telescope-dap.nvim',
    requires = { 'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim' }
})

end)
