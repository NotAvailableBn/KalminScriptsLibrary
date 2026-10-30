local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SERVER_STATUS = "Up" 

local WHITELISTED_GAMES = {
    ["[Fps] Flick"] = 136801880565837,
}

local SCRIPT_URL = "https://raw.githubusercontent.com/FuddyOG/noks-crackedV2/refs/heads/main/Noks%20Cracked.lua"

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3,
        })
    end)
end

if SERVER_STATUS:lower() == "down" then
    LocalPlayer:Kick("Under for maintenance")
    return
end

local isSupported = false
for gameName, placeId in pairs(WHITELISTED_GAMES) do
    if game.PlaceId == placeId then
        isSupported = true
        break
    end
end

if isSupported then
    notify("Script Status", "Game Supported", 3)
else
    notify("Script Status", "Game Not Supported", 3)
end

notify("Script Status", "Loading...", 2)
task.wait(3)

local loadSuccess, scriptContent = pcall(function()
    return game:HttpGet(SCRIPT_URL, true)
end)

if loadSuccess and scriptContent and #scriptContent > 0 then
    local func, compileError = loadstring(scriptContent)
    if func then
        pcall(func)
    else
        warn("Failed to compile script: " .. tostring(compileError))
    end
else
    warn("Failed to fetch script. Error details: " .. tostring(scriptContent))
end
