local plugins = require("fabianwirth.plugins.init")

require("lazy").setup(plugins)
require("fabianwirth.remap")

-- set the tab indent to 2 spaces
vim.cmd("set tabstop=2")

-- setting the defaults like colorscheme
-- vim.cmd("colorscheme catppuccin")
vim.opt.cmdheight = 1
vim.cmd [[highlight Normal ctermbg=none guibg=none]]
vim.api.nvim_set_hl(0, "Float", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })

-- change color of cursorline to a lighter color
vim.cmd("highlight CursorLine guibg=none")
vim.opt.showmode = false

vim.cmd("set relativenumber")
