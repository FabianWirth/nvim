local builtin = require("telescope.builtin")
require("search").setup({
	initial_tab = 2,
	append_tabs = {
		{
			name = "Symbols",
			tele_func = builtin.lsp_workspace_symbols,
			--- todo: check if the client supports document symbols and not just if there is a client
			available = function()
				local clients = vim.lsp.get_active_clients()
				for _, client in ipairs(clients) do
					if client.server_capabilities.workspaceSymbolProvider then
						return true
					end
				end
				return false
			end
		},
		{
			name = "Buffers",
			tele_func = builtin.buffers,
		},
		{
			name = "Commits",
			tele_func = builtin.git_commits,
			available = function()
				return vim.fn.isdirectory(".git") == 1
			end
		}
	}
})
