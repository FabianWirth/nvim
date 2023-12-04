-- we load the groups of plugins here
local default = require("fabianwirth.plugins.default")
local coding = require("fabianwirth.plugins.coding")
local themes = require("fabianwirth.plugins.themes")
local ui = require("fabianwirth.plugins.ui")

-- then we merge all the groups into one table
local M = {}
for _, plugin in ipairs(default) do
	table.insert(M, plugin)
end

for _, plugin in ipairs(coding) do
	table.insert(M, plugin)
end

for _, plugin in ipairs(themes) do
	table.insert(M, plugin)
end

for _, plugin in ipairs(ui) do
	table.insert(M, plugin)
end

return M
