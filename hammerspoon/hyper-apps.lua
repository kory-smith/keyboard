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
  { 'x', 'OpenOffice' },            -- "Y" for "YNAB"
  { 'y', 'YNAB' },            -- "Y" for "YNAB"
  { 'return', 'iTerm' },
}

-- Work computer bindings
if hs.host.localizedName() == "OF014X1C3UJG5JI" then
  bindingsList = {
    { 'c', 'Microsoft Teams' },             -- "c" for "chat"
    { 'b', 'Google Chrome' },             -- "B" for "Browser"
    { 'e', 'Visual Studio Code' },             -- "E" for "editor"
    { 't', 'Todoist'},
    { 'y', 'YNAB' },            -- "Y" for "YNAB"
    { 'n', 'Notion' },            -- "n" for "Notebook"
    { 'f', 'Finder' },            -- "F" for "Finder"
    { 'm', 'Microsoft Outlook' },       -- "M" for "eMail"
    { 'p', 'Pushbullet' },             -- "g" for "Google"
    { 'x', 'Microsoft Excel' },             -- "x" for "Excel"
    { 'z', 'zoom.us' },             -- "z" for "Zoom"
    { 'return', 'iTerm' },
  }
end

return bindingsList
