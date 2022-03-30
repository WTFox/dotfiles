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
hs.hotkey.bind('rightctrl', "Z", open_app("Visual Studio Code"))
hs.hotkey.bind('rightctrl', "X", open_app("iTerm"))
hs.hotkey.bind('rightctrl', "C", open_app("Brave Browser"))
hs.hotkey.bind('rightctrl', "M", open_app("Google Meet"))
