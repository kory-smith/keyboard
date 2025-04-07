-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

-- This enables directional vim-like movement. Taken from https://www.hammerspoon.org/docs/hs.window.filter.html#focusWindowEast
local windowFilter = hs.window.filter.new()
windowFilter:setCurrentSpace(true)

local bindingsList = {
  { 'b', 'Firefox' },                 -- "B" for "Browser"
  { 'd', 'Discord' },                 -- "D" for "Discord"
  { 'f', 'Finder' },                  -- "F" for "Finder"
  { 'g', 'Fork' },                    -- "G" for "Git GUI"
  { 'i', 'Obsidian' },                    -- "I" for "obsIdian"
  { 'n', 'Notion' },                  -- "N" for "Notion"
  { 'o', 'Spotify' },                -- "O" for "spOtify"
  { 'p', 'Dashlane' },                -- "P" for "Password Manager"
  { 'r', 'Miniflux' },                -- "R" for "Rss Reader"
  { 's', 'Messages' },              -- "S" for "SMS client"
  { 't', 'Todoist'},                  -- "T" for "Todoist"
  { 'y', 'YNAB' },                    -- "Y" for "YNAB"
  { 'z', 'zoom.us' },                   -- "Z" for "Zoom"
  { 'return', 'ghostty' },
  -- Vim-like hjkl keys to move focus from windows directionally
  { 'h', function()
          windowFilter:focusWindowWest(nil, true)
         end
  },
  { 'j', function()
          windowFilter:focusWindowSouth(nil, true)
         end
  },
  { 'k', function()
          windowFilter:focusWindowNorth(nil, true)
         end
  },
  { 'l', function()
          windowFilter:focusWindowEast(nil, true)
         end
  },
}

local personalBindings = {
    { 'x', 'LibreOffice' },           -- "x" for "Excel"
    {"e", "Cursor"}                   -- "E" for "editor"
}

local workBindings = {
  { 'c', 'Microsoft Teams' },           -- "C" for "Chat"
  { 'e', 'Visual Studio Code' },      -- "E" for "editor"
  { 'm', 'Microsoft Outlook' },         -- "M" for "eMail"
  { 'x', 'Microsoft Excel' },           -- "x" for "Excel"
}

local workComputerName = "OF060D91LFYXMHG"
if hs.host.localizedName() == workComputerName then
  bindingsList = hs.fnutils.concat(bindingsList, workBindings)  
else
  bindingsList = hs.fnutils.concat(bindingsList, personalBindings)  
end

return bindingsList
