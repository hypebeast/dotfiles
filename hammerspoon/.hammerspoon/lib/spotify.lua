--- === spotify ===
---
--- Controls for Spotify music player

local spotify = {}

local app = require("hs.application")
local as = require("hs.applescript")
local menu = require("hs.menubar")
local logger = require("hs.logger")
local timer = require("hs.timer")

local menu_bar_app = menu.new()

local function updateState()
  
  local track_name = spotify.getCurrentTrack()
  local artist_name = spotify.getCurrentArtist()

  menu_bar_app:setTitle(spotify.getSongInfo(track_name, artist_name))
end

-- Start timer to update song info
update_timer = timer.doEvery(10, updateState)

spotify.state_playing = "kPSP"
spotify.state_paused = "kPSp"

local function tell(cmd)
  local _cmd = 'tell application "Spotify" to ' .. cmd
  local ok, result = as.applescript(_cmd)

  if ok then
    return result
  else
    return nil
  end
end

local function getPlayerState()
  local state = spotify.getPlaybackState()
  if state == spotify.state_playing then
    return "♫ ⏵ "
  else
    return "♫ ⏸ "
  end
end

function spotify.getCurrentTrack()
  return tell("name of the current track")
end

function spotify.getCurrentArtist()
  return tell("artist of the current track")
end

function spotify.getPlaybackState()
  return tell("get player state")
end

function spotify.isRunning()
  return app.get("Spotify") ~= nil
end

function spotify.getSongInfo(track_name, artist_name)
  if not spotify.isRunning() then
    return "♫ 💤"
  end
  return getPlayerState() .. track_name .. " - " .. artist_name
end
