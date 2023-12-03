local plugins = require("fabianwirth.plugins")

require("lazy").setup(plugins)
require("fabianwirth.remap")

-- set the tab indent to 4 spaces
vim.cmd("set tabstop=2")

-- setting the defaults like colorscheme
vim.cmd("colorscheme kanagawa-wave")
vim.opt.cmdheight = 1
vim.cmd [[highlight Normal ctermbg=none guibg=none]]
vim.api.nvim_set_hl(0, "Float", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })

-- change color of cursorline to a lighter color
vim.cmd("highlight CursorLine guibg=#1a1a1a")

vim.cmd("set relativenumber")
