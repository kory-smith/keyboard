-- Spoon installation and configuration
-----------------------------------------------
SpoonInstall = hs.loadSpoon("SpoonInstall")
SpoonInstall.use_syncinstall = true
SpoonInstall:andUse("KSheet")

menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

KSheet = hs.loadSpoon("KSheet")
KSheet:init()
KSheet:bindHotkeys({toggle = {{'ctrl', 'cmd', 'alt'}, "/"}})
-----------------------------------------------
local log = hs.logger.new('init.lua', 'debug')

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind({'ctrl'}, '`', nil, function()
    hs.reload()
end)

-- Hyper and Shyper ; replace cmd `
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, ';', nil, function()
    hs.eventtap.keyStroke("cmd", "`")
end)

hs.hotkey.bind({'ctrl', 'alt', 'cmd', 'shift'}, ';', nil, function()
    hs.eventtap.keyStroke({"cmd", "shift"}, "`")
end)

keyUpDown = function(modifiers, key)
    -- Un-comment & reload config to log each keystroke that we're triggering
    -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

    hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
    windowFilter:subscribe(hs.window.filter.windowFocused, function()
        hotkey:enable()
    end)

    windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
        hotkey:disable()
    end)
end

-- require('keyboard.delete-words')
-- require('keyboard.microphone')
-- require('keyboard.control-escape')
require('keyboard.hyper')
require('keyboard.markdown')
require('keyboard.panes')
require('keyboard.utils')
require('keyboard.watchers')
-- require('keyboard.windows')

hs.notify.new({
    title = 'Hammerspoon',
    informativeText = '🤖 Operational'
}):send()
