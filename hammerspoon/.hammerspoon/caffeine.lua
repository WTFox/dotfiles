local caffeine = hs.menubar.new()
if not caffeine then
	return
end

local function setCaffeineDisplay(state)
	if state then
		caffeine:setTitle("AWAKE")
	else
		caffeine:setTitle("SLEEPY")
	end
end

local function caffeineClicked()
	setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
	caffeine:setClickCallback(caffeineClicked)
	setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
