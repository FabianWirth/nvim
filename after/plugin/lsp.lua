-- globals --
local dap = require("dap")
local lsp = require("lsp-zero")
local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local util = require("lspconfig.util")
local function get_typescript_server_path(root_dir)
	local global_ts = "/home/fabian/.nvm/versions/node/v22.4.1/lib/node_modules/typescript/lib"

	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

-- formatting --

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.gofmt,
	},
	debug = true,
})

-- testing --

require("neotest").setup({
	adapters = {
		require("neotest-phpunit"),
	},
})

-- lsp --

lsp.on_attach = function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	client.server_capabilities.document_formatting = false
end

local S = {
	intelephense = {
		settings = {
			completion = {
				insertUseDeclaration = true,
			},
			telemetry = {
				enable = false,
			},
		},
	},

	pyright = {},
	rust_analyzer = {},
	tailwindcss = {},
	gopls = {},
	volar = {
		on_new_config = function(new_config, new_root_dir)
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end,
		filetypes = { "vue" },
	},
}

-- utils --

-- lsp execution --
for server, config in pairs(S) do
	lspconfig[server].setup(vim.tbl_deep_extend("force", {
		on_attach = lsp.on_attach,
		capabilities = capabilities,
	}, config))
end
