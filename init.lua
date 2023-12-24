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
				vim.g.neovide_background_color = "#000fff"..alpha()
end

