vim.g.mapleader = " "

vim.keymap.set("n", '<leader>pv', vim.cmd.Ex)

vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")

-- set default register to +	

local map = function(map)
	local v_bindings = map.v or {} -- v is for visual mode
	local n_bindings = map.n or {} -- n is for normal mode
	local i_bindings = map.i or {} -- i is for insert mode
	local t_bindings = map.t or {} -- t is for terminal mode
	for k, v in pairs(v_bindings) do
		vim.keymap.set("v", k, v[1])
	end
	for k, v in pairs(n_bindings) do
		vim.keymap.set("n", k, v[1])
	end
	for k, v in pairs(i_bindings) do
		vim.keymap.set("i", k, v[1])
	end
	for k, v in pairs(t_bindings) do
		vim.keymap.set("t", k, v[1])
	end
end


map({
	v = {
		["J"] = { ":m '>+1<CR>gv=gv", "move one up" },
		["K"] = { ":m '>-2<CR>gv=gv", "move one down" },
	},
	n = {
		["<C-d>"] = { "<C-d>zz", "jump half page in middle up" },
		["<C-u>"] = { "<C-u>zz", "jump half page in middle down" },
	},
	x = {
		["<leader>p"] = { '"_dP', "paste without yanking" },
		["x"] = { '"_x', "delete without yanking" }, -- check this
		["X"] = { '"_X', "delete without yanking" },
	},
})

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle<CR>")

-- copilot
vim.keymap.set("n", "<leader>cpd", "<cmd> Copilot disable<CR>")
vim.keymap.set("n", "<leader>cpe", "<cmd> Copilot enable<CR>")

-- lsp mappings
map({
	n = {
		["gD"] = { function() vim.lsp.buf.declaration() end, "LSP declaration", },
		["gd"] = { function() vim.lsp.buf.definition() end, "LSP definition", },

		["K"] = { function() vim.lsp.buf.hover() end, "LSP hover", },

		["gi"] = { function() vim.lsp.buf.implementation() end, "LSP implementation", },

		["<leader>ls"] = { function() vim.lsp.buf.signature_help() end, "LSP signature help", },

		["<leader>D"] = { function() vim.lsp.buf.type_definition() end, "LSP definition type", },

		["<leader>ra"] = { function() require("nvchad.renamer").open() end, "LSP rename", },

		["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "LSP code action", },

		["gr"] = { function() vim.lsp.buf.references() end, "LSP references", },

		["<leader>lf"] = { function() vim.diagnostic.open_float { border = "rounded" } end, "Floating diagnostic", },

		["[d"] = { function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, "Goto prev", },

		["]d"] = { function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, "Goto next", },

		["<leader>q"] = { function() vim.diagnostic.setloclist() end, "Diagnostic setloclist", },

		["<leader>wa"] = { function() vim.lsp.buf.add_workspace_folder() end, "Add workspace folder", },

		["<leader>wr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove workspace folder", },

		["<leader>wl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders", },
		["<leader>fm"] = { function() vim.lsp.buf.format { async = true } end, "Format buffer" }
	},
	v = {
		["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "LSP code action", },
	}
})

-- line numbers
map({
	n = {
		["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
		["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
	}
})

-- neo tree
map({
	n = {
		["<C-f>"] = { "<cmd>Neotree toggle<cr>", desc = "Show file tree" },
		["<C-o>"] = { "<cmd>Neotree focus<cr>", desc = "Focus file tree" },
	}
})

-- commenting
map({
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
})

-- toggleterm
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
map({
	n = {
		["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
		["<leader>tw"] = { "<cmd>ToggleTerm direction=horizontal<CR>", "Toggle terminal horizontal" },
		["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<CR>", "Toggle terminal vertical" },
		["<leader>tlg"] = {
			function()
				lazygit:toggle()
			end,
			"Open lazygit" }
	},
	t = {
		["<C-h>"] = { "<C-\\><C-n><C-w>h", "Navigate left" },
		["<C-j>"] = { "<C-\\><C-n><C-w>j", "Navigate down" },
		["<C-k>"] = { "<C-\\><C-n><C-w>k", "Navigate up" },
		["<C-l>"] = { "<C-\\><C-n><C-w>l", "Navigate right" },
		["<esc>"] = { "<C-\\><C-n>", "Exit terminal" },
	},
})

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fa", builtin.find_files, {})
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
