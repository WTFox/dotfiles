-- Google Meet
local function FocusGoogleMeet()
    hs.application.launchOrFocus('Google Meet')
end

-- home key is global mute
hs.hotkey.bind({}, 'home', function()
    FocusGoogleMeet()
    hs.eventtap.keyStroke({ "cmd" }, "d", 200)
end
)

-- page up key is global enable/disable video
hs.hotkey.bind({}, 'pageup', function()
    FocusGoogleMeet()
    hs.eventtap.keyStroke({ "cmd" }, "e", 200)
end
)
