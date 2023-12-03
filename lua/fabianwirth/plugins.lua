return {
	{
		'nvim-telescope/telescope.nvim',
		lazy = false,
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	{
		's1n7ax/nvim-window-picker',
		name = 'window-picker',
		event = 'VeryLazy',
		version = '2.*',
		config = function()
			require 'window-picker'.setup()
		end,
	},
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{ "rebelot/kanagawa.nvim", },
	{
		"nvim-treesitter/nvim-treesitter",
		run = "TSUpdate",
	},
	{ "mbbill/undotree",                lazy = false },
	{ "github/copilot.vim",             lazy = false },
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ 'VonHeikemen/lsp-zero.nvim',      branch = 'v3.x' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'L3MON4D3/LuaSnip' },
	{ 'williamboman/mason.nvim',        lazy = false, },
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		requires = { 'williamboman/mason.nvim' },
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n",          desc = "Comment toggle current line" },
			{ "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n",          desc = "Comment toggle current block" },
			{ "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
		},
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	}
}
