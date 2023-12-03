local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.setup {
  on_attach = function(client)
    -- Disable formatting in lsp
    -- client.resolved_capabilities.document_formatting = false
  end,
  capabilities = lsp.capabilities,
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup
	}
})
