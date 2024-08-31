-- require("dapui").setup()
local dap = require('dap')

vim.lsp.set_log_level("debug")

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
	}
})

-- dap.adapters.php = {
-- 	type = 'executable',
-- 	command = 'node',
-- 	args = { '/home/fabian/dev/debug_systems/vscode-php-debug/out/phpDebug.js' }
-- }
--
-- dap.configurations.php = {
-- 	{
-- 		log = true,
-- 		type = "php",
-- 		request = "launch",
-- 		name = "Listen for XDebug",
-- 		port = 9003,
-- 		stopOnEntry = false,
-- 		xdebugSettings = {
-- 			max_children = 512,
-- 			max_data = 1024,
-- 			max_depth = 4,
-- 		},
-- 		breakpoints = {
-- 			exception = {
-- 				Notice = false,
-- 				Warning = false,
-- 				Error = false,
-- 				Exception = false,
-- 				["*"] = false,
-- 			},
-- 		},
-- 	}
-- }
-- dap.defaults.fallback.switchbuf = "useopen"
--
require("neotest").setup {
	adapters = {
		require("neotest-phpunit"),
  --  ({
		-- 	env = {
		-- 		XDEBUG_CONFIG = "idekey=neotest",
		-- 	},
		-- 	dap = dap.configurations.php[1],
		-- }),
		-- require("neotest-plenary").setup()
	},
}

-- require("neodev").setup({
-- 	library = { plugins = { --[[ "nvim-dap-ui", ]] "neotest" }, types = true },
-- })
local lsp = require("lsp-zero")
lsp.on_attach = function(client, bufnr)
				lsp.default_keymaps({buffer = bufnr})
end


local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = { documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}


-- require("mason").setup()
-- require("mason-lspconfig").setup({
-- 	ensure_installed = {},
-- 	handlers = {
-- 		lsp.default_setup
-- 	}
-- })

-- require("lspconfig").tsserver.setup {
-- 				-- only load this lsp in typescript projects
--
-- 	on_attach = function(client)
-- 		-- Disable formatting in lsp
-- 		-- client.resolved_capabilities.document_formatting = false
-- 	end,
-- 	capabilities = M.capabilities,
-- }

require("lspconfig").intelephense.setup {
	on_attach = function(client)
		-- Disable formatting in lsp
		-- client.resolved_capabilities.document_formatting = false
	end,
	capabilities = M.capabilities,
}

require("lspconfig").rust_analyzer.setup {
	on_attach = function(client)
		-- Disable formatting in lsp
		-- client.resolved_capabilities.document_formatting = false
	end,
	capabilities = M.capabilities,
}

-- require("lspconfig").lua_ls.setup {
-- 	on_attach = function(client)
-- 		-- Disable formatting in lsp
-- 		-- client.resolved_capabilities.document_formatting = false
-- 	end,
-- 	capabilities = M.capabilities,
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 				path = vim.split(package.path, ";"),
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
-- 					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
--


local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)

				-- TODO: Add support for newer versions of node
  local global_ts = '/home/fabian/.nvm/versions/node/v22.4.1/lib/node_modules/typescript/lib'

  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
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

require'lspconfig'.volar.setup{
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  filetypes = { "vue" },
	on_attach = function(client)
	end,
	capabilities = M.capabilities,

}

