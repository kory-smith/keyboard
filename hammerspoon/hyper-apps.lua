-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

local bindingsList = {
  { 'b', 'Brave Browser' },             -- "B" for "Browser"
  { 'c', 'Google Chrome' },             -- "c" for "Containers"
  { 'd', 'Dashlane' },             -- "d" for "Dashlane"
  { 'e', 'Visual Studio Code' },             -- "E" for "editor"
  { 'f', 'Finder' },            -- "F" for "Finder"
  { 'n', 'Notion' },            -- "n" for "Notebook"
  { 't', 'Todoist'},
  { 'x', function()
          if 
            hs.application.get("OpenOffice")
          then
            hs.application.launchOrFocus("OpenOffice")
          else
            hs.application.launchOrFocus("OpenOffice")
            hs.timer.doAfter
            (1, function()
                  hs.eventtap.keyStroke(null, "s")
                end)
          end
        end},            -- "Y" for "YNAB"
  { 'y', 'YNAB' },            -- "Y" for "YNAB"
  { 'return', 'iTerm' },
}

-- Work computer bindings
if hs.host.localizedName() == "OF014X1C3UJG5JI" then
  bindingsList = {
    { 'b', 'Google Chrome' },             -- "B" for "Browser"
    { 'c', 'Microsoft Teams' },             -- "c" for "chat"
    { 'e', 'Visual Studio Code' },             -- "E" for "editor"
    { 'f', 'Finder' },            -- "F" for "Finder"
    { 'g', 'Fork' },             -- "E" for "editor"
    { 'm', 'Microsoft Outlook' },       -- "M" for "eMail"
    { 'n', 'Notion' },            -- "n" for "Notebook"
    { 'p', 'Join' },             -- "g" for "Google"
    { 't', 'Todoist'},
    { 'x', 'Microsoft Excel' },             -- "x" for "Excel"
    { 'y', 'YNAB' },            -- "Y" for "YNAB"
    { 'z', 'zoom.us' },             -- "z" for "Zoom"
    { 'return', 'iTerm' },
  }
end

return bindingsList
