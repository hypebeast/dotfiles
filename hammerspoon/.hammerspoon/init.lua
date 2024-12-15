local hotkey = require("hs.hotkey")
local window = require("hs.window")
local hints = require("hs.hints")
local app = require("hs.application")

require("lib/extensions")
local spotify = require("lib/spotify")

local log = hs.logger.new("hammerspoon", "debug")

---------------------------------------------------------
-- Load Spoons
---------------------------------------------------------

hs.loadSpoon("MiroWindowsManager")

---------------------------------------------------------
-- Key definitions
---------------------------------------------------------

-- hyper key
local hyperKey = { "cmd", "alt", "ctrl"}
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
-- Application shortcuts
---------------------------------------------------------

local function launchOrFocus(appName)
  log.i("Launching app", appName)
  app.launchOrFocus(appName)
end

local appMappings = {
  {'1', 'Google Chrome'},
  {'2', 'Firefox'},
  {'3', 'WezTerm'},
  {'4', 'Bitwarden'},
  {'5', 'Visual Studio Code'},
  {'t', 'Todoist'},
  {'z', 'Finder'},
  {'n', 'Obsidian'},
}

for i, app in ipairs(appMappings) do
  hyper:bind({}, app[1], function () launchOrFocus(app[2]) end)
end

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

spoon.MiroWindowsManager:bindHotkeys({
  up = { windowModifierKey, "up" },
  right = { windowModifierKey, "right" },
  down = { windowModifierKey, "down" },
  left = { windowModifierKey, "left" },
  fullscreen = { windowModifierKey, "return" },
  nextscreen = { windowModifierKey, "n" },
})

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

---------------------------------------------------------
-- Spotify
---------------------------------------------------------

spotify:init()
spotify:start()

---------------------------------------------------------
-- Dev Tools Chooser
---------------------------------------------------------

devToolsList = {
  {
    text = 'GitHub Repositories (@rsefer)',
    image = hs.image.imageFromAppBundle('com.github.GitHubClient'),
    url = 'https://github.com/rsefer?tab=repositories'
  },
  {
    text = 'Meeting',
    image = hs.image.imageFromURL('https://flexibits.com/img/new-fantastical/logo/product/fantastical-mac-glyph@2x.png'),
    url = 'https://fantastical.app/rsefer/meeting'
  },
  {
    text = 'RegExr',
    image = hs.image.imageFromURL('https://regexr.com/assets/icons/favicon-32x32.png'),
    url = 'https://regexr.com'
  },
  {
    text = 'Unix Time Converter',
    image = hs.image.imageFromURL('https://dpidudyah7i0b.cloudfront.net/favicon.ico'),
    url = 'https://www.unixtimestamp.com'
  },
  {
    text = 'Character Count',
    image = hs.image.imageFromURL('https://wordcounter.net/favicon.ico'),
    action = 'countCharacters'
  },
  {
    text = 'Convert Case',
    image = hs.image.imageFromURL('https://convertcase.net/favicon.ico'),
    url = 'https://convertcase.net'
  },
  {
    text = 'Learn X in Y Minutes (JavaScript)',
    image = hs.image.imageFromURL('https://learnxinyminutes.com/favicon.ico'),
    url = 'https://learnxinyminutes.com/docs/javascript/'
  },
  {
    text = 'Hammerspoon Documentation',
    image = hs.image.imageFromAppBundle('org.hammerspoon.Hammerspoon'),
    url = 'https://www.hammerspoon.org/docs/index.html'
  },
  {
    text = 'Lorem Ipsum',
    image = hs.image.imageFromURL('https://loremipsum.io/assets/images/favicon.png'),
    action = 'loremIpsum'
  },
  {
    text = 'PHP Date Format',
    image = hs.image.imageFromURL('https://www.php.net/favicon.svg'),
    url = 'https://www.php.net/manual/en/datetime.format.php#refsect1-datetime.format-parameters'
  },
  {
    text = 'GenerateWP',
    image = hs.image.imageFromURL('https://generatewp.com/wp-content/uploads/cropped-generatewp-logo.png'),
    url = 'https://generatewp.com/generator/'
  },
  {
    text = 'Excalidraw',
    image = hs.image.imageFromURL('https://excalidraw.com/favicon.ico'),
    url = 'https://excalidraw.com/'
  },
  {
    text = 'WooCommerce Templates',
    image = hs.image.imageFromURL('https://woocommerce.com/wp-content/uploads/2020/06/cropped-Favicon_512.png'),
    url = 'https://github.com/woocommerce/woocommerce/tree/trunk/plugins/woocommerce/templates'
  }
}

hyper:bind({}, 'k', function ()
  devToolsChooser = hs.chooser.new(function(choice)
    if not choice then return end
    if choice.action ~= nil then
      if choice.action == 'countCharacters' then
        countCharacters()
      elseif choice.action == 'loremIpsum' then
        loremIpsum()
      end
    else
      hs.urlevent.openURL(choice.url)
    end
  end):choices(devToolsList):show()
end)