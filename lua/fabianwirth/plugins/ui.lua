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
		config = true,
	},
	{ 'akinsho/toggleterm.nvim', version = "*", config = true },
	{ "mbbill/undotree",         lazy = false },
}
