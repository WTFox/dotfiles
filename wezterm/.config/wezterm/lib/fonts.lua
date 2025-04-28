local wezterm = require("wezterm") --[[@as Wezterm]]

return {
	berkeley_mono = {
		family = "Berkeley Mono",
		weight = "Regular",
		harfbuzz_features = {
			"liga",
			-- "ss01",
			-- "ss02",
			-- "zero",
		},
	},
	cascadia_code = {
		family = "Cascadia Code",
		weight = "Regular",
	},
	maple_mono = {
		family = "Maple Mono",
		weight = "Light",
		harfbuzz_features = {
			"calt", -- enable ligatures
			-- "zero", -- dotted 0
			-- "cv01", -- remove gaps from symbols @
			"cv02", -- alt a
			"cv03", -- alt i
			-- "cv04", -- alt l
			-- block: italic only --
			"cv31", -- alt a
			"cv32", -- alt f
			-- "cv33", -- alt i and j
			"cv34", -- alt k
			-- "cv35", -- alt l
			-- "cv36", -- alt x
			-- "cv37", -- alt y
			-- end block --
			-- "ss01", -- break up == === != !==
			-- "ss02", -- break >= and ==
			"ss03", -- enable arbitrary tag todo))
			-- "ss04", -- break multi underscore __
			"ss05", -- thin escape backslash \n
			-- "ss06", -- break connected strokes
			"ss07", -- enable >>>
			"ss08", -- =>>
		},
	},
	operator_mono = {
		family = "Operator Mono",
		weight = "Book",
		harfbuzz_features = {
			"calt",
			"clig",
			"liga",
		},
	},
	jetbrains_styled = {
		family = "JetBrains Mono",
		weight = "Regular",
		harfbuzz_features = {
			"calt", -- Contains all ligatures. Substitution for : between digits
			"clig",
			"liga",
			"zero", -- Changes 0 to slashed variant.
			-- "frac", -- Substitute digits in fraction sequences to look more like fractions.
			-- "ss01", -- All classic construction. JetBrains Mono but even more neutral. Performs better in big paragraph of text.
			-- "ss02", -- All closed construction. Change the rhythm to a more lively one.
			-- "ss19", -- Adds gaps in ≠ ≠= == === ligatures.
			-- "ss20", -- Shift horizontal stroke in f to match x-height
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
			"cv12", -- u with traditional construction (ss01)
			"cv14", -- $ with broken bar
			"cv15", -- & alternative ampersand
			"cv16", -- Q with bent tail
			"cv17", -- f with curly ascender (ss02)
			"cv18", -- 269 variant
			-- "cv19", -- 8 old variant
			"cv20", -- 5 old variant
			-- "cv99", -- highlights cyrillic C and c for debugging
		},
	},
	jetbrains = {
		family = "JetBrains Mono",
		weight = "Regular",
		harfbuzz_features = {
			"calt",
			"clig",
			"liga",
			"cv15", -- & alternative ampersand
		},
	},
	monolisa = {
		family = "MonoLisa",
		weight = "Regular",
		harfbuzz_features = {
			"calt",
			"zero", -- slashed zero
			"liga", -- ligatures
			-- "ss01", -- alt *
			"ss02", -- alt f
			-- "ss03", -- alt g
			-- "ss04", -- alt g
			-- "ss05", -- alt sharp s
			-- "ss06", -- alt @
			"ss07", -- alt {}
			"ss08", -- alt ()
			-- "ss09", -- alt >=
			"ss10", -- alt >=
			"ss11", -- alt hex, e.g. 0x234
			-- "ss12", -- thin backslash \\
			"ss13", -- alt $
			"ss14", -- alt &
			"ss15", -- alt i (no seriffs)
			"ss16", -- alt r (no seriffs)
			-- "ss17", -- alt .= and ..=
			-- "ss18", -- alt @
		},
	},
	fira = {
		family = "Fira Code",
		weight = "Regular",
		harfbuzz_features = {
			"zero",
			-- "ss01",
			"ss02",
			"ss04",
			"ss06",
			"ss09",
			-- "ss10",
			-- "ss19",
			-- "ss20",
			-- "cv01",
			-- "cv02",
			-- "cv03",
			-- "cv04",
			-- "cv05",
			"cv06",
			-- "cv07",
			-- "cv08",
			-- "cv09",
			-- "cv10",
			-- "cv11",
			-- "cv12",
			-- "cv14",
			-- "cv15",
			-- "cv16",
			-- "cv17",
			-- "cv18",
			-- "cv19",
			-- "cv20",
			"cv26",
			"cv27",
			"cv30",
			-- "cv31",
			-- "cv99",
		},
	},
	mononoki = {
		family = "mononoki",
		weight = "Regular",
		harfbuzz_features = {
			-- "ss01",
		},
	},
}
