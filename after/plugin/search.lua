local winbled_c = 0
if vim.g.neovide then
	winbled_c = 70
end

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
		file_ignore_patterns = { "%.json$" },
		winblend = winbled_c,
	},
})
local builtin = require("telescope.builtin")

require("telescope").load_extension("todo-comments")
require("telescope").load_extension("egrepify")
require("telescope")

local extensions = require("telescope").extensions

local is_git_dir = function()
	return vim.fn.isdirectory(".git") == 1
end

require("search").setup({
	initial_tab = 2,
	mappings = {
		next = { { "L", "n" }, { "<Tab>", "n" }, { "<Tab>", "i" } },
		prev = { { "H", "n" }, { "<S-Tab>", "n" }, { "<S-Tab>", "i" } },
	},
	tabs = {
		{
			"All Files",
			builtin.find_files,
		},
		{
			"Git Files",
			builtin.git_files,
			available = is_git_dir,
		},
		{
			"Grep",
			extensions.egrepify.egrepify,
		},
		{
			"Todo",
			function()
				vim.cmd("TodoTelescope")
			end,
		},
		{
			"Commits",
			builtin.git_commits,
			available = is_git_dir,
		},
		{
			"Registers",
			builtin.registers,
		},
	},
	collections = {
		git = {
			initial_tab = 2,
			tabs = {
				{ name = "Git files", tele_func = builtin.git_files, available = is_git_dir },
				{ name = "Bcommits", tele_func = builtin.git_bcommits, available = is_git_dir },
				{ name = "Branches", tele_func = builtin.git_branches, available = is_git_dir },
				{ name = "Commits", tele_func = builtin.git_commits, available = is_git_dir },
				{ name = "Status", tele_func = builtin.git_status, available = is_git_dir },
				{ name = "Stash", tele_func = builtin.git_stash, available = is_git_dir },
				{
					name = "fail",
					function()
						error("fail")
					end,
				},
			},
		},
	},
})
