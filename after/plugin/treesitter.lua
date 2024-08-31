require("nvim-treesitter.configs").setup {
	ensure_installed = { "php", "lua", "rust", "typescript", "javascript", "html", "css", "c" },
	auto_install = true,
	highlight = {
		enable = true, -- no idea what this is.
		use_languagetree = true,
	},
	additional_vim_regex_highlighting = false,
	ident = {
		enable = true,
	},
}
vim.treesitter.language.register('php', "blade")
