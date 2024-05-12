local util = require("trouble.util")

local function get_list()
	local items = require("marks").bookmark_state:get_items(0) or {}

	local ret = {}
	for _, item in pairs(items) do
		local row = (item.lnum == 0 and 1 or item.lnum) - 1
		local col = (item.col == 0 and 1 or item.col) - 1

		ret[#ret + 1] = {
			row = row,
			col = col,
			message = item.text,
			bufnr = item.bufnr,
			range = {
				start = { line = row, character = col },
				["end"] = { line = row, character = -1 },
			},
		}
	end

	for i, item in ipairs(ret) do
		ret[i] = util.process_item(item)
	end

	return ret
end

local function mark(_win, _buf, cb, _options)
	cb(get_list())
end

return mark
