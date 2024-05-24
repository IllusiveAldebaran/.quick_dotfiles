local status, db = pcall(require, "dashboard")

if not status then
	return
end

-- Read our optional headers, from header_array
local custom_headers = require("configs.nvim-headers")

db.setup({
	theme = "hyper",
	config = {
		-- randomly choose a header
		header = custom_headers[math.random(table.getn(custom_headers))],

		week_header = {
			enable = false,
		},
		shortcut = {
			{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				desc = " Apps",
				group = "DiagnosticHint",
				action = "Telescope app",
				key = "a",
			},
			{
				desc = " dotfiles",
				group = "Number",
				action = "Telescope dotfiles",
				key = "d",
			},
		},
	},
})
