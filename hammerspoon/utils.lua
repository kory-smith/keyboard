

hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "d", function() hs.osascript.applescript([[
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

hs.hotkey.bind({'ctrl', 'shift', 'cmd', 'alt'}, "l", function() hs.caffeinate.lockScreen() end)