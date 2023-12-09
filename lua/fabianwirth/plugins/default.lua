return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
	{ "lewis6991/gitsigns.nvim",        config = true },
	{ "christoomey/vim-tmux-navigator", lazy = false },
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
		config = true
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "echo $CHATGPT_API_KEY",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	},
	"m4xshen/autoclose.nvim",
}
