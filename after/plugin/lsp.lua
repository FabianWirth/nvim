local lsp = require("lsp-zero")

local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
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

lsp.preset("recommended")
lsp.setup {
	on_attach = function(client)
		-- Disable formatting in lsp
		-- client.resolved_capabilities.document_formatting = false
	end,
	capabilities = M.capabilities,
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup
	}
})

require("lspconfig").rust_analyzer.setup {
	on_attach = function(client)
		-- Disable formatting in lsp
		-- client.resolved_capabilities.document_formatting = false
	end,
	capabilities = M.capabilities,
}

require("lspconfig").lua_ls.setup {
	on_attach = function(client)
		-- Disable formatting in lsp
		-- client.resolved_capabilities.document_formatting = false
	end,
	capabilities = M.capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
				},
			},
		},
	},
}
