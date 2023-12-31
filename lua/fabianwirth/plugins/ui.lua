return {
	{
		'nvim-telescope/telescope.nvim',
		lazy = false,
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = true,
	},
	{
		"FabianWirth/search.nvim",
		-- dir = "/home/fabian/dev/lua/search.nvim",
		name = "search",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim"
		}
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true
	},
	{
		"fdschmidt93/telescope-egrepify.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = true,
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
		config = true,
	},
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{ "mbbill/undotree",         lazy = false },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		}
	}

}
