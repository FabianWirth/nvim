local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("fabianwirth")
require("finisher")

local alpha = function()
	local trans = vim.g.transparency or 0.8
	return string.format("%x", math.floor(255 * trans))
end

-- neovide configuration
if vim.g.neovide then
	vim.g.neovide_transparency = 0.8
	vim.g.transparency = 0.8
	vim.g.neovide_background_color = "#000fff" .. alpha()
	vim.opt.linespace = 0
	vim.g.neovide_scale_factor = 0.8
	vim.g.neovide_cursor_animation_length = 0.05

	vim.g.neovide_cursor_vfx_mode = "ripple"

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.o.pumblend = 80
	vim.o.winblend = 80
end

function ListFormattingProviders()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	local formatters = {}

	for _, client in pairs(clients) do
		if client.server_capabilities.documentFormattingProvider then
			table.insert(formatters, client.name)
		end
	end

	if #formatters > 0 then
		print("Active LSP formatters: " .. table.concat(formatters, ", "))
	else
		print("No LSP client is providing formatting.")
	end
end
