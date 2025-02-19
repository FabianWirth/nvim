vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")

local wk = require("which-key")

local M = {
	mappings = {},
	is_registered = false,
}

function M.add(key, definition, mode)
	local description = definition[2] or ""
	local action = definition[1]

	table.insert(M.mappings, {
		key = key,
		description = description,
		action = action,
		mode = mode,
	})
end

function M.register()
	for _, mapping in ipairs(M.mappings) do
		if mapping.description == "" then
			vim.keymap.set(mapping.mode, mapping.key, mapping.action)
		else
			wk.add({
				{ mapping.key, mapping.action, desc = mapping.description, mode = mapping.mode },
			})
		end
	end
	M.is_registered = true
end

local map = function(mappings)
	local bindings = { "v", "n", "i", "t", "x" }
	for _, mode in ipairs(bindings) do
		local mode_mappings = mappings[mode] or {}
		if mode_mappings ~= nil then
			for key, definition in pairs(mode_mappings) do
				M.add(key, definition, mode)
			end
		end
	end
end

function TELLME()
	print("registered: " .. tostring(M.is_registered))
	print("mappings count: " .. #M.mappings)
end

vim.keymap.set("n", "<leader>tm?", TELLME)

map({
	v = {
		["J"] = { ":m '>+1<CR>gv=gv" }, -- move line up
		["K"] = { ":m '>-2<CR>gv=gv" }, -- move line down
	},
	n = {
		-- remove search highlight
		["<ESC>"] = { ":noh<CR>" },
	},
})

map({
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
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},
		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},
		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"LSP hover",
		},
		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"LSP implementation",
		},
		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP definition type",
		},

		["<leader>ra"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},
		["<leader>ca"] = {
			function()
				require("actions-preview").code_actions()
			end,
			"LSP code action",
		},
		["<leader>cr"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},
		["<leader>cd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},
		["<leader>cD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},
		["<leader>cu"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},
		["<leader>ch"] = {
			function()
				vim.lsp.buf.typehierarchy()
			end,
			"LSP hierarchy",
		},
		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},

		["<leader>lf"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"Floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ float = { border = "rounded" } })
			end,
			"Goto prev",
		},

		["]d"] = {
			function()
				vim.diagnostic.goto_next({ float = { border = "rounded" } })
			end,
			"Goto next",
		},

		["<leader>q"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"Diagnostic setloclist",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"Add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"Remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({
					async = true,
					debug = true,
					filter = function(client)
						if client.name == "null-ls" or client.name == "rust_analyzer" then
							print("formatting null-ls or other legal")
							return true
						end
						print("not formatting: " .. client.name)
						return false
					end,
				})
			end,
			"Format buffer",
		},
	},
	v = {
		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},
	},
})

-- line numbers
map({
	n = {
		["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
		["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
	},
})

-- neo tree
map({
	n = {
		["<C-f>"] = { "<cmd>Neotree toggle<cr>", "Show file tree" },
		["<C-o>"] = { "<cmd>Neotree focus<cr>", "Focus file tree" },
	},
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
local tinker =
	Terminal:new({ cmd = "php artisan tinker", hidden = true, direction = "float", count = 5, close_on_exit = false })
map({
	n = {
		["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
		["<leader>tw"] = { "<cmd>ToggleTerm direction=horizontal<CR>", "Toggle terminal horizontal" },
		["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<CR>", "Toggle terminal vertical" },
		["<leader>tlg"] = {
			function()
				lazygit:toggle()
			end,
			"Open lazygit",
		},
		["<leader>tat"] = {
			function()
				tinker:toggle()
			end,
			"Open tinker",
		},
	},
	v = {
		["<space>s"] = {
			function()
				require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = 5 }) -- 5 is the count of the terminal that is running tinker
			end,
			"Send to php artisan tinker",
		},
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
local search = require("search")
map({
	n = {
		["<leader>fa"] = { builtin.find_files, "find all" },
		["<leader>ff"] = {
			function()
				search.open({ tab_id = 2 })
			end,
			"search window",
		},
		["<leader>fg"] = {
			function()
				search.open({ collection = "git", tab_name = "Branches" })
			end,
			"git pickers",
		},
		["<leader>ft"] = { "<cmd> Telescope toggleterm_manager<CR>", "find toggleterm" },
		["<leader>fw"] = {
			function()
				search.open({ tab_name = "Grep" })
			end,
			"find word",
		},
		["<leader>fb"] = { builtin.buffers, "find buffers" },
		["<leader>fvr"] = { builtin.reloader, "find reloaders" },
		["<leader>fc"] = { builtin.commands, "find commands" },
		["<leader>fqf"] = { builtin.quickfix, "find quickfix" },
		["<leader>fvo"] = { builtin.vim_options, "find vim options" },
		["<leader>fkm"] = { builtin.keymaps, "find keymaps" },

		["<leader>fi"] = { builtin.lsp_implementations, "find lsp implementations" },
		["U"] = {
			function()
				builtin.lsp_references(require("telescope.themes").get_cursor())
			end,
			"find lsp references (small), see fu for big",
		},
		["<leader>fu"] = {
			function()
				builtin.lsp_references()
			end,
			"find lsp references (big), see U for cursor",
		},
		["<leader>fh"] = {
			function()
				builtin.lsp_type_definitions()
			end,
			"find lsp references (big), see U for cursor",
		},
		["<leader>fws"] = { builtin.lsp_workspace_symbols, "find lsp workspace symbols" },
	},
})

-- crates
map({
	n = {
		["<leader>rcu"] = {
			function()
				require("crates").upgrade_all_crates()
			end,
			"update crates",
		},
		["<leader>rci"] = {
			function()
				require("crates").show_popup()
			end,
			"show crate popup",
		},
	},
})

-- buffer
map({
	n = {
		["<Shift-h>"] = { "<cmd>bprev<CR>" },
		["<S-h>"] = { "<cmd>bprev<CR>" },
		["<Shift-l>"] = { "<cmd>bnext<CR>" },
		["<S-l>"] = { "<cmd>bnext<CR>" },
		["<leader>x"] = { "<cmd>bdelete<CR>" },
	},
})

-- neotest
map({
	n = {
		["<leader>Tr"] = { ":lua require('neotest').run.run()<cr>", "run closest test" },
		["<leader>Td"] = { ":lua require('neotest').run.run({strategy = 'dap'})<cr>", "run closest test" },
		["<leader>Tx"] = { ":lua require('neotest').run.stop()<cr>", "stop test runs" },
		["<leader>Tf"] = {
			":lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
			"run all tests in file",
		},
		["<leader>Tp"] = { ":lua require('neotest').output_panel.toggle()<cr>", "toggle test panel" },
		["<leader>Ts"] = { ":lua require('neotest').summary.toggle()<cr>", "toggle summary panel" },
	},
})

-- dap
map({
	n = {
		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
		["<leader>du"] = {
			function()
				require("dapui").toggle()
			end,
			"Open debugging sidebar",
		},
		["<leader>dc"] = { "<cmd> DapContinue <CR>" },
		["<leader>dn"] = { "<cmd> DapNext <CR>" },
		["<leader>di"] = { "<cmd> DapStepInto <CR>" },
		["<leader>do"] = { "<cmd> DapStepOut <CR>" },
		["<leader>dr"] = { "<cmd> DapRestart <CR>" },
		["<leader>dx"] = { "<cmd> DapStop <CR>" },
		["<leader>dK"] = {
			function()
				require("dapui").eval()
				require("dapui").eval()
			end,
			"Evaluate in debug",
		},
	},
})

--gitsigns
map({
	n = {
		["<leader>gb"] = { "<cmd> Gitsigns blame<CR>", "open blame view" },
		["<leader>gl"] = { "<cmd> Gitsigns blame_line<CR>", "blame line" },
		["<leader>gw"] = { "<cmd> Gitsigns toggle_word_diff<CR>", "toggle word dif" },
		["<leader>gd"] = { "<cmd> Gitsigns diffthis<CR>", "toggle word dif" },
	},
})

M.register()

-- chat gpt
-- map({
-- 	n = {
-- 		["<leader>cg"] = { "<cmd> ChatGPT<CR>", "Chat GPT" },
-- 		["<leader>cd"] = { "<cmd> ChatGPTRun docstring<CR>", "Chat make docstring" },
-- 	},
-- })
