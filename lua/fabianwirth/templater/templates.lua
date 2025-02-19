-- templates.lua

local M = {}

function clean_namespace(namespace)
	local n = namespace:match("(.+)\\[^\\]+$") or namespace
	n = n:gsub("/", "\\")
	n = n:match("(.+)\\[^\\]+$")

	return n
end

function M.empty_class_template(namespace, class_name)
	return string.format(
		[[
<?php	

namespace %s;

class %s
{
    // Constructor and methods go here
}
]],
		clean_namespace(namespace),
		class_name
	)
end

function M.factory_class_template(namespace, class_name)
	return string.format(
		[[
<?php

namespace %s;

use Illuminate\Database\Eloquent\Factories\Factory;

class %s extends Factory
{
    public function definition(): array
    {
        return [
            // Define factory attributes here
        ];
    }
}
]],
		clean_namespace(namespace),
		class_name
	)
end

return M
