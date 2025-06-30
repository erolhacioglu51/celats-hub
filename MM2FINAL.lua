-- Team Celat's Hub - MM2 Script v2

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CelatsHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Loading Frame
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.TextColor3 = Color3.fromRGB(0, 255, 255)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 28
LoadingText.Text = "Celat's Hub Yükleniyor..."
LoadingText.Parent = LoadingFrame

-- Wait 3 seconds then remove loading frame
task.delay(3, function()
    LoadingFrame:Destroy()
    -- Show Language Selection
    languageSelectionFrame.Visible = true
end)

-- Language Selection Frame
local languageSelectionFrame = Instance.new("Frame")
languageSelectionFrame.Size = UDim2.new(0, 350, 0, 150)
languageSelectionFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
languageSelectionFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 70)
languageSelectionFrame.BorderSizePixel = 0
languageSelectionFrame.Visible = false
languageSelectionFrame.Parent = ScreenGui

local langTitle = Instance.new("TextLabel")
langTitle.Size = UDim2.new(1, 0, 0, 50)
langTitle.BackgroundTransparency = 1
langTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
langTitle.Font = Enum.Font.Arcade
langTitle.TextSize = 30
langTitle.Text = "Team Celat's Hub"
langTitle.Parent = languageSelectionFrame

local promptText = Instance.new("TextLabel")
promptText.Size = UDim2.new(1, 0, 0, 30)
promptText.Position = UDim2.new(0, 0, 0, 55)
promptText.BackgroundTransparency = 1
promptText.TextColor3 = Color3.fromRGB(0, 200, 255)
promptText.Font = Enum.Font.GothamBold
promptText.TextSize = 20
promptText.Text = "Dil seçiniz / Choose Language"
promptText.Parent = languageSelectionFrame

local function localize(tr, en)
    return selectedLanguage == "TR" and tr or en
end

local selectedLanguage = nil

-- Buttons Container Frame (for horizontal layout)
local buttonsContainer = Instance.new("Frame")
buttonsContainer.Size = UDim2.new(0, 300, 0, 50)
buttonsContainer.Position = UDim2.new(0.5, -150, 0, 90)
buttonsContainer.BackgroundTransparency = 1
buttonsContainer.Parent = languageSelectionFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = buttonsContainer
UIListLayout.Padding = UDim.new(0, 20)

local trButton = Instance.new("TextButton")
trButton.Size = UDim2.new(0, 120, 1, 0)
trButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
trButton.TextColor3 = Color3.new(1, 1, 1)
trButton.Font = Enum.Font.GothamBold
trButton.TextSize = 22
trButton.Text = "Türkçe 🇹🇷"
trButton.Parent = buttonsContainer

local enButton = Instance.new("TextButton")
enButton.Size = UDim2.new(0, 120, 1, 0)
enButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
enButton.TextColor3 = Color3.new(1, 1, 1)
enButton.Font = Enum.Font.GothamBold
enButton.TextSize = 22
enButton.Text = "English 🇺🇸"
enButton.Parent = buttonsContainer

-- Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 500)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
titleLabel.Font = Enum.Font.Arcade
titleLabel.TextSize = 32
titleLabel.Text = "Team Celat's Hub"
titleLabel.Parent = MainFrame

local buttonsHolder = Instance.new("Frame")
buttonsHolder.Size = UDim2.new(1, -20, 0, 40)
buttonsHolder.Position = UDim2.new(0, 10, 0, 60)
buttonsHolder.BackgroundTransparency = 1
buttonsHolder.Parent = MainFrame

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.FillDirection = Enum.FillDirection.Horizontal
buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.Padding = UDim.new(0, 10)
buttonLayout.Parent = buttonsHolder

local function CreateButton(text, emoji, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = emoji .. " " .. text
    btn.Parent = buttonsHolder

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        btn.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
        callback(toggled)
    end)
end

-- CH Logo (Draggable & Toggle Menu)
local CHLogo = Instance.new("TextLabel")
CHLogo.Name = "CHLogo"
CHLogo.Size = UDim2.new(0, 100, 0, 40)
CHLogo.Position = UDim2.new(0, 10, 0, 10)
CHLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
CHLogo.TextColor3 = Color3.new(1, 1, 1)
CHLogo.Text = "CH"
CHLogo.Font = Enum.Font.GothamBlack
CHLogo.TextSize = 24
CHLogo.Active = true
CHLogo.Draggable = true
CHLogo.Parent = ScreenGui

local toggleDebounce = false
CHLogo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if not toggleDebounce then
            toggleDebounce = true
            MainFrame.Visible = not MainFrame.Visible
            languageSelectionFrame.Visible = false
            toggleDebounce = false
        end
    end
end)

-- Language selection buttons behavior
trButton.MouseButton1Click:Connect(function()
    selectedLanguage = "TR"
    languageSelectionFrame.Visible = false
    MainFrame.Visible = true
    print("🌟🚀 Celat's Hub başarıyla açıldı! MM2’de artık kral sensin! Hadi oyunu sallayalım! 💙🔥")
end)

enButton.MouseButton1Click:Connect(function()
    selectedLanguage = "EN"
    languageSelectionFrame.Visible = false
    MainFrame.Visible = true
    print("🌟🚀 Celat's Hub loaded successfully! You are the king in MM2 now! Let's rock the game! 💙🔥")
end)

-- Example buttons (add your features here)
CreateButton("ESP", "👁️", function(state)
    print(state and "ESP aktif!" or "ESP kapatıldı.")
end)

CreateButton("God Mode", "👑", function(state)
    print(state and "God Mode aktif!" or "God Mode kapatıldı.")
end)

CreateButton("Kill Murderer", "🔪", function()
    print("Katil öldürüldü!")
end)

CreateButton("Kill Sheriff", "🔵", function()
    print("Şerif öldürüldü!")
end)

CreateButton("Kill Innocents", "🟢", function()
    print("Masumlar öldürüldü!")
end)

CreateButton("Auto Win", "🏆", function()
    print("Otomatik kazanma aktif!")
end)

-- You can continue adding other buttons here...
