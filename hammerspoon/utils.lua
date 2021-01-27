
-- This binds shyper-o to copy the outlook URI of a message.
hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "o", function() hs.osascript.applescript([[
  tell application "Microsoft Outlook"
	set selectedMessages to selected objects
	if selectedMessages is {} then
		display notification "Please select a message in Outlook before running the script!"
	else
		set messageId to id of item 1 of selectedMessages
		set uri to "outlook://" & messageId
		set the clipboard to uri
		display notification "URI " & uri & " copied to clipboard"
	end if
end tell
]])
end)

-- shyper + c will clear all notifications
hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "c", function() hs.osascript.applescript([[
	my closeNotifications()
on closeNotifications()
	tell application "System Events" to tell process "Notification Center"
		set theWindows to every window
		repeat with i from 1 to number of items in theWindows
			set this_item to item i of theWindows
			try
				click button 1 of this_item
			on error
				my closeNotifications()
			end try
		end repeat
	end tell
end closeNotifications
]])
end)

-- shyper + d will toggle DND status and alert me
hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "d", function() 
	dndStatus = hs.execute("~/bin/do-not-disturb status"):gsub("\n$", "")
		if dndStatus == "off" then
			hs.alert.show("Do not disturb enabled")
			hs.execute("~/bin/do-not-disturb on")
		else
			hs.alert.show("Do not disturb disabled")
			hs.execute("~/bin/do-not-disturb off")
		end
end)

hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "l", function() hs.caffeinate.lockScreen() end)

hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "r", function() hs.osascript.applescript([[
	tell application "System Events"
	tell process "NotificationCenter"
		click menu button 1 of window 1
	end tell
end tell
	]])
end)