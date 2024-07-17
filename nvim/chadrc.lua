local M = {}

M.ui = {
	theme = "onedark",

	nvdash = {
		load_on_startup = true,
		header = {
			"                                  ",
			"               █                ",
			"              ███               ",
			"             █████              ",
			"            ███████             ",
			"            █████████             ",
			"            ██     ██             ",
			"            ██ ███ ██             ",
			"            ██ ███ ██             ",
			"            ██ ███ ██             ",
			"            ██ ███ ██             ",
			"            ██     ██             ",
			"            █████████             ",
			"            ███████             ",
			"             █████              ",
			"              ███               ",
			"               █                ",
			"                                  ",
		},
	},

	hl_override = {
		NvDashAscii = {
			fg = "#E2EAED",
			bg = "#295844",
		},
		NvDashButtons = {
			fg = "#E2EAED",
		},
	},
}

return M
