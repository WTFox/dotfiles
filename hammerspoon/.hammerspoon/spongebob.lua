-- e.g., "hello" -> "hElLo"

local function spongebobCase(str)
	local result = ""
	local up = false
	for i = 1, #str do
		local c = str:sub(i, i)
		if up then
			result = result .. c:upper()
		else
			result = result .. c:lower()
		end
		if c:match("%a") then
			up = not up
		end
	end
	return result
end

hs.hotkey.bind({ "ctrl", "cmd", "shift" }, "v", function()
	local str = hs.pasteboard.getContents()
	if str then
		local text = spongebobCase(str)
		text = "¡¡¡ " .. text .. " !!!"

		hs.pasteboard.setContents(text)
		hs.eventtap.keyStrokes(hs.pasteboard.getContents())
	end
end)
