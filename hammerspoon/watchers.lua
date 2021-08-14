local engageWithTunnel = function(connectOrDisconnect)
    local _, status = hs.osascript.applescript([[
        tell application "Tunnelblick"
        get state of first configuration
        end tell
        ]])
    if (connectOrDisconnect == "connect" and status == "EXITING") then
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
    if (connectOrDisconnect == "disconnect" and status == "CONNECTED") then
        hs.osascript.applescript([[
            tell application "Tunnelblick"
            get name of first configuration
            disconnect result
          end tell
        ]])
    end
end

return {
    mouseWatcher = hs.usb.watcher.new(function(deviceTable)
        if (deviceTable.eventType == "added" and deviceTable.productName == "Microsoft Pro Intellimouse") then
            hs.mouse.trackingSpeed(0.0)
            if deviceTable.eventType == "added" and deviceTable.productName == "Logitech::USB Receiver" then
                hs.mouse.trackingSpeed(0.6875)
            end
        end
    end),

    wifiWatcher = hs.wifi.watcher.new(function(watcher, a, b)
        if (hs.wifi.currentNetwork() ~= "Pie-fi-5G" and hs.network.interfaceDetails() ~= "nil")
        or (hs.wifi.currentNetwork() ~= "Platypus Cave 5G" and hs.network.interfaceDetails() ~= "nil") then
            engageWithTunnel("connect")
        end
        if (hs.wifi.currentNetwork() == "Pie-fi-5G") or (hs.wifi.currentNetwork() == "Platypus Cave 5G") then
            engageWithTunnel("disconnect")
        end
    end)
}
