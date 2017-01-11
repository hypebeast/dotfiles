local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local spotify = require "hs.spotify"
local notify = require "hs.notify"
local pasteboard = require "hs.pasteboard"
-- local tiling = require "mjolnir.tiling"

require "fntools"
require "extensions"

---------------------------------------------------------
-- Key definitions
---------------------------------------------------------

local k = hs.hotkey.modal.new({}, "F17", "some message")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function ()
    k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
releasedF18 = function ()
    k:exit()
end

local f18 = hs.hotkey.bind({}, "F18", pressedF18, releasedF18)

local locationModifierKey = {"cmd", "shift"}
local resizeModifierKey = {"cmd", "alt", "ctrl"}
local nudgeModifierKey = {"alt", "shift"}
local hintModifierKey = {"cmd", "ctrl"}
local sendKeyStrokesModifierKey = {"ctrl", "shift"}
local hyperKey = {"cmd", "alt", "ctrl", "shift"}


---------------------------------------------------------
-- Application definitions
---------------------------------------------------------

local keyToApp = {
    ["1"] = "Google Chrome",
    ["2"] = "iTerm",
    ["3"] = "Atom",
    ["4"] = "KeePassX",
    ["5"] = "Slack",
    ["6"] = "Skype",
    ["Z"] = "Finder"
}


---------------------------------------------------------
-- Global settings
---------------------------------------------------------

-- disable animations
hs.window.animationDuration = 0

-- hide window shadows
hs.window.setShadows(false)


---------------------------------------------------------
-- Config reload
---------------------------------------------------------

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

---------------------------------------------------------
-- SCREENS
---------------------------------------------------------

local cycleScreens = hs.fnutils.cycle(hs.screen.allScreens())

hotkey.bind(hyperKey, "S", function()
  window.focusedWindow():moveToScreen(cycleScreens())
end)

---
--- Location bindings
---

hs.hotkey.bind(hyperKey, "F", fullScreenCurrent)
hs.hotkey.bind(hyperKey, "D", screenToRight)
hs.hotkey.bind(hyperKey, "A", screenToLeft)

--- Fullsize
hotkey.bind(locationModifierKey, "return", function ()
    local win = window.focusedWindow()
    win:maximize()
end)

--- Lefthalf
hotkey.bind(locationModifierKey, "H", function ()
    local win = window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local width = screenFrame.w / 2
    local height = screenFrame.h

    winFrame.x = 0
    winFrame.y = 0
    winFrame.w = width
    winFrame.h = height
    win:setFrame(winFrame)
end)

--- Righthalf
hotkey.bind(locationModifierKey, "L", function ()
    local win = window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local width = screenFrame.w / 2
    local height = screenFrame.h

    winFrame.x = width
    winFrame.y = 0
    winFrame.w = width
    winFrame.h = height
    win:setFrame(winFrame)
end)

--- Bottomhalf
hotkey.bind(locationModifierKey, "J", function ()
    local win = window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local width = screenFrame.w
    local height = screenFrame.h / 2

    winFrame.x = 0
    winFrame.y = height
    winFrame.w = width
    winFrame.h = height
    win:setFrame(winFrame)
end)

--- Tophalf
hotkey.bind(locationModifierKey, "K", function ()
    local win = window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local width = screenFrame.w
    local height = screenFrame.h / 2

    winFrame.x = 0
    winFrame.y = 0
    winFrame.w = width
    winFrame.h = height
    win:setFrame(winFrame)
end)

---
--- Resize bindings
---

--- Increase width
hotkey.bind(resizeModifierKey, "right", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.w = f.w + 80
  win:setFrame(f)
end)

--- Decrease width
hotkey.bind(resizeModifierKey, "left", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.w = f.w - 80
  win:setFrame(f)
end)

--- Increase height
hotkey.bind(resizeModifierKey, "up", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.h = f.h + 80
  win:setFrame(f)
end)

--- Decrease width
hotkey.bind(resizeModifierKey, "down", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.h = f.h - 80
  win:setFrame(f)
end)


---
--- Nudge Bindings
---

--- Move right
hotkey.bind(nudgeModifierKey, "right", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.x = f.x + 50
  win:setFrame(f)
end)

--- Move left
hotkey.bind(nudgeModifierKey, "left", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.x = f.x - 50
  win:setFrame(f)
end)

--- Move up
hotkey.bind(nudgeModifierKey, "up", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.y = f.y - 50
  win:setFrame(f)
end)

--- Move down
hotkey.bind(nudgeModifierKey, "down", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.y = f.y + 50
  win:setFrame(f)
end)


---
--- Hints
---
--- hotkey.bind(hintModifierKey, "e", hints.windowHints)

-- This switches between windows of the focused app
-- hotkey.bind(hintModifierKey, "j", function()
--    hints.appHints(window.focusedWindow():application())
-- end)


---
--- Spotify
---

hotkey.bind(hyperKey, 'I', spotify.displayCurrentTrack)
hotkey.bind(hyperKey, 'space', function()
  local info = string.format("\"%s\" - \"%s\"", spotify.getCurrentArtist(), spotify.getCurrentTrack())

  spotify.play()
  notify.new({title="Spotify Play/Pause", informativeText=info}):send():release()
end)
hotkey.bind(hyperKey, 'n', function()
  spotify.next()
  local info = string.format("\"%s\" - \"%s\"", spotify.getCurrentArtist(), spotify.getCurrentTrack())
  notify.new({title="Spotify - Next Track", informativeText=info}):send():release()
end)
hotkey.bind(hyperKey, 'p', function()
  spotify.previous()
  local info = string.format("\"%s\" - \"%s\"", spotify.getCurrentArtist(), spotify.getCurrentTrack())
  notify.new({title="Spotify - Previous Track", informativeText=info}):send():release()
end)

---
--- Tiling
---

-- hotkey.bind(hintModifierKey, "c", function() tiling.cyclelayout() end)
-- hotkey.bind(hintModifierKey, "j", function() tiling.cycle(1) end)
-- hotkey.bind(hintModifierKey, "k", function() tiling.cycle(-1) end)
-- hotkey.bind(hintModifierKey, "space", function() tiling.promote() end)

---------------------------------------------------------
-- APP HOTKEYS
---------------------------------------------------------

-- Create application hotkeys and bind them to the previously defined modal
for key, app in pairs(keyToApp) do
    k:bind({}, key, launchOrCycleFocus(app))
end



---------------------------------------------------------
-- ON-THE-FLY KEYBIND
---------------------------------------------------------

-- Temporarily bind an application to be toggled by the V key
-- useful for once-in-a-while applications like Preview
local boundApplication = nil

hs.hotkey.bind(hyperKey, "C", function()
  local appName = hs.window.focusedWindow():application():title()

  if boundApplication then
    boundApplication:disable()
  end

  boundApplication = hs.hotkey.bind(hyperKey, "V", launchOrCycleFocus(appName))

  -- https://github.com/Hammerspoon/hammerspoon/issues/184#issuecomment-102835860
  boundApplication:disable()
  boundApplication:enable()

  hs.alert(string.format("Binding: \"%s\" => ⌘ + V", appName))
end)

hotkey.bind(hyperKey, "R", launchOrCycleFocus(terminal))

hotkey.bind(hyperKey, "R", function()
  launchOrCycleFocus(terminal)
end)

---------------------------------------------------------
-- Do a Google search with the clipboard content
---------------------------------------------------------

hotkey.bind(hyperKey, "G", function()
  local content = pasteboard.getContents()
  local searchUrl = "https://google.com/search?q=" .. content

  hs.execute("open " .. searchUrl)
end)
