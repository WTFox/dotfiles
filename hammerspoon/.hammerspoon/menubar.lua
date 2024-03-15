CAFFEINE = hs.menubar.new()

function setCaffeineDisplay(state)
	if state then
		CAFFEINE:setTitle("AWAKE")
	else
		CAFFEINE:setTitle("SLEEPY")
	end
end

function caffeineClicked()
	setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if CAFFEINE then
	CAFFEINE:setClickCallback(caffeineClicked)
	setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
