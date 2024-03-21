-- e.g., "hello" -> "hElLo"

local function spongebobCase(str)
	local result = ""
	for i = 1, #str do
		local char = string.sub(str, i, i)
		if i % 3 == 0 then
			char = string.upper(char)
		else
			char = string.lower(char)
		end
		result = result .. char
	end
	return result
end

hs.hotkey.bind({ "ctrl", "cmd", "shift" }, "v", function()
	local text = hs.pasteboard.getContents()
	if not text then
		return
	end

	text = spongebobCase(text)
	hs.pasteboard.setContents(text)
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
