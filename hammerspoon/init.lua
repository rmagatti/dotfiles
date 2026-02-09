-- Hammerspoon configuration

--------------------------------------------------------------------------------
-- Push to Talk / Mute Toggle
--------------------------------------------------------------------------------

muteAlertId = nil

-- Track mute state ourselves (some devices don't support inputMuted())
local isMuted = true  -- Start muted for safety
local savedVolume = 100  -- Store volume before muting

-- Clear the alert if exists to avoid notifications stacking
local function clearMuteAlert()
  if muteAlertId then
    hs.alert.closeSpecific(muteAlertId)
  end
end

local function muteInput(audio)
  local vol = audio:inputVolume()
  print("Muting - current volume: " .. tostring(vol))
  if vol and vol > 0 then
    savedVolume = vol
  end
  audio:setInputMuted(true)
  audio:setInputVolume(0)
  isMuted = true
  print("Muted - volume now: " .. tostring(audio:inputVolume()))
end

local function unmuteInput(audio)
  print("Unmuting - restoring volume to: " .. tostring(savedVolume))
  audio:setInputMuted(false)
  audio:setInputVolume(savedVolume)
  isMuted = false
  print("Unmuted - volume now: " .. tostring(audio:inputVolume()))
end

-- Hold the hotkey for Push To Talk
local holdingToTalk = false
local function pushToTalk()
  holdingToTalk = true
  local audio = hs.audiodevice.defaultInputDevice()
  if not audio then return end
  if isMuted then
    clearMuteAlert()
    muteAlertId = hs.alert.show("🎤 Microphone on", true)
    unmuteInput(audio)
  end
end

-- Toggles the default microphone's mute state on hotkey release
-- or performs PTT when holding down the hotkey
local function toggleMuteOrPTT()
  local audio = hs.audiodevice.defaultInputDevice()
  if not audio then
    hs.alert.show("No input device found")
    return
  end
  
  if holdingToTalk then
    -- PTT release: always mute
    holdingToTalk = false
    muteInput(audio)
  else
    -- Toggle
    if isMuted then
      unmuteInput(audio)
    else
      muteInput(audio)
    end
  end
  
  clearMuteAlert()
  if isMuted then
    muteAlertId = hs.alert.show("📵 Microphone muted")
  else
    muteAlertId = hs.alert.show("🎤 Microphone on")
  end
end

-- `⌘ ⇧ A` but you could also map to F13 for a macropad
hs.hotkey.bind({"cmd", "shift"}, "a", nil, toggleMuteOrPTT, pushToTalk)

-- List all input devices and their capabilities
print("=== Available input devices ===")
for _, dev in ipairs(hs.audiodevice.allInputDevices()) do
  print(string.format("  %s - mute:%s vol:%s", 
    dev:name(), 
    tostring(dev:inputMuted()), 
    tostring(dev:inputVolume())))
end
