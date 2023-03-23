local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	--add all plugins here
	use("wbthomason/packer.nvim")

	--lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	--colorscheme
	--from initial yt video
	use("bluz71/vim-nightfly-guicolors")
	-- use("nyoom-engineering/oxocarbon.nvim")

	--tmux split window navigation
	use("christoomey/vim-tmux-navigator")

	--tmux and vim integration
	use("preservim/vimux")

	--maximizes and restores current window
	use("szw/vim-maximizer")

	--sorround motion with character
	use("tpope/vim-surround")

	--replace motion with what is stored in register using gr motion
	use("vim-scripts/ReplaceWithRegister")

	--commenting with gc
	use("numToStr/Comment.nvim")

	--file explorer
	use("nvim-tree/nvim-tree.lua")

	--enhanced UI
	use("stevearc/dressing.nvim")

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- status bar
	-- use({ "romgrk/barbar.nvim", requires = "nvim-web-devicons" })

	-- Harpoon for buffer management
	use("ThePrimeagen/harpoon")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- Chezmoi integration
	use("alker0/chezmoi.vim")

	-- Wakatime integration
	use("wakatime/vim-wakatime")

	-- Terminal Window Toggle
	use({
		"s1n7ax/nvim-terminal",
		config = function()
			vim.o.hidden = true
			require("nvim-terminal").setup()
		end,
	})

	-- Indent Line
	use("Yggdroot/indentLine")

	-- Fast Motion
	use("ggandor/leap.nvim")

	-- Dashboard
	-- use("glepnir/dashboard-nvim")

	-- Keybindings
	use("mrjones2014/legendary.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
