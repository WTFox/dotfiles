local wezterm = require("wezterm")

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if not is_windows then
	return {}
end

return {
	default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu",
			default_cwd = "~",
		},
	},
	font = wezterm.font({
		family = "JetBrains Mono",
		weight = "Medium",
		harfbuzz_features = {
			"calt", -- Contains all ligatures. Substitution for : between digits
			"clig",
			"liga",
			-- "zero", -- Changes 0 to slashed variant.
			-- "frac", -- Substitute digits in fraction sequences to look more like fractions.
			-- "ss01", -- All classic construction. JetBrains Mono but even more neutral. Performs better in big paragraph of text.
			-- "ss02", -- All closed construction. Change the rhythm to a more lively one.
			-- "ss19", -- Adds gaps in ≠ ≠= == === ligatures.
			"ss20", -- Shift horizontal stroke in f to match x-height
			-- "cv01", -- l with symmetrical lower stroke. (ss01)
			"cv02", -- t with curly tail (ss02)
			"cv03", -- g with more complex construction
			"cv04", -- j with curly descender
			"cv05", -- l with curly tail (ss02)
			"cv06", -- m with shorter middle leg (ss02)
			"cv07", -- Ww with lower middle peak (ss02)
			-- "cv08", -- Kk with sharp connection (ss01)
			-- "cv09", -- f with additional horizontal stroke. (ss01)
			-- "cv10", -- r with more open construction (ss01)
			"cv11", -- y with different ascender construction (ss01)
			-- "cv12", -- u with traditional construction (ss01)
			"cv14", -- $ with broken bar
			"cv15", -- & alternative ampersand
			"cv16", -- Q with bent tail
			"cv17", -- f with curly ascender (ss02)
			-- "cv18", -- 269 variant
			-- "cv19", -- 8 old variant
			-- "cv20", -- 5 old variant
			-- "cv99", -- highlights cyrillic C and c for debugging
		},
	}),
}
