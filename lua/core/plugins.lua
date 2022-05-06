local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "lewis6991/impatient.nvim" -- Optimiser
  use {
    "rcarriga/nvim-notify",
    config = function()
      require("configs.notify")
    end,
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("configs.autopairs")
    end,
  } -- Autopairs, integrates with both cmp and treesitter
  use {
    "folke/which-key.nvim",
    config = function()
      require("configs.whichkey")
    end,
  }
  use "kyazdani42/nvim-web-devicons"
  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("configs.bufferline")
    end,
  }
  use "moll/vim-bbye"
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("configs.lualine")
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("configs.toggleterm")
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("configs.nvim-tree")
    end,
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use {
    "windwp/nvim-spectre",
    config = function()
      require("configs.spectre")
    end,
  }

  -- Colorschemes
  use "navarasu/onedark.nvim"
  use "Mofiqul/dracula.nvim"

  -- Telescope

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("configs.telescope")
    end,
  }
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"


  -- cmp plugins

  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("configs.cmp")
    end,
  }
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  }


  -- Snippets

  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use


  -- LSP

  use {
    "neovim/nvim-lspconfig",
  } -- enable LSP
  use {
    "williamboman/nvim-lsp-installer",
    -- after = "nvim-lspconfig",
  } -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use {
    "jose-elias-alvarez/null-ls.nvim",
  } -- for formatters and linters
  use {
    "filipdutescu/renamer.nvim",
  }
  use {
    "ray-x/lsp_signature.nvim",
  }
  use "b0o/SchemaStore.nvim"
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  }
  use "github/copilot.vim"
  use "RRethy/vim-illuminate"


  -- DAP

  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "Pocco81/DAPInstall.nvim"




  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
