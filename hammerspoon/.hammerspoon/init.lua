local hotkey = require("hs.hotkey")
local window = require("hs.window")
local hints = require("hs.hints")

require("lib/extensions")
require("lib/spotify")

---------------------------------------------------------
-- Load Spoons
---------------------------------------------------------

hs.loadSpoon("MiroWindowsManager")

---------------------------------------------------------
-- Key definitions
---------------------------------------------------------

local hyperKey = { "cmd", "alt", "ctrl", "shift" }
-- window location modifier key
local windowModifierKey = { "cmd", "ctrl" }
-- window resizing key
local windowResizeKey = { "cmd", "alt" }
local nudgeModifierKey = { "alt", "shift" }
local hintModifierKey = { "cmd", "ctrl" }
local screenModifierKey = { "cmd", "alt" }

---------------------------------------------------------
-- Setup hyper key
------------------------------------------------------

-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, "ESCAPE")
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, "F18", enterHyperMode, exitHyperMode)

---------------------------------------------------------
-- Application definitions
---------------------------------------------------------

local keyToApp = {
  ["1"] = "Google Chrome",
  ["2"] = "iTerm",
  ["3"] = "Code",
  ["4"] = "KeePassX",
  ["5"] = "Slack",
  ["6"] = "Skype",
  ["Z"] = "Finder",
}

---------------------------------------------------------
-- Global settings
---------------------------------------------------------

-- disable animations
hs.window.animationDuration = 0.1

-- hide window shadows
hs.window.setShadows(false)

---------------------------------------------------------
-- Config reload
---------------------------------------------------------

local function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

hyper:bind({}, "r", function()
  reloadConfig()
  hyper.triggered = true
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

---------------------------------------------------------
-- SCREENS
---------------------------------------------------------

-- local cycleScreens = hs.fnutils.cycle(hs.screen.allScreens())

-- k:bind({}, "S", function()
--   window.focusedWindow():moveToScreen(cycleScreens())
-- end)

---------------------------------------------------------
-- Window handling
---------------------------------------------------------

---
--- Location bindings
---

-- k:bind({}, "F", fullScreenCurrent)
-- k:bind({}, "D", screenToRight)
-- k:bind({}, "A", screenToLeft)

spoon.MiroWindowsManager:bindHotkeys({
  up = { windowModifierKey, "up" },
  right = { windowModifierKey, "right" },
  down = { windowModifierKey, "down" },
  left = { windowModifierKey, "left" },
  fullscreen = { windowModifierKey, "return" },
  nextscreen = { windowModifierKey, "n" },
})

--- Fullsize
-- hotkey.bind(locationModifierKey, "return", function ()
--     local win = window.focusedWindow()
--     win:maximize()
-- end)

--- Lefthalf
-- hotkey.bind(locationModifierKey, "H", function ()
--     local win = window.focusedWindow()
--     local winFrame = win:frame()
--     local screen = win:screen()
--     local screenFrame = screen:frame()
--     local width = screenFrame.w / 2
--     local height = screenFrame.h

--     winFrame.x = 0
--     winFrame.y = 0
--     winFrame.w = width
--     winFrame.h = height
--     win:setFrame(winFrame)
-- end)

--- Righthalf
-- hotkey.bind(locationModifierKey, "L", function ()
--     local win = window.focusedWindow()
--     local winFrame = win:frame()
--     local screen = win:screen()
--     local screenFrame = screen:frame()
--     local width = screenFrame.w / 2
--     local height = screenFrame.h

--     winFrame.x = width
--     winFrame.y = 0
--     winFrame.w = width
--     winFrame.h = height
--     win:setFrame(winFrame)
-- end)

--- Bottomhalf
-- hotkey.bind(locationModifierKey, "J", function ()
--     local win = window.focusedWindow()
--     local winFrame = win:frame()
--     local screen = win:screen()
--     local screenFrame = screen:frame()
--     local width = screenFrame.w
--     local height = screenFrame.h / 2

--     winFrame.x = 0
--     winFrame.y = height
--     winFrame.w = width
--     winFrame.h = height
--     win:setFrame(winFrame)
-- end)

--- Tophalf
-- hotkey.bind(locationModifierKey, "K", function ()
--     local win = window.focusedWindow()
--     local winFrame = win:frame()
--     local screen = win:screen()
--     local screenFrame = screen:frame()
--     local width = screenFrame.w
--     local height = screenFrame.h / 2

--     winFrame.x = 0
--     winFrame.y = 0
--     winFrame.w = width
--     winFrame.h = height
--     win:setFrame(winFrame)
-- end)

---
--- Resize bindings
---

--- Increase width
hotkey.bind(windowResizeKey, "l", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.w = f.w + 80
  win:setFrame(f)
end)

--- Decrease width
hotkey.bind(windowResizeKey, "h", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.w = f.w - 80
  win:setFrame(f)
end)

--- Increase height
hotkey.bind(windowResizeKey, "j", function()
  local win = window.focusedWindow()
  local f = win:frame()
  f.h = f.h + 80
  win:setFrame(f)
end)

--- Decrease width
hotkey.bind(windowResizeKey, "k", function()
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
hotkey.bind(hintModifierKey, "e", hints.windowHints)

-- This switches between windows of the focused app
hotkey.bind(hintModifierKey, "j", function()
  hints.appHints(window.focusedWindow():application())
end)

---------------------------------------------------------
-- Window switching
--------------------------------------------------------

-- default windowfilter: only visible windows, all Spaces
-- switcher = hs.window.switcher.new()

-- hotkey.bind('alt', 'tab', 'Next window', function() switcher:next() end)
-- hotkey.bind('alt-shift', 'tab', 'Prev window', function() switcher:previous() end)

-- set up your windowfilter
-- switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome', 'Firefox'} -- specialized switcher for your dozens of browser windows :)

-- bind to hotkeys; WARNING: at least one modifier key is required!
-- hs.hotkey.bind('alt','tab','Next window',function()switcher_browsers:next()end)
-- hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher_browsers:previous()end)

---------------------------------------------------------
-- Move app to next screen
--------------------------------------------------------
local function moveToNextScreen()
  local app = hs.window.focusedWindow()
  app:moveToScreen(app:screen():next())
  app:maximize()
end

hs.hotkey.bind(screenModifierKey, "n", moveToNextScreen)

---------------------------------------------------------
-- App Window Switcher
--------------------------------------------------------

hs
  .loadSpoon("AppWindowSwitcher")
  -- :setLogLevel("debug") -- uncomment for console debug log
  :bindHotkeys({
    [{
      "org.mozilla.firefox",
    }] = { "cmd", "ctrl", "." },
    -- [{"com.apple.Safari",
    --   "com.google.Chrome",
    --   "com.kagi.kagimacOS",
    --   "com.microsoft.edgemac",
    --   "org.mozilla.firefox"}]     = {hyper, "q"},
    -- ["Hammerspoon"]               = {hyper, "h"},
    -- [{"O", "o"}]                  = {hyper, "o"},
  })
