local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float()
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')
    use('mbbill/undotree')
    use('tpope/vim-commentary')
    use('nvim-lua/plenary.nvim')
	-- Colorschemes
    -- use({'rose-pine/neovim',
    --     as = 'rose-pine', config = function()
    --         require("rose-pine").setup()
    --         vim.cmd('colorscheme rose-pine')
    --  end
    -- })
    -- use("kihachi2000/yash.nvim")
    use("vague2k/vague.nvim")
	-- Completions cmp
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
	use('saadparwaiz1/cmp_luasnip')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-nvim-lua')
	-- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')
    -- LSP
	use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
	use('jose-elias-alvarez/null-ls.nvim')
	-- Telescope
	use('nvim-telescope/telescope.nvim')
	-- Treesitter
	use('nvim-treesitter/nvim-treesitter')
    use('nvim-treesitter/playground')
	-- Git
    use('tpope/vim-fugitive')
    -- Assembly
    -- use('krady21/compiler-explorer.nvim')
    -- use('p00f/godbolt.nvim')
    -- Tmux
    -- use('christoomey/vim-tmux-navigator')
    -- AI
    use('github/copilot.vim')
    use({"folke/snacks.nvim",
      config = function()
        if vim.g.__snacks_setup_done then return end
        vim.g.__snacks_setup_done = true
        require("snacks").setup({ input = {}, picker = {}, terminal = {} })
      end,
    })
    use({"NickvanDyke/opencode.nvim",
      requires = { "folke/snacks.nvim" },
      config = function()
        vim.g.opencode_opts = {}
        vim.o.autoread = true
        -- ask
        vim.keymap.set({ "n", "x" }, "<leader>oq", function()
          require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })
        -- execute
        vim.keymap.set({ "n", "x" }, "<leader>ox", function()
          require("opencode").select()
        end, { desc = "Execute opencode action" })
        -- open
        vim.keymap.set("n", "<leader>oo", function()
          require("opencode").command("session.half.page.down")
        end, { desc = "opencode half page down" })
      end,
    })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
