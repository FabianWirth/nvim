-- init.lua

local utils = require("fabianwirth.templater.utils")
local templates = require("fabianwirth.templater.templates")

local function create_class(namespace, make_template, args)
	local file_path, class_name = utils.get_class_file_path(namespace)
	local dir = vim.fn.fnamemodify(file_path, ":h")

	local final_dir = ""
	local path_parts = vim.split(dir, "/")

	for _, part in ipairs(path_parts) do
		local current_path = final_dir == "" and part or (final_dir .. "/" .. part)
		final_dir = utils.ensure_case_insensitive_directory_exists(current_path)
		if vim.fn.isdirectory(final_dir) == 0 then
			vim.fn.mkdir(final_dir, "p")
		end
	end

	local class_template = make_template(namespace, class_name)
	local f = io.open(final_dir .. "/" .. class_name .. ".php", "w")
	if f then
		f:write(class_template)
		f:close()
		print("Class created at " .. final_dir .. "/" .. class_name .. ".php")
	else
		print("Failed to create class")
	end

	vim.cmd("edit " .. final_dir .. "/" .. class_name .. ".php")
end

vim.api.nvim_create_user_command("Nc", function(opts)
	create_class(opts.args, templates.empty_class_template)
end, {
	nargs = 1,
	complete = "file",
})

vim.api.nvim_create_user_command("NcF", function(opts)
	local name = opts.args
	local namespace = "Database/Factories/" .. name .. "Factory"
	create_class(namespace, templates.factory_class_template)
end, {
	nargs = 1,
	complete = "file",
})
