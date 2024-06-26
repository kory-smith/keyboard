
local status, envVars = pcall(require, 'keyboard.env')

if not status then
  envVars = require('keyboard.env')
end

----------------------------------------------------------------------------------------------------
--------------------------------------- General Config ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- If enabled, the menus will appear over full screen applications.
-- However, the Hammerspoon dock icon will also be disabled (required for fullscreen).
menuShowInFullscreen = true

-- If enabled, a menu bar item will appear that shows what menu is currently being displayed or
-- "idle" if no menu is open.
showMenuBarItem = false

-- The number of seconds that a hotkey alert will stay on screen.
-- 0 = alerts are disabled.
hs.hotkey.alertDuration = 0

-- Show no titles for Hammerspoon windows.
hs.hints.showTitleThresh = 0

-- Disable animations
hs.window.animationDuration = 0

-- Editor path
menuTextEditor = "/usr/local/bin/emacsclient -c"

-- Location of the askpass executable.  Required for running script with admin privs.
askpassLocation = "/usr/local/bin/ssh-askpass"

----------------------------------------------------------------------------------------------------
----------------------------------------- Menu options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The number of columns to display in the menus.  Setting this too high or too low will
-- probably have odd results.
menuNumberOfColumns = 5

-- The minimum number of rows to show in menus
menuMinNumberOfRows = 4

-- The height of menu rows in pixels
menuRowHeight = 25

-- The padding to apply to each side of the menu
menuOuterPadding = 70

----------------------------------------------------------------------------------------------------
----------------------------------------- Font options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- The font to apply to menu items.
menuItemFont = "Menlo"

-- The font size to apply to menu items.
menuItemFontSize = 15

-- The text alignment to apply to menu items.
menuItemTextAlign = "left"

----------------------------------------------------------------------------------------------------
---------------------------------------- Color options ---------------------------------------------
----------------------------------------------------------------------------------------------------

menuItemColors = {
    -- The default colors to use.
    default = {
        background = "#000000",
        text = "#aaaaaa"
    },
    -- The colors to use for the Exit menu item
    exit = {
        background = "#000000",
        text = "#C1666B"
    },
    -- The colors to use for the Back menu items
    back = {
        background = "#000000",
        text = "#E76F51"
    },
    -- The colors to use for menu menu items
    submenu = {
        background = "#000000",
        text = "#9A879D"
    },
    -- The colors to use for navigation menu items
    navigation = {
        background = "#000000",
        text = "#4281A4"
    },
    -- The colors to use for empty menu items
    empty = {
        background = "#000000",
        text = "#aaaaaa"
    },
    -- The colors to use for action menu items
    action = {
        background = "#000000",
        text = "#7A3B69"
    },
    menuBarActive = {
        background = "#ff0000",
        text = "#000000"
    },
    menuBarIdle = {
        background = "#00ff00",
        text = "#000000"
    },
    display = {
        background = "#000000",
        text = "#48A9A6"
    }
}

----------------------------------------------------------------------------------------------------
-------------------------------------- Menu bar options --------------------------------------------
----------------------------------------------------------------------------------------------------

-- Key bindings

-- The hotkey that will enable/disable MenuHammer
menuHammerToggleKey = {{"cmd", "shift", "ctrl"}, "Q"}

-- Menu Prefixes
menuItemPrefix = {
    action = '↩',
    submenu = '→',
    back = '←',
    exit = 'x',
    navigation = '↩',
    -- navigation = '⎋',
    empty = '',
    display = '',
}

-- Menu item separator
menuKeyItemSeparator = ": "

----------------------------------------------------------------------------------------------------
----------------------------------------- Kory's options ---------------------------------------------
----------------------------------------------------------------------------------------------------

-- Non-work laptop toggle items
local dynamicToggleMenuItems = {            
    {cons.cat.action, '', 'V', "Toggle VPN", {
        {cons.act.func, function() 
            local currentWindow = hs.application.frontmostApplication()
            hs.inspect(print(currentWindow.name))
            hs.application.launchOrFocus("Wireguard")
            hs.eventtap.keyStroke("CMD", "T")
            currentWindow:activate()
        end}
    }},
    {cons.cat.action, '', 'W', "Enable wi-fi", {
        {cons.act.func, function() hs.wifi.setPower(true) end }
    }},
    {cons.cat.action, 'shift', 'W', "Disable wi-fi", {
        {cons.act.func, function() hs.wifi.setPower(false) end }
    }},
}

-- Work laptop toggle items
if hs.host.localizedName() == "OF060D91LFYXMHG" then
    dynamicToggleMenuItems = {            
        {cons.cat.action, '', 'D', "Enable DND", {
            {cons.act.func, function() 
                hs.alert.show("Do not disturb enabled")
                hs.execute("~/bin/do-not-disturb on")
                end}
        }},
        {cons.cat.action, 'Shift', 'D', "Disable DND", {
            {cons.act.func, function() 
                hs.alert.show("Do not disturb disabled")
                hs.execute("~/bin/do-not-disturb off")
           end}
        }},
        {cons.cat.action, '', 'M', "Enable Mouse Mover", {
            {cons.act.func, function() 
                mouseMode = 1
                hs.timer.doWhile(function() return mouseMode == 1 end, function() 
                    hs.mouse.setRelativePosition({x = 15, y = 15})
                    hs.mouse.setRelativePosition({x = 1050, y = 1005})
                end) 
           end},
        }},
        {cons.cat.action, 'Shift', 'M', "Disable Mouse Mover", {
            {cons.act.func, function() 
                mouseMode = 0
           end},
        }},
        {cons.cat.action, '', 'V', "Enable VPN", {
            {cons.act.func, function() 
                hs.application.launchOrFocus("Zscaler")
                end}
        }},
        {cons.cat.action, 'shift', 'V', "Disable VPN", {
            {cons.act.func, function() hs.osascript.applescript([[
                -- ignoring application responses
                tell application "Keyboard Maestro Engine"
                do script "553704FA-00EC-4478-98DD-4DBE0F15BD88"
                -- or: do script "Kill Zscaler"
                -- or: do script "553704FA-00EC-4478-98DD-4DBE0F15BD88" with parameter "Whatever"
                end tell
                -- end ignoring
            ]])
              end}
        }},
        {cons.cat.action, '', 'W', "Enable wi-fi", {
            {cons.act.func, function() hs.wifi.setPower(true) end }
        }},
        {cons.cat.action, 'shift', 'W', "Disable wi-fi", {
            {cons.act.func, function() hs.wifi.setPower(false) end }
        }},
    } 
end

----------------------------------------------------------------------------------------------------
--------------------------------------- Default Menus ----------------------------------------------
----------------------------------------------------------------------------------------------------

-- Menus
local mainMenu = "mainMenu"

-- Help menu
local helpMenu = "helpMenu"

-- Applications Menus
local applicationMenu = "applicationMenu"
local utilitiesMenu = "utilitiesMenu"

-- Browser menus
local browserMenu = "browserMenu"

-- Bookmark menus
local bookmarkMenu = "bookmarkMenu"

-- Bookmark menus
local workBookmarkMenu = "workBookmarkMenu"

-- Documents menu
local documentsMenu = "documentsMenu"

-- Finder menu
local finderMenu = "finderMenu"

-- Games menu
local gamesMenu = "gamesMenu"

-- Hammerspoon menu
local hammerspoonMenu = "hammerspoonMenu"

-- Help menu
local helpMenu = "helpMenu"

-- Layout menu
local layoutMenu = "layoutMenu"

-- Media menu
local mediaMenu = "mediaMenu"

-- Scripts menu
local scriptsMenu = "scriptsMenu"

-- System menus
local systemMenu = "systemMenu"

-- Text menu
local textMenu = "textMenu"

-- Toggles menu
local toggleMenu = "toggleMenu"

local phoneMenu = "phoneMenu"

-- Window menu
local resizeMenu = "resizeMenu"

menuHammerMenuList = {

    ------------------------------------------------------------------------------------------------
    -- Main Menu
    ------------------------------------------------------------------------------------------------
    [mainMenu] = {
        parentMenu = nil,
        menuHotkey = {{'cmd','ctrl','alt'}, 'space'},
        menuItems = {
            {cons.cat.submenu, 'shift', '/', 'Help', {
                {cons.act.menu, helpMenu}
            }},
            -- {cons.cat.submenu, '', 'A', 'Applications', {
            --     {cons.act.menu, applicationMenu}
            -- }},
            {cons.cat.submenu, '', 'B', 'Bookmarks', {
                {cons.act.menu, bookmarkMenu}
            }},
            {cons.cat.submenu, '', 'D', 'Documents', {
                 {cons.act.menu, documentsMenu}
            }},
            {cons.cat.submenu, '', 'F', 'Finder', {
                {cons.act.menu, finderMenu}
            }},
            -- {cons.cat.submenu, '', 'G', 'Games', {
            --      {cons.act.menu, gamesMenu}
            -- }},
            {cons.cat.submenu, '', 'H', 'Hammerspoon', {
                {cons.act.menu, hammerspoonMenu}
            }},
            -- {cons.cat.submenu, '', 'L', 'Layouts', {
            --      {cons.act.menu, layoutMenu}
            -- }},
            {cons.cat.submenu, '', 'M', 'Media Controls', {
                {cons.act.menu, mediaMenu}
            }},
            {cons.cat.submenu, '', 'S', 'System Preferences', {
                {cons.act.menu, systemMenu}
            }},
            {cons.cat.submenu, '', 'P', 'Phone', {
                {cons.act.menu, phoneMenu}
            }},
            {cons.cat.submenu, '', 'T', 'Toggles', {
                 {cons.act.menu, toggleMenu}
            }},
            {cons.cat.submenu, '', 'W', 'Work Bookmarks', {
                {cons.act.menu, workBookmarkMenu}
            }},
            -- {cons.cat.submenu, '', 'X', 'Text', {
            --      {cons.act.menu, textMenu}
            -- }},
            {cons.cat.submenu, '', '/', 'Scripts', {
                 {cons.act.menu, scriptsMenu}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Help Menu
    ------------------------------------------------------------------------------------------------
    helpMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'H', "Hammerspoon Manual", {
                {cons.act.func, function()
                      hs.doc.hsdocs.forceExternalBrowser(true)
                      hs.doc.hsdocs.moduleEntitiesInSidebar(true)
                      hs.doc.hsdocs.help()
                end }
            }},
            {cons.cat.action, '', 'M', "MenuHammer Documentation", {
                {cons.act.openurl, 'https://github.com/FryJay/MenuHammer'},
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Application Menu
    ------------------------------------------------------------------------------------------------
    applicationMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', "App Store", {
                {cons.act.launcher, 'App Store'}
            }},
            {cons.cat.action, '', 'C', "Chrome", {
                {cons.act.launcher, 'Google Chrome'}
            }},
            {cons.cat.action, '', 'D', "Microsoft Remote Desktop", {
                {cons.act.launcher, 'Microsoft Remote Desktop'}
            }},
            {cons.cat.action, '', 'F', "Finder", {
                {cons.act.launcher, 'Finder'}
            }},
            {cons.cat.action, '', 'H', "Firefox", {
                {cons.act.launcher, 'Firefox'}
            }},
            {cons.cat.action, '', 'I', "iTerm", {
                {cons.act.launcher, 'iTerm'}
            }},
            {cons.cat.action, '', 'K', "Karabiner", {
                {cons.act.launcher, 'Karabiner-Elements'}
            }},
            {cons.cat.action, '', 'L', "Sublime Text", {
                {cons.act.launcher, 'Sublime Text'}
            }},
            {cons.cat.action, '', 'M', "MacVim", {
                {cons.act.launcher, 'MacVim'}
            }},
            {cons.cat.action, '', 'S', "Safari", {
                {cons.act.launcher, 'Safari'}
            }},
            {cons.cat.action, '', 'T', "Terminal", {
                {cons.act.launcher, 'Terminal'}
            }},
            {cons.cat.submenu, '', 'U', 'Utilities', {
                {cons.act.menu, utilitiesMenu}
            }},
            {cons.cat.action, '', 'X', "Xcode", {
                {cons.act.launcher, 'Xcode'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Utilities Menu
    ------------------------------------------------------------------------------------------------
    utilitiesMenu = {
        parentMenu = applicationMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', "Activity Monitor", {
                {cons.act.launcher, 'Activity Monitor'}
            }},
            {cons.cat.action, 'shift', 'A', "Airport Utility", {
                {cons.act.launcher, 'Airport Utility'}
            }},
            {cons.cat.action, '', 'C', "Console", {
                {cons.act.launcher, 'Console'}
            }},
            {cons.cat.action, '', 'D', "Disk Utility", {
                {cons.act.launcher, 'Disk Utility'}
            }},
            {cons.cat.action, '', 'K', "Keychain Access", {
                {cons.act.launcher, 'Keychain Access'}
            }},
            {cons.cat.action, '', 'S', "System Information", {
                {cons.act.launcher, 'System Information'}
            }},
            {cons.cat.action, '', 'T', "Terminal", {
                {cons.act.launcher, 'Terminal'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Browser Menu
    ------------------------------------------------------------------------------------------------
    browserMenu = {
        parentMenu = mainMenu,
        meunHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Chrome", {
                {cons.act.launcher, 'Google Chrome'}
            }},
            {cons.cat.action, '', 'F', "Firefox", {
                {cons.act.launcher, 'Firefox'}
            }},
            {cons.cat.action, '', 'M', 'Movie Lookup',
             {
                 {cons.act.userinput,
                  "movieLookup",
                  "Movie Lookup",
                  "Enter search criteria"},
                 {cons.act.openurl,
                  "http://www.google.com/search?q=@@movieLookup@@%20film%20site:wikipedia.org&meta=&btnI"
                 },
                 {cons.act.openurl,
                  "http://www.google.com/search?q=@@movieLookup@@%20site:imdb.com&meta=&btnI"
                 },
                 {cons.act.openurl,
                  "http://www.google.com/search?q=@@movieLookup@@%20site:rottentomatoes.com&meta=&btnI"
                 },
            }},
            {cons.cat.action, '', 'S', "Safari", {
                {cons.act.launcher, 'Safari'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Bookmark Menu
    ------------------------------------------------------------------------------------------------
    bookmarkMenu = {
        parentMenu = mainMenu,
        meunHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'B', "Goodreads", {
                {cons.act.openurl, "https://www.goodreads.com/" },
            }},
            {cons.cat.action, '', 'C', "MyChart", {
                {cons.act.openurl, "https://chpepiceweb.health-partners.org/MyChart/Authentication/Login?" },
            }},
            {cons.cat.action, '', 'G', "GitHub", {
                {cons.act.openurl, "https://github.com/" },
            }},
            {cons.cat.action, '', 'H', "HomeAssistant", {
                {cons.act.openurl, "http://homeassistant.local:8123/" },
            }},
            {cons.cat.action, '', 'L', "Shopping list", {
                {cons.act.openurl, "https://www.copymethat.com/shopping_list/" },
            }},
            {cons.cat.action, '', 'M', "MyFitnessPal", {
                {cons.act.openurl, "https://myfitnesspal.com/" },
            }},
            {cons.cat.action, '', 'R', "Reddit", {
                {cons.act.openurl, "https://old.reddit.com/" },
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Work Bookmark Menu
    ------------------------------------------------------------------------------------------------
    workBookmarkMenu = {
        parentMenu = mainMenu,
        meunHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Confluence", {
                {cons.act.openurl, "https://confluence.kroger.com/confluence/pages/viewpage.action?pageId=256980944" },
            }},
            {cons.cat.action, '', 'J', "Jira", {
                {cons.act.openurl, "https://jira.kroger.com/jira/secure/RapidBoard.jspa?rapidView=9337&view=detail" },
            }},
            {cons.cat.action, '', 'K', "Kroger", {
                {cons.act.openurl, "https://www.kroger.com/" },
            }},
            {cons.cat.action, '', 'Y', "Yext", {
                {cons.act.openurl, "https://www.yext.com/s/1029251/entities2" },
            }},
        }
    },



    ------------------------------------------------------------------------------------------------
    -- Documents Menu
    ------------------------------------------------------------------------------------------------
    [documentsMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', '.config', {
                 {cons.act.launcher, 'Finder'},
                 {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
                 {cons.act.typetext, '~/.config\n'},
            }},
            {cons.cat.action, '', 'D', 'Google Drive (local)', {
                 {cons.act.launcher, 'Finder'},
                 {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
                 {cons.act.typetext, '~/Google Drive\n'},
            }},
            {cons.cat.action, 'shift', 'D', "Google Drive (online)", {
                 {cons.act.openurl, "https://drive.google.com/" },
            }},
            {cons.cat.action, '', 'I', 'iCloud Drive (local)', {
                 {cons.act.launcher, 'Finder'},
                 {cons.act.keycombo, {'cmd', 'shift'}, 'i'},
            }},
            {cons.cat.action, '', 'H', 'Hammerspoon', {
                 {cons.act.launcher, 'Finder'},
                 {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
                 {cons.act.typetext, '~/.hammerspoon\n'},
            }},
            {cons.cat.action, '', 'M', 'MenuHammer Custom Config', {
                 {cons.act.openfile, "~/OneDrive - The Kroger Co"},
            }},
            {cons.cat.action, 'shift', 'M', 'MenuHammer Default Config', {
                 {cons.act.openfile, "~/.hammerspoon/Spoons/MenuHammer.spoon/MenuConfigDefaults.lua"},
            }},
            {cons.cat.action, 'shift', 'H', 'Hammerspoon init.lua', {
                 {cons.act.openfile, "~/.hammerspoon/init.lua"},
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Finder Menu
    ------------------------------------------------------------------------------------------------
    finderMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', 'Applications Folder', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'a'},
            }},
            {cons.cat.action, 'shift', 'A', 'Airdrop', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'r'},
            }},
            {cons.cat.action, '', 'C', 'Computer', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'c'},
            }},
            {cons.cat.action, '', 'D', 'Desktop', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'd'},
            }},
            {cons.cat.action, 'shift', 'D', 'Downloads', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'alt'}, 'l'},
            }},
            {cons.cat.action, '', 'F', "Finder", {
                {cons.act.launcher, 'Finder'}
            }},
            {cons.cat.action, '', 'G', 'Go to Folder...', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
            }},
            {cons.cat.action, '', 'H', 'Home', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'h'},
            }},
            {cons.cat.action, 'shift', 'H', 'Hammerspoon', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
                {cons.act.typetext, '~/.hammerspoon\n'},
            }},
            {cons.cat.action, '', 'I', 'iCloud Drive', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'i'},
            }},
            {cons.cat.action, '', 'K', 'Connect to Server...', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd'}, 'K'},
            }},
            {cons.cat.action, '', 'L', 'Library', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'l'},
            }},
            {cons.cat.action, '', 'N', 'Network', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'k'},
            }},
            {cons.cat.action, '', 'O', 'Documents', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'o'},
            }},
            {cons.cat.action, '', 'R', 'Recent', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'f'},
            }},
            {cons.cat.action, '', 'U', 'Utilities', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'u'},
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Games Menu
    ------------------------------------------------------------------------------------------------
    [gamesMenu] = {
        parentMenu = applicationMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'G', "GOG Galaxy", {
                 {cons.act.launcher, 'GOG Galaxy'}
            }},
            {cons.cat.action, '', 'S', "Steam", {
                 {cons.act.launcher, 'Steam'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Hammerspoon Menu
    ------------------------------------------------------------------------------------------------
    hammerspoonMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Hammerspoon Console", {
                {cons.act.func, function() hs.toggleConsole() end }
            }},
            {cons.cat.action, '', 'H', "Hammerspoon Manual", {
                {cons.act.func, function()
                      hs.doc.hsdocs.forceExternalBrowser(true)
                      hs.doc.hsdocs.moduleEntitiesInSidebar(true)
                      hs.doc.hsdocs.help()
                end }
            }},
            {cons.cat.action, '', 'R', "Reload Hammerspoon", {
                {cons.act.func, function() hs.reload() end }
            }},
            {cons.cat.action, '', 'Q', "Quit Hammerspoon", {
                {cons.act.func, function() os.exit() end }
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Layout Menu
    ------------------------------------------------------------------------------------------------
    [layoutMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'E', "Split Safari/iTunes", {
                 {cons.act.func, function()
                      -- See Hammerspoon layout documentation for more info on this
                      local mainScreen = hs.screen{x=0,y=0}
                      hs.layout.apply({
                              {"Safari", nil, mainScreen, hs.layout.left50, nil, nil},
                              {"iTunes", nil, mainScreen, hs.layout.right50, nil, nil},
                      })
                 end }
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Media Menu
    ------------------------------------------------------------------------------------------------
    mediaMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', "iTunes", {
                {cons.act.launcher, "iTunes"}
            }},
            {cons.cat.action, '', 'H', "Previous Track", {
                {cons.act.mediakey, "previous"}
            }},
            {cons.cat.action, '', 'J', "Volume Down", {
                {cons.act.mediakey, "adjustVolume", -10}},
                true,
           },
            {cons.cat.action, '', 'K', "Volume Up", {
                {cons.act.mediakey, "adjustVolume", 10}},
                true,
           },
            {cons.cat.action, '', 'L', "Next Track", {
                {cons.act.mediakey, "next"}
            }},
            {cons.cat.action, '', 'X', "Mute/Unmute", {
                {cons.act.mediakey, "mute"}
            }},
            {cons.cat.action, '', 'P', "Play/Pause", {
                {cons.act.mediakey, "playpause"}
            }},
            {cons.cat.action, '', 'O', "Brightness Up", {
                {cons.act.mediakey, "adjustBrightness", 10}},
                true
            },
            {cons.cat.action, '', 'I', "Brightness Down", {
                {cons.act.mediakey, "adjustBrightness", -10}},
                true,
           },
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Open Files Menu
    ------------------------------------------------------------------------------------------------
    openFilesMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
        }
    },

    [phoneMenu]= {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'S', "Silence", {
                {cons.act.func, function() 
                    local key = envVars['key']
                    local autoremoteURL = 
                    'https://autoremotejoaomgcd.appspot.com/sendmessage?key=' .. key .. '&message=silence'
                        hs.http.asyncGet(
                            autoremoteURL,
                            nil, 
                            function()
                                hs.alert.show("Your phone is now on silent")
                            end
                        )
                end}
            }},
            {cons.cat.action, '', 'L', "Loudence", {
                {cons.act.func, function() 
                    local key = envVars['key']
                    local autoremoteURL = 
                    'https://autoremotejoaomgcd.appspot.com/sendmessage?key=' .. key .. '&message=loudence'
                        hs.http.asyncGet(
                            autoremoteURL,
                            nil, 
                            function()
                                hs.alert.show("Your phone is now on loud")
                            end
                        )
                end}
            }}
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Scripts Menu
    ------------------------------------------------------------------------------------------------
    [scriptsMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'O', "Copy URL of selected Outlook message", {
                {cons.act.func, function() hs.osascript.applescript([[
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
                  end}
            }},
            {cons.cat.action, '', 'C', "Clear notifications", {
                {cons.act.func, function() 
                    if hs.host.localizedName() == "Giskard" then
                    hs.osascript.applescript([[
                        activate application "NotificationCenter"
                            tell application "System Events"
                                tell process "Notification Center"
                                repeat
                                    try
                                        set theWindow to group 1 of UI element 1 of scroll area 1 of window "Notification Center"
                                    on error
                                        exit repeat
                                    end try
                                    
                                    try
                                        set theActions to actions of theWindow
                                        
                                        # Try to close the whole group first. If that fails, close individual windows.
                                        repeat with theAction in theActions
                                            if description of theAction is "Clear All" then
                                                set closed to true
                                                tell theWindow
                                                    perform theAction
                                                end tell
                                                exit repeat
                                            end if
                                        end repeat
                                        
                                        repeat with theAction in theActions
                                            if description of theAction is "Close" then
                                                set closed to true
                                                tell theWindow
                                                    perform theAction
                                                end tell
                                                exit repeat
                                            end if
                                        end repeat
                                        
                                    end try
                                end repeat
                            end tell
                        end tell
                    ]])
else
                    hs.osascript.applescript([[
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
            end
                  end}
            }},
            {cons.cat.action, '', 'K', "Kill teams and outlook", {
                {cons.act.func, function() 
                local outlook = hs.application.find("Microsoft Outlook")
                local teams = hs.application.find("Microsoft Teams")
                if teams then
                    teams:kill()
                  end
                if outlook then
                    outlook:kill()
                end
                  end}
            }},
        }, 
    },

    ------------------------------------------------------------------------------------------------
    -- System Menu
    ------------------------------------------------------------------------------------------------
    systemMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, 'shift', 'F', "Force Quit Frontmost App", {
                {cons.act.system, cons.sys.forcequit},
            }},
            {cons.cat.action, '', 'L', "Lock Screen", {
                {cons.act.func, function() hs.caffeinate.lockScreen() end }
            }},
            {cons.cat.action, '', 'W', 'Wikipedia',
            {
                {cons.act.userinput,                                             -- Action type
                 "luckyWikipedia",                                               -- Value Identifier
                 "Lucky Wikipedia",                                              -- Message
                 "Google a Wikipedia article and hit I'm Feeling Lucky button"}, -- Informative Text
                {cons.act.openurl,
                 "http://www.google.com/search?q=@@luckyWikipedia@@%20site:wikipedia.org&meta=&btnI"
                }
           }},
           {cons.cat.action, '', 'P', 'TeSSTST', {
                 {cons.act.keycombo, {'cmd'}, 'space'},
                 {cons.act.typetext, 'todo'},
}},
            {cons.cat.action, 'shift', 'R', "Restart System", {
                {cons.act.system, cons.sys.restart, true},
            }},
            {cons.cat.action, '', 'S', "Start Screensaver", {
                {cons.act.system, cons.sys.screensaver},
            }},
            {cons.cat.action, 'shift', 'S', "Shutdown System", {
                {cons.act.system, cons.sys.shutdown, true},
            }},
            {cons.cat.action, '', 'Q', 'Logout', {
                {cons.act.system, cons.sys.logout}
            }},
            {cons.cat.action, 'shift', 'Q', 'Logout Immediately', {
                {cons.act.system, cons.sys.logoutnow},
            }},
            {cons.cat.action, '', 'U', "Switch User", {
                {cons.act.system, cons.sys.switchuser, true},
            }},
            {cons.cat.action, '', 'V', 'Activity Monitor', {
                {cons.act.launcher, 'Activity Monitor'},
            }},
            {cons.cat.action, '', 'X', 'System Preferences', {
                {cons.act.launcher, 'System Preferences'},
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Text Menu
    ------------------------------------------------------------------------------------------------
    [textMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', 'Remove clipboard format', {
                 {cons.act.func, function()
                      local pasteboardContents = hs.pasteboard.getContents()
                      hs.pasteboard.setContents(pasteboardContents)
                 end },
            }},
            {cons.cat.action, '', 'E', 'Empty the clipboard', {
                 {cons.act.func, function() hs.pasteboard.setContents("") end}
            }},
            {cons.cat.action, '', 'T', 'Type clipboard contents', {
                 {cons.act.typetext, "@@mhClipboardText@@"}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Toggle menu
    ------------------------------------------------------------------------------------------------
    [toggleMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = dynamicToggleMenuItems
    },
}
