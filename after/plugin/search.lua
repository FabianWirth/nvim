require("telescope").setup()
local builtin = require("telescope.builtin")

require("telescope").load_extension("todo-comments")
require("telescope").load_extension("egrepify")
require("telescope").load_extension("octo")

local extensions = require("telescope").extensions

local is_git_dir = function()
	return vim.fn.isdirectory(".git") == 1
end

require("search").setup({
	initial_tab = 2,
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
			function() vim.cmd("TodoTelescope") end
		},
		{
			"Commits",
			builtin.git_commits,
			available = is_git_dir
		},
	}
})
