vim.api.nvim_create_user_command("GS", function(args)
	-- now we split args into the parts 'foo/bar (foo and bar)
	-- 'foo/bar'
	local input = args.args
	-- 'foo'
	local search = input:match("([^/]+)")
	-- 'bar'
	local replace = input:match("/([^/]+)$")

	-- Use `vimgrep` to search through Git-tracked files without opening them all
	vim.cmd("vimgrep /" .. search .. "/g `git ls-files`")

	uniqyfyQuickfixList()

	-- Perform search and replace on files in the quickfix list that contain matches
	vim.cmd("cdo %s/" .. search .. "/" .. replace .. "/gc")

	-- Save only the files with changes
	vim.cmd("cdo update")

	-- Close the quickfix list to avoid clutter
	vim.cmd("cclose")
end, { nargs = 1 })

function uniqyfyQuickfixList()
	local quickfixList = vim.fn.getqflist()
	local uniqueList = {}
	local seen_files = {}

	for key, item in ipairs(quickfixList) do
		local bufnr = item.bufnr

		if seen_files[bufnr] == nil and bufnr ~= nil then
			seen_files[bufnr] = true
			uniqueList[key] = item
		end
	end

	vim.fn.setqflist(uniqueList, "r")
end
--
-- local function ensure_case_insensitive_directory_exists(path)
--   local parent_dir = vim.fn.fnamemodify(path, ":h")
--   local basename = vim.fn.fnamemodify(path, ":t")
--
--   if vim.fn.isdirectory(parent_dir) == 0 then
--     vim.fn.mkdir(parent_dir, "p")
--   end
--
--   local files_in_dir = vim.fn.readdir(parent_dir)
--   for _, file in ipairs(files_in_dir) do
--     if file:lower() == basename:lower() then
--       return parent_dir .. "/" .. file
--     end
--   end
--
--   return path
-- end
--
-- local function create_class(namespace, make_template, args)
--   namespace = namespace:gsub("/", "\\")
--   local file_path = namespace:gsub("\\", "/") .. ".php"
--   local class_name = namespace:match("([^\\]+)$")
--
--   local dir = vim.fn.fnamemodify(file_path, ":h")
--   
--   local final_dir = ""
--   local path_parts = vim.split(dir, "/")
--
--   for _, part in ipairs(path_parts) do
--     local current_path = final_dir == "" and part or (final_dir .. "/" .. part)
--     final_dir = ensure_case_insensitive_directory_exists(current_path)
--     if vim.fn.isdirectory(final_dir) == 0 then
--       vim.fn.mkdir(final_dir, "p")
--     end
--   end
--
--   local class_template = make_template(namespace, class_name, args)
--   local f = io.open(final_dir .. "/" .. class_name .. ".php", "w")
--   if f then
--     f:write(class_template)
--     f:close()
--     print("Class created at " .. final_dir .. "/" .. class_name .. ".php")
--   else
--     print("Failed to create class")
--   end
--
--   vim.cmd("edit " .. final_dir .. "/" .. class_name .. ".php")
-- end
--
-- vim.api.nvim_create_user_command('Nc', function(opts)
--   create_class(opts.args, empty_class_template)
-- end, {
--   nargs = 1,
--   complete = 'file',
-- })
--
-- vim.api.nvim_create_user_command('NcF', function(opts)
--   local name = opts.args
--   local namespace = 'Database/Factories/' .. name .. 'Factory'
--   create_class(namespace, factory_class_template)
-- end, {
--   nargs = 1,
--   complete = 'file',
-- })
--
-- local function empty_class_template(namespace, class_name)
--   return string.format([[
-- <?php	
--
-- namespace %s;
--
-- class %s
-- {
--     // Constructor and methods go here
-- }
-- ]], namespace:match("(.+)\\[^\\]+$"), class_name)
-- end
--
-- local function factory_class_template(namespace, class_name)
--   return string.format([[
-- <?php
--
-- namespace %s;
--
-- use Illuminate\Database\Eloquent\Factories\Factory;
--
-- class %sFactory extends Factory
-- {
--     public function definition(): array
--     {
-- 				return [
-- 								
-- 				];
--     }
-- }
-- ]], namespace:match("(.+)\\[^\\]+$"), namespace, class_name)
-- end
