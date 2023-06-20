hs.grid.setGrid("10x10")
hs.grid.setMargins("0,0")
hs.window.animationDuration = 0

local dimensions = {
	topRightQuarter = "5,0 5x5",
	bottomRightQuarter = "5,5 5x5",
	topLeftQuarter = "0,0 5x5",
	bottomLeftQuarter = "0,5 5x5",
	leftSixth = "0,0 2x10",
	rightSixth = "8,0 2x10",
	leftHalf = "0,0 5x10",
	rightHalf = "5,0 5x10",
	leftTwoThirds = "0,0 6x10",
	rightTwoThirds = "4,0 6x10",
	left75 = "0,0 8x10",
	right75 = "2,0 8x10",
	center = "1,1 8x8",
}

local mappings = {
	{ key = "m", gridValue = dimensions.center },
	{ key = "h", gridValue = dimensions.leftHalf },
	{ key = "l", gridValue = dimensions.rightHalf },
	{ key = "u", gridValue = dimensions.topLeftQuarter },
	{ key = "j", gridValue = dimensions.bottomLeftQuarter },
	{ key = "i", gridValue = dimensions.topRightQuarter },
	{ key = "k", gridValue = dimensions.bottomRightQuarter },
	{ key = "q", gridValue = dimensions.leftTwoThirds },
	{ key = "w", gridValue = dimensions.rightTwoThirds },
	{ key = "d", gridValue = dimensions.leftSixth },
	{ key = "g", gridValue = dimensions.rightSixth },
	{ key = ",", gridValue = dimensions.left75 },
	{ key = ".", gridValue = dimensions.right75 },
}

for _, value in ipairs(mappings) do
	hs.hotkey.bind(MASH, value.key, function()
		hs.grid.set(hs.window.focusedWindow(), value.gridValue)
	end)
end
