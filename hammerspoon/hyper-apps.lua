-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

local bindingsList = {
  { 'd', 'Discord' },                 -- "D" for "Discord"
  { 'e', 'Visual Studio Code' },      -- "E" for "editor"
  { 'f', 'Finder' },                  -- "F" for "Finder"
  { 'g', 'Fork' },                    -- "G" for "Git GUI"
  { 'j', 'Join' },                    -- "J" for "Join"
  { 'n', 'Notion' },                  -- "N" for "Notion"
  { 'o', 'Obsidian' },                -- "O" for "Obsidian"
  { 't', 'Todoist'},                  -- "T" for "Todoist"
  { 'y', 'YNAB' },                    -- "Y" for "YNAB"
  { 'z', 'zoom.us' },                   -- "Z" for "Zoom"
  { 'return', 'iTerm' },
}

local personalBindings = {
  { 'b', 'Brave Browser' },           -- "B" for "Browser"
  { 'c', 'Google Chrome' },           -- "C" for "Chrome"
  { 'd', 'Dashlane' },                -- "D" for "Dashlane"
  {'x', function()
    if hs.application.get("OpenOffice") then
        hs.application.launchOrFocus("OpenOffice")
    else
        hs.application.launchOrFocus("OpenOffice")
        hs.timer.doAfter(1, function()
            hs.eventtap.keyStroke(null, "s")
        end)
    end
end},
}

local workBindings = {
  { 'b', 'Google Chrome' },             -- "B" for "Browser"
  { 'c', 'Microsoft Teams' },           -- "C" for "Chat"
  { 'm', 'Microsoft Outlook' },         -- "M" for "eMail"
  { 't', 'Todoist'},
  { 'x', 'Microsoft Excel' },           -- "x" for "Excel"
}

-- Work computer name
if hs.host.localizedName() == "OF014X1C3UJG5JI" then
  bindingsList = hs.fnutils.concat(bindingsList, workBindings)  
else
  bindingsList = hs.fnutils.concat(bindingsList, personalBindings)  
end

return bindingsList
