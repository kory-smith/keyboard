-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

-- This enables directional vim-like movement. Taken from https://www.hammerspoon.org/docs/hs.window.filter.html#focusWindowEast
local windowFilter = hs.window.filter.new()
windowFilter:setCurrentSpace(true)

local bindingsList = {
  { 'd', 'Discord' },                 -- "D" for "Discord"
  { 'e', 'Visual Studio Code' },      -- "E" for "editor"
  { 'f', 'Finder' },                  -- "F" for "Finder"
  { 'g', 'Fork' },                    -- "G" for "Git GUI"
  { 'n', 'Notion' },                  -- "N" for "Notion"
  { 'o', 'Obsidian' },                -- "O" for "Obsidian"
  { 'p', 'Dashlane' },                -- "P" for "Password Manager"
  { 's', 'Messages' },              -- "S" for "SMS client"
  { 't', 'Todoist'},                  -- "T" for "Todoist"
  { 'x', 'Microsoft Excel' },           -- "x" for "Excel"
  { 'y', 'YNAB' },                    -- "Y" for "YNAB"
  { 'z', 'zoom.us' },                   -- "Z" for "Zoom"
  { 'return', 'iTerm' },
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
  { 'b', 'Brave Browser' },           -- "B" for "Browser"
}

local workBindings = {
  { 'b', 'Google Chrome' },             -- "B" for "Browser"
  { 'c', 'Microsoft Teams' },           -- "C" for "Chat"
  { 'm', 'Microsoft Outlook' },         -- "M" for "eMail"
}

local workComputerName = "OF014X1C3UJG5JI"
if hs.host.localizedName() == workComputerName then
  bindingsList = hs.fnutils.concat(bindingsList, workBindings)  
else
  bindingsList = hs.fnutils.concat(bindingsList, personalBindings)  
end

return bindingsList
