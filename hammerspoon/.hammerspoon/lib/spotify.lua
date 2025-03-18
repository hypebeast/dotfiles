--- === spotify ===
---
--- Shows the current playing Spotify song in the menu bar

local obj = {}
obj.__index = obj

obj.spotify_indicator = nil
obj.timer = nil
-- spotify.iconPath = hs.spoons.resourcePath("icons")
-- spotify.playIcon = nil
-- spotify.pauseIcon = nil

function refreshWidget()
  local title = ""
  
  if (hs.spotify.isPlaying()) then
      -- obj.spotify_indicator:setIcon(obj.playIcon, false)

      title = title .. "🎵 ▶︎ "
  else
      -- obj.spotify_indicator:setIcon(obj.pauseIcon, false)
      title = title .. "🎵 ⏸︎ "
  end

  if (hs.spotify.getCurrentArtist() ~= nil and hs.spotify.getCurrentTrack() ~= nil) then
      title = title .. hs.spotify.getCurrentArtist() .. ' - ' .. hs.spotify.getCurrentTrack()
      obj.spotify_indicator:setTitle(title)
  end
end

function obj:next()
  hs.spotify.next()
  refreshWidget()
end

function obj:prev()
  hs.spotify.previous() 
  refreshWidget()
end

function obj:playpause()
  hs.spotify.playpause() 
  refreshWidget()
end

function obj:init()
  self.spotify_indicator = hs.menubar.new()
  -- self.playIcon = hs.image.imageFromPath(obj.iconPath .. '/Spotify_Icon_RGB_Green.png'):setSize({w=16,h=16})
  -- self.pauseIcon = hs.image.imageFromPath(obj.iconPath .. '/Spotify_Icon_RGB_White.png'):setSize({w=16,h=16})

  self.spotify_indicator:setClickCallback(function()
    hs.spotify.playpause()
    refreshWidget()
  end)

  self.timer = hs.timer.new(1, refreshWidget)
end

function obj:bindHotkeys(mapping)
  local spec = {
      next = hs.fnutils.partial(self.next, self),
      prev = hs.fnutils.partial(self.prev, self),
      playpause = hs.fnutils.partial(self.playpause, self),
    }
    hs.spoons.bindHotkeysToSpec(spec, mapping)
    return self
end

function obj:start()
  self.timer:start()
end

function obj:stop()
  self.timer:stop()
end

return obj