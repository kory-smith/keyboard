isScreenLocked = false;

local engageWithTunnel = function(connectOrDisconnect)
    if (connectOrDisconnect == "connect") then
        hs.osascript.applescript([[
            tell application "Tunnelblick"
            get name of first configuration
            connect result
            repeat until result = "CONNECTED"
              delay 1
              get state of first configuration
            end repeat
          end tell
        ]])
    end
    if (connectOrDisconnect == "disconnect") then
        hs.osascript.applescript([[
            tell application "Tunnelblick"
            get name of first configuration
            disconnect result
          end tell
        ]])
    end
end

    if isScreenLocked then
        return false
    end
    local _, status = hs.osascript.applescript([[
        tell application "Tunnelblick"
        get state of first configuration
        end tell
        ]])
    local isAtTrustedPlace = 
        (hs.wifi.currentNetwork() == "Pie-fi-5G" or
        hs.wifi.currentNetwork() == "Platypus Cave 5G" or
        hs.wifi.currentNetwork() == "Pie-fi")
    local isWifiEnabled = hs.network.interfaceDetails() ~= "nil"
    return not (isAtTrustedPlace and isWifiEnabled and status == "CONNECTED")
end

return {
    mouseWatcher = hs.usb.watcher.new(function(deviceTable)
        if (deviceTable.eventType == "added" and deviceTable.productName == "Microsoft Pro Intellimouse") then
            hs.mouse.trackingSpeed(0.0)
            if deviceTable.eventType == "added" and deviceTable.productName == "Logitech::USB Receiver" then
                hs.mouse.trackingSpeed(0.6875)
            end
        end
    end)
    :start(),

    screenWatcher = hs.caffeinate.watcher.new(function(screenState)
        if screenState == hs.caffeinate.watcher.screensDidUnlock then
            isScreenLocked = false;
        else if screenState == hs.caffeinate.watcher.screensDidLock then
            isScreenLocked = true;
            end
        end
    end) 
    :start(),

    wifiWatcher = hs.wifi.watcher.new(function()
        if shouldConnectToVPN() then
            engageWithTunnel("connect")
        else
            engageWithTunnel("disconnect")
        end
    end)
    :start()
}
