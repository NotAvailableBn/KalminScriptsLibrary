local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")

local DISCORD_URL = "https://discord.gg/u5XmnW6Vkq"
local HUB_VERSION = "v1.0"
local KEY_FILE = "KalminHub_SavedKey.txt"

local function Notify(title, text)
	StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
end

local KeyForge = nil
local client = nil

task.spawn(function()
	local sdkUrl = "https://www.keyforge.win/sdk/client.lua"
	local downloaded, sdkSource = pcall(function()
		return game:HttpGet(sdkUrl, true)
	end)
	if downloaded and type(sdkSource) == "string" and not sdkSource:find("<!DOCTYPE", 1, true) then
		local compiler = loadstring or load
		if compiler then
			local compiled, sdkChunk = pcall(compiler, sdkSource)
			if compiled and type(sdkChunk) == "function" then
				local initialized, kfModule = pcall(sdkChunk)
				if initialized and type(kfModule) == "table" then
					KeyForge = kfModule
					pcall(function()
						client = KeyForge.new({
							projectId = "cmvuawe6h001st3p4y9rtxztr",
							scriptId = "cmvx3tpmz00gwgdp47to70isy",
							integrationToken = "Pvy3v6PmTbEVkdMEPr4EpSGuqgSZZgzG9WM3ZKM0fcM",
						})
					end)
				end
			end
		end
	end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KalminHubGui"
ScreenGui.ResetOnSpawn = false
if syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
	ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
	ScreenGui.Parent = gethui()
else
	ScreenGui.Parent = game:GetService("CoreGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 330)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 16, 26)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 4)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Transparency = 1
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 30, 48)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 16, 26)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 11, 18))
})
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local BgGlow1 = Instance.new("Frame")
BgGlow1.Size = UDim2.new(0, 200, 0, 200)
BgGlow1.Position = UDim2.new(0.2, -100, 0.3, -100)
BgGlow1.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
BgGlow1.BackgroundTransparency = 0.85
BgGlow1.BorderSizePixel = 0
BgGlow1.ZIndex = 1
BgGlow1.Parent = MainFrame
Instance.new("UICorner", BgGlow1).CornerRadius = UDim.new(1, 0)

local BgGlow2 = Instance.new("Frame")
BgGlow2.Size = UDim2.new(0, 220, 0, 220)
BgGlow2.Position = UDim2.new(0.7, -110, 0.6, -110)
BgGlow2.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
BgGlow2.BackgroundTransparency = 0.88
BgGlow2.BorderSizePixel = 0
BgGlow2.ZIndex = 1
BgGlow2.Parent = MainFrame
Instance.new("UICorner", BgGlow2).CornerRadius = UDim.new(1, 0)

task.spawn(function()
	while MainFrame.Parent do
		TweenService:Create(BgGlow1, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0.6, -100, 0.2, -100),
			Size = UDim2.new(0, 240, 0, 240)
		}):Play()
		TweenService:Create(BgGlow2, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0.1, -110, 0.6, -110),
			Size = UDim2.new(0, 180, 0, 180)
		}):Play()
		task.wait(4)
		TweenService:Create(BgGlow1, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0.2, -100, 0.3, -100),
			Size = UDim2.new(0, 200, 0, 200)
		}):Play()
		TweenService:Create(BgGlow2, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Position = UDim2.new(0.7, -110, 0.6, -110),
			Size = UDim2.new(0, 220, 0, 220)
		}):Play()
		task.wait(4)
	end
end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1
TopBar.ZIndex = 5
TopBar.Parent = MainFrame

local HubIcon = Instance.new("ImageLabel")
HubIcon.Size = UDim2.new(0, 24, 0, 24)
HubIcon.Position = UDim2.new(0, 12, 0, 8)
HubIcon.BackgroundTransparency = 1
HubIcon.Image = "rbxassetid://6031097225"
HubIcon.ZIndex = 5
HubIcon.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 130, 0, 20)
TitleLabel.Position = UDim2.new(0, 44, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Kalmin Script Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.ZIndex = 5
TitleLabel.Parent = TopBar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 60, 0, 20)
VersionLabel.Position = UDim2.new(0.5, -30, 0, 5)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = HUB_VERSION
VersionLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
VersionLabel.TextXAlignment = Enum.TextXAlignment.Center
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextSize = 11
VersionLabel.ZIndex = 5
VersionLabel.Parent = TopBar

local AboutLabel = Instance.new("TextLabel")
AboutLabel.Size = UDim2.new(0, 300, 0, 15)
AboutLabel.Position = UDim2.new(0, 44, 0, 22)
AboutLabel.BackgroundTransparency = 1
AboutLabel.Text = "One Key Get You Access To 10+ Scripts Of Differents Games"
AboutLabel.TextColor3 = Color3.fromRGB(150, 160, 185)
AboutLabel.TextXAlignment = Enum.TextXAlignment.Left
AboutLabel.Font = Enum.Font.Gotham
AboutLabel.TextSize = 10
AboutLabel.ZIndex = 5
AboutLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -36, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 5
CloseBtn.Parent = TopBar

local isClosing = false
CloseBtn.MouseButton1Click:Connect(function()
	if isClosing then return end
	isClosing = true

	local info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	-- Slide MainFrame up and fade out background
	local slideUp = TweenService:Create(MainFrame, info, {
		Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset - 100),
		BackgroundTransparency = 1
	})
	slideUp:Play()

	-- Fade out stroke
	TweenService:Create(MainStroke, info, {Transparency = 1}):Play()

	-- Fade out all descendants (text, frames, buttons, etc.)
	for _, obj in ipairs(MainFrame:GetDescendants()) do
		if obj:IsA("GuiObject") then
			pcall(function()
				TweenService:Create(obj, info, {BackgroundTransparency = 1}):Play()
			end)
		end
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			pcall(function()
				TweenService:Create(obj, info, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
			end)
		end
		if obj:IsA("ImageLabel") then
			pcall(function()
				TweenService:Create(obj, info, {ImageTransparency = 1, BackgroundTransparency = 1}):Play()
			end)
		end
		if obj:IsA("UIStroke") then
			pcall(function()
				TweenService:Create(obj, info, {Transparency = 1}):Play()
			end)
		end
	end

	slideUp.Completed:Connect(function()
		ScreenGui:Destroy()
	end)
end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -66, 0, 5)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.ZIndex = 5
MinimizeBtn.Parent = TopBar

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
		Size = isMinimized and UDim2.new(0, 440, 0, 40) or UDim2.new(0, 440, 0, 330)
	}):Play()
end)

local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local ScriptData = {
	{
		GameName = "Granny",
		PlaceId = 1762535962,
		Icon = "rbxassetid://6031075931",
		Versions = {
			{Name = "Granny Chapter 1", Desc = "Full features for Chapter 1: ESP, Godmode.", Status = "Working", Loadstring = [[print("Granny 1")]] },
			{Name = "Granny Chapter 2", Desc = "Boat Escape automation, Infinite Ammo.", Status = "Working", Loadstring = [[print("Granny 2")]] },
			{Name = "Granny Chapter 3", Desc = "Bypass traps, Generator Auto-Fix.", Status = "Patching", Loadstring = [[print("Granny 3")]] }
		}
	},
	{
		GameName = "Flick",
		PlaceId = 0,
		Icon = "rbxassetid://6031075931",
		Versions = {
			{Name = "Flick V1 (Normal)", Desc = "Standard auto-aim and visual features.", Status = "Undetected", Loadstring = [[print("Flick V1")]] },
			{Name = "Flick V2 (Pro)", Desc = "Advanced silent aim and rapid fire.", Status = "Undetected", Loadstring = [[print("Flick V2")]] }
		}
	},
	{
		GameName = "Rivals",
		PlaceId = 17625359962,
		Icon = "rbxassetid://6031075931",
		Loadstring = [[print("Rivals Script Loaded")]]
	}
}

local LoadHubContent
local ShowKeySystem
local globalExpiryData = nil

local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Size = UDim2.new(1, 0, 1, -40)
WelcomeFrame.Position = UDim2.new(0, 0, 0, 40)
WelcomeFrame.BackgroundTransparency = 1
WelcomeFrame.ZIndex = 4
WelcomeFrame.Parent = MainFrame

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(1, 0, 0, 40)
WelcomeTitle.Position = UDim2.new(0, 0, 0.20, 0)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.Text = ""
WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeTitle.Font = Enum.Font.GothamBold
WelcomeTitle.TextSize = 32
WelcomeTitle.ZIndex = 4
WelcomeTitle.Parent = WelcomeFrame

local WelcomeSub = Instance.new("TextLabel")
WelcomeSub.Size = UDim2.new(0.85, 0, 0, 45)
WelcomeSub.Position = UDim2.new(0.075, 0, 0.38, 0)
WelcomeSub.BackgroundTransparency = 1
WelcomeSub.Text = "Welcome to Kalmin Script Hub. Experience next-generation multi-game utility suites."
WelcomeSub.TextColor3 = Color3.fromRGB(170, 180, 200)
WelcomeSub.Font = Enum.Font.Gotham
WelcomeSub.TextSize, WelcomeSub.TextWrapped = 12, true
WelcomeSub.TextTransparency = 1
WelcomeSub.ZIndex = 4
WelcomeSub.Parent = WelcomeFrame

local GetStartedBtn = Instance.new("TextButton")
GetStartedBtn.Size = UDim2.new(0.75, 0, 0, 42)
GetStartedBtn.Position = UDim2.new(0.125, 0, 0.68, 0)
GetStartedBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GetStartedBtn.BackgroundTransparency = 1
GetStartedBtn.Text = "Get Started"
GetStartedBtn.TextColor3 = Color3.fromRGB(10, 13, 20)
GetStartedBtn.TextTransparency = 1
GetStartedBtn.Font = Enum.Font.GothamBold
GetStartedBtn.TextSize = 13
GetStartedBtn.ZIndex = 4
GetStartedBtn.Parent = WelcomeFrame
Instance.new("UICorner", GetStartedBtn).CornerRadius = UDim.new(1, 0)

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(1, 0, 1, -40)
KeyFrame.Position = UDim2.new(0, 0, 0, 40)
KeyFrame.BackgroundTransparency = 1
KeyFrame.Visible = false
KeyFrame.ZIndex = 3
KeyFrame.Parent = MainFrame

local KeyCard = Instance.new("Frame")
KeyCard.Size = UDim2.new(0.9, 0, 0.82, 0)
KeyCard.Position = UDim2.new(0.05, 0, 0.08, 0)
KeyCard.BackgroundColor3 = Color3.fromRGB(15, 19, 30)
KeyCard.BackgroundTransparency = 0
KeyCard.BorderSizePixel = 0
KeyCard.ZIndex = 3
KeyCard.Parent = KeyFrame
Instance.new("UICorner", KeyCard).CornerRadius = UDim.new(0, 6)

local KeyCardStroke = Instance.new("UIStroke")
KeyCardStroke.Color = Color3.fromRGB(0, 170, 255)
KeyCardStroke.Transparency = 0.5
KeyCardStroke.Thickness = 1
KeyCardStroke.Parent = KeyCard

local KeyHeader = Instance.new("TextLabel")
KeyHeader.Size = UDim2.new(1, 0, 0, 24)
KeyHeader.Position = UDim2.new(0, 0, 0.08, 0)
KeyHeader.BackgroundTransparency = 1
KeyHeader.Text = "Kalmin Hub Authentication"
KeyHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyHeader.Font = Enum.Font.GothamBold
KeyHeader.TextSize = 15
KeyHeader.ZIndex = 4
KeyHeader.Parent = KeyCard

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.86, 0, 0, 42)
KeyInput.Position = UDim2.new(0.07, 0, 0.28, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 13, 20)
KeyInput.BackgroundTransparency = 0
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Paste your key here..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 100, 120)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 13
KeyInput.ZIndex = 4
KeyInput.Parent = KeyCard
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 4)

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Color = Color3.fromRGB(0, 170, 255)
KeyInputStroke.Transparency = 0.7
KeyInputStroke.Thickness = 1
KeyInputStroke.Parent = KeyInput

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.41, 0, 0, 38)
GetKeyBtn.Position = UDim2.new(0.07, 0, 0.54, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(24, 30, 46)
GetKeyBtn.BackgroundTransparency = 0
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(220, 230, 255)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 12
GetKeyBtn.ZIndex = 4
GetKeyBtn.Parent = KeyCard
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 4)

local AuthBtn = Instance.new("TextButton")
AuthBtn.Size = UDim2.new(0.41, 0, 0, 38)
AuthBtn.Position = UDim2.new(0.52, 0, 0.54, 0)
AuthBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
AuthBtn.BackgroundTransparency = 0
AuthBtn.BorderSizePixel = 0
AuthBtn.Text = "Authorize"
AuthBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthBtn.Font = Enum.Font.GothamBold
AuthBtn.TextSize = 12
AuthBtn.ZIndex = 4
AuthBtn.Parent = KeyCard
Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 4)

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.86, 0, 0, 38)
DiscordBtn.Position = UDim2.new(0.07, 0, 0.76, 0)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.BackgroundTransparency = 0
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Text = "Discord Community"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 12
DiscordBtn.ZIndex = 4
DiscordBtn.Parent = KeyCard
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 4)

GetKeyBtn.MouseButton1Click:Connect(function()
	if client then
		local url, response = client:getKeyUrl()
		if url then
			if setclipboard then setclipboard(url) end
			Notify("Kalmin Hub", "Key link copied to clipboard.")
		else
			Notify("Kalmin Hub", response and response.message or "Could not fetch key URL")
		end
	else
		if setclipboard then setclipboard("https://www.keyforge.win") end
		Notify("KeyForge", "SDK still initializing. Copied base link.")
	end
end)

DiscordBtn.MouseButton1Click:Connect(function()
	if setclipboard then setclipboard(DISCORD_URL) end
	Notify("Discord", "Discord invite copied to clipboard.")
end)

ShowKeySystem = function()
	KeyFrame.Visible = true
	KeyFrame.Position = UDim2.new(0, 0, 0, 40)
	for _, obj in ipairs(KeyFrame:GetDescendants()) do
		if obj:IsA("GuiObject") then obj.Visible = true end
	end
end

local function FormatTimeLeft(expiryData)
	if not expiryData then return "Lifetime" end
	if type(expiryData) == "table" then
		if expiryData.isLifetime or expiryData.lifetime then return "Lifetime" end
		expiryData = expiryData.expiresAt or expiryData.timeLeft or expiryData.expiry or expiryData.time
	end
	
	if type(expiryData) == "string" then
		if expiryData:lower() == "lifetime" then return "Lifetime" end
		expiryData = tonumber(expiryData)
	end
	
	if not expiryData or type(expiryData) ~= "number" then return "Lifetime" end
	
	local secondsLeft = 0
	if expiryData > 1000000000 then
		secondsLeft = expiryData - os.time()
	else
		secondsLeft = expiryData
	end
	
	if secondsLeft <= 0 then return "Lifetime" end
	
	local days = math.floor(secondsLeft / 86400)
	local hrs = math.floor((secondsLeft % 86400) / 3600)
	local min = math.floor((secondsLeft % 3600) / 60)
	local sec = math.floor(secondsLeft % 60)
	
	if days > 0 then
		return string.format("%d %02d %02d %02d", days, hrs, min, sec)
	elseif hrs > 0 then
		return string.format("%02d %02d %02d", hrs, min, sec)
	elseif min > 0 then
		return string.format("%02d %02d", min, sec)
	else
		return string.format("%02d", sec)
	end
end

local function ShowGameMismatchPopup(scriptName, placeId)
	if MainFrame:FindFirstChild("PopupOverlay") then return end

	local PopupOverlay = Instance.new("Frame")
	PopupOverlay.Name = "PopupOverlay"
	PopupOverlay.Size = UDim2.new(1, 0, 1, 0)
	PopupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PopupOverlay.BackgroundTransparency = 0.6
	PopupOverlay.BorderSizePixel = 0
	PopupOverlay.ZIndex = 100
	PopupOverlay.Parent = MainFrame

	local PopupBox = Instance.new("Frame")
	PopupBox.Size = UDim2.new(0, 320, 0, 160)
	PopupBox.Position = UDim2.new(0.5, -160, 0.5, -80)
	PopupBox.BackgroundColor3 = Color3.fromRGB(15, 19, 30)
	PopupBox.BackgroundTransparency = 0
	PopupBox.BorderSizePixel = 0
	PopupBox.ZIndex = 101
	PopupBox.Parent = PopupOverlay
	Instance.new("UICorner", PopupBox).CornerRadius = UDim.new(0, 6)

	local PopupStroke = Instance.new("UIStroke")
	PopupStroke.Color = Color3.fromRGB(0, 170, 255)
	PopupStroke.Transparency = 0.4
	PopupStroke.Thickness = 1.5
	PopupStroke.Parent = PopupBox

	local PopupClose = Instance.new("TextButton")
	PopupClose.Size = UDim2.new(0, 30, 0, 30)
	PopupClose.Position = UDim2.new(1, -32, 0, 2)
	PopupClose.BackgroundTransparency = 1
	PopupClose.Text = "X"
	PopupClose.TextColor3 = Color3.fromRGB(200, 200, 210)
	PopupClose.Font = Enum.Font.GothamBold
	PopupClose.TextSize = 14
	PopupClose.ZIndex = 102
	PopupClose.Parent = PopupBox

	PopupClose.MouseButton1Click:Connect(function()
		PopupOverlay:Destroy()
	end)

	local PopupTitle = Instance.new("TextLabel")
	PopupTitle.Size = UDim2.new(1, -20, 0, 40)
	PopupTitle.Position = UDim2.new(0, 10, 0, 25)
	PopupTitle.BackgroundTransparency = 1
	PopupTitle.Text = scriptName .. " Script Does Not Support This Game"
	PopupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	PopupTitle.Font = Enum.Font.GothamBold
	PopupTitle.TextSize = 13
	PopupTitle.TextWrapped = true
	PopupTitle.ZIndex = 102
	PopupTitle.Parent = PopupBox

	local PopupSub = Instance.new("TextLabel")
	PopupSub.Size = UDim2.new(1, -20, 0, 20)
	PopupSub.Position = UDim2.new(0, 10, 0, 68)
	PopupSub.BackgroundTransparency = 1
	PopupSub.Text = "Would you like to join the game?"
	PopupSub.TextColor3 = Color3.fromRGB(150, 160, 180)
	PopupSub.Font = Enum.Font.Gotham
	PopupSub.TextSize = 11
	PopupSub.ZIndex = 102
	PopupSub.Parent = PopupBox

	local JoinBtn = Instance.new("TextButton")
	JoinBtn.Size = UDim2.new(0.8, 0, 0, 36)
	JoinBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
	JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	JoinBtn.BackgroundTransparency = 0
	JoinBtn.BorderSizePixel = 0
	JoinBtn.Text = "Join Game"
	JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	JoinBtn.Font = Enum.Font.GothamBold
	JoinBtn.TextSize = 12
	JoinBtn.ZIndex = 102
	JoinBtn.Parent = PopupBox
	Instance.new("UICorner", JoinBtn).CornerRadius = UDim.new(0, 4)

	JoinBtn.MouseButton1Click:Connect(function()
		if placeId and placeId > 0 then
			pcall(function()
				TeleportService:Teleport(placeId, game.Players.LocalPlayer)
			end)
		else
			Notify("Kalmin Hub", "Invalid Place ID configured for this script.")
		end
	end)
end

LoadHubContent = function()
	local HubFrame = Instance.new("Frame")
	HubFrame.Size = UDim2.new(1, 0, 1, -40)
	HubFrame.Position = UDim2.new(0, 0, 0, 60)
	HubFrame.BackgroundTransparency = 1
	HubFrame.ZIndex = 2
	HubFrame.Parent = MainFrame

	TweenService:Create(HubFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 40)
	}):Play()
	
	local ScriptList = Instance.new("ScrollingFrame")
	ScriptList.Size = UDim2.new(1, -16, 1, -45)
	ScriptList.Position = UDim2.new(0, 8, 0, 40)
	ScriptList.BackgroundTransparency = 1
	ScriptList.BorderSizePixel = 0
	ScriptList.ScrollBarThickness = 3
	ScriptList.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
	ScriptList.ZIndex = 2
	ScriptList.Parent = HubFrame
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = ScriptList
	
	local ExpiryStatusBanner = Instance.new("TextLabel")
	ExpiryStatusBanner.Size = UDim2.new(1, -16, 0, 30)
	ExpiryStatusBanner.Position = UDim2.new(0, 8, 0, 5)
	ExpiryStatusBanner.BackgroundColor3 = Color3.fromRGB(16, 20, 32)
	ExpiryStatusBanner.BackgroundTransparency = 0.1
	ExpiryStatusBanner.Text = " Key Expiration: " .. FormatTimeLeft(globalExpiryData)
	ExpiryStatusBanner.TextColor3 = Color3.fromRGB(0, 220, 120)
	ExpiryStatusBanner.Font = Enum.Font.GothamBold
	ExpiryStatusBanner.TextSize = 11
	ExpiryStatusBanner.TextXAlignment = Enum.TextXAlignment.Left
	ExpiryStatusBanner.ZIndex = 2
	ExpiryStatusBanner.Parent = HubFrame
	Instance.new("UICorner", ExpiryStatusBanner).CornerRadius = UDim.new(0, 4)

	task.spawn(function()
		while ExpiryStatusBanner.Parent do
			ExpiryStatusBanner.Text = " Key Expiration: " .. FormatTimeLeft(globalExpiryData)
			task.wait(1)
		end
	end)

	for _, data in ipairs(ScriptData) do
		local hasVersions = data.Versions and #data.Versions > 0
		local cardHeight = hasVersions and 105 or 75

		local Card = Instance.new("Frame")
		Card.Size = UDim2.new(1, -4, 0, cardHeight)
		Card.BackgroundColor3 = Color3.fromRGB(16, 20, 32)
		Card.BackgroundTransparency = 0.15
		Card.BorderSizePixel = 0
		Card.ZIndex = 2
		Card.Parent = ScriptList
		Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 4)
		
		local Icon = Instance.new("ImageLabel")
		Icon.Size = UDim2.new(0, 45, 0, 45)
		Icon.Position = UDim2.new(0, 10, 0, 10)
		Icon.BackgroundTransparency = 1
		Icon.Image = data.Icon
		Icon.ZIndex = 2
		Icon.Parent = Card
		Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 3)
		
		local NameLabel = Instance.new("TextLabel")
		NameLabel.Size = UDim2.new(0, 180, 0, 20)
		NameLabel.Position = UDim2.new(0, 65, 0, 10)
		NameLabel.BackgroundTransparency = 1
		NameLabel.Text = data.GameName
		NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		NameLabel.TextXAlignment = Enum.TextXAlignment.Left
		NameLabel.Font = Enum.Font.GothamBold
		NameLabel.TextSize = 13
		NameLabel.ZIndex = 2
		NameLabel.Parent = Card
		
		local initialStatus = hasVersions and data.Versions[1].Status or "Working"
		local StatusLabel = Instance.new("TextLabel")
		StatusLabel.Size = UDim2.new(0, 80, 0, 16)
		StatusLabel.Position = UDim2.new(0, 65, 0, 32)
		StatusLabel.BackgroundTransparency = 1
		StatusLabel.Text = "• " .. initialStatus
		StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
		StatusLabel.Font = Enum.Font.Gotham
		StatusLabel.TextSize = 10
		StatusLabel.TextColor3 = Color3.fromRGB(80, 220, 120)
		StatusLabel.ZIndex = 2
		StatusLabel.Parent = Card

		local RunBtn = Instance.new("TextButton")
		RunBtn.Size = UDim2.new(0, 80, 0, 30)
		RunBtn.Position = UDim2.new(1, -90, 0, 10)
		RunBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		RunBtn.BackgroundTransparency = 0
		RunBtn.BorderSizePixel = 0
		RunBtn.Text = "RUN"
		RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		RunBtn.Font = Enum.Font.GothamBold
		RunBtn.TextSize = 11
		RunBtn.ZIndex = 2
		RunBtn.Parent = Card
		Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 3)

		local selectedIndex = 1

		if hasVersions then
			local VersionDropdown = Instance.new("TextButton")
			VersionDropdown.Size = UDim2.new(0, 155, 0, 24)
			VersionDropdown.Position = UDim2.new(0, 10, 0, 68)
			VersionDropdown.BackgroundColor3 = Color3.fromRGB(24, 30, 44)
			VersionDropdown.BackgroundTransparency = 0
			VersionDropdown.BorderSizePixel = 0
			VersionDropdown.Text = " Select: " .. data.Versions[1].Name
			VersionDropdown.TextColor3 = Color3.fromRGB(200, 200, 200)
			VersionDropdown.TextXAlignment = Enum.TextXAlignment.Left
			VersionDropdown.Font = Enum.Font.Gotham
			VersionDropdown.TextSize = 10
			VersionDropdown.ZIndex = 2
			VersionDropdown.Parent = Card
			Instance.new("UICorner", VersionDropdown).CornerRadius = UDim.new(0, 3)

			local DescLabel = Instance.new("TextLabel")
			DescLabel.Size = UDim2.new(0, 200, 0, 28)
			DescLabel.Position = UDim2.new(0, 175, 0, 66)
			DescLabel.BackgroundTransparency = 1
			DescLabel.Text = data.Versions[1].Desc
			DescLabel.TextColor3 = Color3.fromRGB(150, 160, 180)
			DescLabel.TextWrapped = true
			DescLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescLabel.Font = Enum.Font.Gotham
			DescLabel.TextSize = 9
			DescLabel.ZIndex = 2
			DescLabel.Parent = Card

			local DropdownList = Instance.new("ScrollingFrame")
			DropdownList.Size = UDim2.new(0, 155, 0, 0)
			DropdownList.Position = UDim2.new(0, 10, 0, 94)
			DropdownList.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
			DropdownList.BackgroundTransparency = 0
			DropdownList.BorderSizePixel = 0
			DropdownList.Visible = false
			DropdownList.ZIndex = 10
			DropdownList.ScrollBarThickness = 2
			DropdownList.Parent = Card
			Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0, 3)

			local DropLayout = Instance.new("UIListLayout")
			DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
			DropLayout.Parent = DropdownList

			local dropdownOpen = false

			for i, ver in ipairs(data.Versions) do
				local Opt = Instance.new("TextButton")
				Opt.Size = UDim2.new(1, 0, 0, 24)
				Opt.BackgroundColor3 = Color3.fromRGB(18, 22, 34)
				Opt.BackgroundTransparency = 0
				Opt.BorderSizePixel = 0
				Opt.ZIndex = 11
				Opt.Text = " " .. ver.Name
				Opt.TextColor3 = Color3.fromRGB(220, 220, 220)
				Opt.TextXAlignment = Enum.TextXAlignment.Left
				Opt.Font = Enum.Font.Gotham
				Opt.TextSize = 10
				Opt.Parent = DropdownList

				Opt.MouseButton1Click:Connect(function()
					selectedIndex = i
					VersionDropdown.Text = " Select: " .. ver.Name
					DescLabel.Text = ver.Desc
					StatusLabel.Text = "• " .. ver.Status
					dropdownOpen = false
					TweenService:Create(DropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 155, 0, 0)}):Play()
					task.wait(0.25)
					DropdownList.Visible = false
				end)
			end

			VersionDropdown.MouseButton1Click:Connect(function()
				dropdownOpen = not dropdownOpen
				if dropdownOpen then
					DropdownList.Visible = true				
					TweenService:Create(DropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 155, 0, math.min(#data.Versions * 24, 75))}):Play()
				else
					TweenService:Create(DropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 155, 0, 0)}):Play()
					task.wait(0.25)
					DropdownList.Visible = false
				end
			end)
		else
			local DescLabel = Instance.new("TextLabel")
			DescLabel.Size = UDim2.new(0, 250, 0, 20)
			DescLabel.Position = UDim2.new(0, 65, 0, 50)
			DescLabel.BackgroundTransparency = 1
			DescLabel.Text = "Universal Script Utility"
			DescLabel.TextColor3 = Color3.fromRGB(150, 160, 180)
			DescLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescLabel.Font = Enum.Font.Gotham
			DescLabel.TextSize = 9
			DescLabel.ZIndex = 2
			DescLabel.Parent = Card
		end

		local isRunning = false
		RunBtn.MouseButton1Click:Connect(function()
			if isRunning then return end
			isRunning = true

			if data.PlaceId and data.PlaceId > 0 and game.PlaceId ~= data.PlaceId then
				ShowGameMismatchPopup(data.GameName, data.PlaceId)
				isRunning = false
				return
			end

			local codeToRun = hasVersions and data.Versions[selectedIndex].Loadstring or data.Loadstring
			local fade = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 440, 0, 0)
			})
			fade:Play()
			fade.Completed:Connect(function()
				ScreenGui:Destroy()
				pcall(function() loadstring(codeToRun)() end)
			end)
		end)
	end
	
	ScriptList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end

local function PlayExecuteFadeIn()
	TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0.04
	}):Play()
	TweenService:Create(MainStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Transparency = 0.35
	}):Play()

	task.spawn(function()
		task.wait(0.4)
		local targetText = "HELLO."
		for i = 1, #targetText do
			WelcomeTitle.Text = targetText:sub(1, i)
			task.wait(0.12)
		end

		task.wait(0.3)
		TweenService:Create(WelcomeSub, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
		
		task.wait(1.5)
		TweenService:Create(GetStartedBtn, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
	end)
end

task.spawn(function()
	local autoValidated = false
	pcall(function()
		if readfile and isfile and isfile(KEY_FILE) then
			local savedKey = readfile(KEY_FILE)
			if savedKey and savedKey ~= "" then
				if client then
					local verified = client:verify(savedKey)
					if verified and verified.ok then
						globalExpiryData = verified
						autoValidated = true
					else
						pcall(function() if delfile then delfile(KEY_FILE) end end)
						local expiryDuration = verified and (verified.expiresAt or verified.timeLeft or 0) or 0
						if expiryDuration >= 604800 then
							Notify("Kalmin Hub", "key expired, buy a new one")
						else
							Notify("Kalmin Hub", "key expired, get a new one")
						end
					end
				else
					autoValidated = true
					globalExpiryData = {isLifetime = true}
				end
			end
		end
	end)

	if autoValidated then
		TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.04
		}):Play()
		TweenService:Create(MainStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 0.35
		}):Play()
		WelcomeFrame:Destroy()
		LoadHubContent()
	else
		PlayExecuteFadeIn()
	end
end)

GetStartedBtn.MouseButton1Click:Connect(function()
	local fadeOut = TweenService:Create(WelcomeFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = 1})
	fadeOut:Play()
	for _, child in ipairs(WelcomeFrame:GetChildren()) do
		if child:IsA("GuiObject") then
			TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		end
		if child:IsA("TextLabel") or child:IsA("TextButton") then
			TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
		end
	end
	task.wait(0.4)
	WelcomeFrame:Destroy()
	ShowKeySystem()
end)

AuthBtn.MouseButton1Click:Connect(function()
	local enteredKey = KeyInput.Text:gsub("%s+", "")
	if enteredKey == "" then
		Notify("Kalmin Hub", "Please input your key first")
		return
	end
	
	AuthBtn.Text = "Verifying..."
	
	task.spawn(function()
		local isValid = false
		local errorMsg = "Verification failed"
		local expiryVal = 0
		
		if client then
			local verified = client:verify(enteredKey)
			if verified and verified.ok then
				isValid = true
				globalExpiryData = verified
				expiryVal = verified.expiresAt or verified.timeLeft or 0
			else
				errorMsg = verified and verified.message or "Invalid key"
			end
		else
			if #enteredKey >= 5 then
				isValid = true
				globalExpiryData = {isLifetime = true}
			else
				errorMsg = "SDK not initialized yet."
			end
		end
		
		if isValid then
			pcall(function()
				if writefile then
					writefile(KEY_FILE, enteredKey)
				end
			end)

			Notify("Kalmin Hub", "Key Validated Successfully!")
			AuthBtn.Text = "Success!"
			
			local slideTween = TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 0, -1, 0)
			})
			
			local info = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			for _, obj in ipairs(KeyFrame:GetDescendants()) do
				if obj:IsA("GuiObject") then
					pcall(function() TweenService:Create(obj, info, {BackgroundTransparency = 1}):Play() end)
				end
				if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					pcall(function() TweenService:Create(obj, info, {TextTransparency = 1}):Play() end)
				end
				if obj:IsA("UIStroke") then
					pcall(function() TweenService:Create(obj, info, {Transparency = 1}):Play() end)
				end
			end
			
			slideTween:Play()
			slideTween.Completed:Connect(function()
				KeyFrame:Destroy()
				LoadHubContent()
			end)
		else
			if expiryVal >= 604800 then
				Notify("Kalmin Hub", "key expired, buy a new one")
			else
				Notify("Kalmin Hub", "key expired, get a new one")
			end
			AuthBtn.Text = "Authorize"
		end
	end)
end)