return {
    mouseWatcher = hs.usb.watcher.new(function(deviceTable)
        if (deviceTable.eventType == "added" and deviceTable.productName == "Microsoft Pro Intellimouse") then
            hs.mouse.trackingSpeed(0.0)
            if deviceTable.eventType == "added" and deviceTable.productName == "Logitech::USB Receiver" then
                hs.mouse.trackingSpeed(0.6875)
            end
        end
    end)
}
