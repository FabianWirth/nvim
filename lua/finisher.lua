-- Use the system clipboard (unnamedplus)
vim.opt.clipboard = "unnamedplus"

-- Configure the clipboard provider to use wl-clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste --no-newline",
    ["*"] = "wl-paste --no-newline",
  },
  cache_enabled = 0,
}

vim.opt.cursorline = true
-- vim.laststatus = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.statusline = ""

vim.cmd("colorscheme catppuccin")
vim.cmd("highlight CursorLine guibg=none")
