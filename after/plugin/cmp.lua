local cmp = require("cmp")

local cmp_ui = {
	border_color = "grey_fg",
	icons = true,
	lspkind_text = true,
	selected_item_bg = "simple",
	style = "atom_colored",
}
local cmp_style = cmp_ui.style

local field_arrangement = {
	atom = { "kind", "abbr", "menu" },
	atom_colored = { "kind", "abbr", "menu" },
}

local formatting_style = {
	-- default fields order i.e completion word + item.kind + item.kind icons
	fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

	format = function(_, item)
		local icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		}
		local icon = (cmp_ui.icons and icons[item.kind]) or ""

		if cmp_style == "atom" or cmp_style == "atom_colored" then
			icon = " " .. icon .. " "
			item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
			item.kind = icon
		else
			icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
			item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
		end

		return item
	end,
}

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local options = {
	completion = {
		completeopt = "menu,menuone,noselect",
	},

	formatting = formatting_style,

	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		-- { name = "nvim_lua" },
		{ name = "path" },
		-- { name = "crates" },
		-- { name = "luasnip" },
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
}

if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
	options.window.completion.border = border("CmpBorder")
end

cmp.setup(options)
