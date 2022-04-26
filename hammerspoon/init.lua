--- start quick open applications
local function open_app(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

--- quick open applications
hs.hotkey.bind({ 'ctrl', 'shift' }, "Z", open_app("Visual Studio Code"))
hs.hotkey.bind({ 'ctrl', 'shift' }, "X", open_app("iTerm"))
hs.hotkey.bind({ 'ctrl', 'shift' }, "C", open_app("Brave Browser"))
hs.hotkey.bind({ 'ctrl', 'shift' }, "M", open_app("Google Meet"))

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
