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

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
-- vim.laststatus = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.statusline = ""

require("fabianwirth")
