
-- utils.lua

local M = {}

function M.ensure_case_insensitive_directory_exists(path)
  local parent_dir = vim.fn.fnamemodify(path, ":h")
  local basename = vim.fn.fnamemodify(path, ":t")

  if vim.fn.isdirectory(parent_dir) == 0 then
    vim.fn.mkdir(parent_dir, "p")
  end

  local files_in_dir = vim.fn.readdir(parent_dir)
  for _, file in ipairs(files_in_dir) do
    if file:lower() == basename:lower() then
      return parent_dir .. "/" .. file
    end
  end

  return path
end

function M.get_class_file_path(namespace)
  namespace = namespace:gsub("/", "\\")
  return namespace:gsub("\\", "/") .. ".php", namespace:match("([^\\]+)$")
end

return M
