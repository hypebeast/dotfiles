-- window cycling of same app and screen using windowfilter

local currentWindowSet = {}
local windowCycler = nil

local wf = hs.window.filter.new(function(win)
    local fw = hs.window.focusedWindow()
    return (
      win:isStandard() and
      win:application() == fw:application() and
      win:screen() == fw:screen()
    )
  end)

local function makeTableCycler(t) -- like hs.fnutils.cycle but can reverse too
  local i = 1
  return function(d)
    local j = d and d < 0 and -2 or 0
    i = (i + j) % #t + 1
    local x = t[i]
    return x
  end
end

local function updateWindowCycler()
  if not hs.fnutils.contains(currentWindowSet, hs.window.focusedWindow()) then
    currentWindowSet = wf:getWindows()
    windowCycler = makeTableCycler(currentWindowSet)
  end
end

-- Cycle through the windows of an application
function dowWindowCycling(t)
   updateWindowCycler()
   windowCycler(t):focus()
end
