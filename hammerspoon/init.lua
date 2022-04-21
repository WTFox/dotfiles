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
