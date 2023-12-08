return {
	{ "github/copilot.vim",        lazy = false },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
	{ 'neovim/nvim-lspconfig' },
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function()
					require("nvim-autopairs").setup()

					-- setup cmp for autopairs
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		}
	},
	{ 'L3MON4D3/LuaSnip' },
	{ 'williamboman/mason.nvim', lazy = false, },
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		requires = { 'williamboman/mason.nvim' },
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		config = true
	},
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui" },
	{ "folke/neodev.nvim" },
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup()
			require("crates").show()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = "TSUpdate",
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			{ "olimorris/neotest-phpunit", url = "https://github.com/przepompownia/neotest-phpunit.git", branch = "dap-strategy" },

		},
	}
}
