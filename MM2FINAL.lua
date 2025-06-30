-- Team Celat's Hub | MM2 Pro Mobil Dostu Tam Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- GUI oluştur
local CelatsGUI = Instance.new("ScreenGui")
CelatsGUI.Name = "CelatsHubProMobile"
CelatsGUI.ResetOnSpawn = false
CelatsGUI.Parent = CoreGui

local CHLogo = Instance.new("TextLabel")
CHLogo.Size = UDim2.new(0, 100, 0, 40)
CHLogo.Position = UDim2.new(0, 10, 0, 60)
CHLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
CHLogo.TextColor3 = Color3.new(1, 1, 1)
CHLogo.Text = "CH"
CHLogo.Font = Enum.Font.GothamBlack
CHLogo.TextSize = 24
CHLogo.ZIndex = 20
CHLogo.Active = true
CHLogo.Draggable = true
CHLogo.Parent = CelatsGUI

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.Text = "Team Celat's Hub"
TitleLabel.Font = Enum.Font.Arcade
TitleLabel.TextSize = 30
TitleLabel.TextStrokeTransparency = 0
TitleLabel.Parent = CelatsGUI

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 600)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = CelatsGUI

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, 0, 1, 0)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 1400)
Scroll.ScrollBarThickness = 8
Scroll.BackgroundTransparency = 1
Scroll.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = Scroll

-- Dil seçimi paneli
local langFrame = Instance.new("Frame")
langFrame.Size = UDim2.new(0, 320, 0, 160)
langFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
langFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
langFrame.BorderSizePixel = 2
langFrame.Parent = CelatsGUI

local langTitle = Instance.new("TextLabel")
langTitle.Size = UDim2.new(1, 0, 0, 40)
langTitle.BackgroundTransparency = 1
langTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
langTitle.Text = "Select Language / Dil Seçiniz"
langTitle.Font = Enum.Font.SourceSansBold
langTitle.TextSize = 22
langTitle.Parent = langFrame

local function createLangButton(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 50)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Parent = langFrame
    btn.MouseButton1Click:Connect(callback)
end

-- Genel yardımcı fonksiyonlar
local function AddButton(text, parent, y, callback, emoji)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 480, 0, 45)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parent
    btn.Text = (emoji and (emoji.." ") or "")..text
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function AddToggle(text, parent, y, default, callback, emoji)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 480, 0, 45)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Text = (emoji and (emoji.." ") or "")..text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 20
    label.Size = UDim2.new(0.8, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.2, -10, 0.7, 0)
    toggle.Position = UDim2.new(0.8, 5, 0.15, 0)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 0, 0)
    toggle.Text = default and "ON" or "OFF"
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 18
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Parent = frame

    local enabled = default

    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 0, 0)
        toggle.Text = enabled and "ON" or "OFF"
        callback(enabled)
    end)
    return frame, toggle
end

local function AddSliderWithBox(text, parent, y, min, max, default, callback, emoji)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 480, 0, 60)
    frame.Position = UDim2.new(0, 0, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Text = (emoji and (emoji.." ") or "")..text..": "..tostring(default)
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local sliderBox = Instance.new("TextBox")
    sliderBox.Size = UDim2.new(1, 0, 0, 30)
    sliderBox.Position = UDim2.new(0, 0, 0, 25)
    sliderBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
    sliderBox.TextColor3 = Color3.new(1,1,1)
    sliderBox.Text = tostring(default)
    sliderBox.ClearTextOnFocus = false
    sliderBox.Font = Enum.Font.SourceSansBold
    sliderBox.TextSize = 20
    sliderBox.Parent = frame

    sliderBox.FocusLost:Connect(function()
        local val = tonumber(sliderBox.Text)
        if val and val >= min and val <= max then
            label.Text = (emoji and (emoji.." ") or "")..text..": "..tostring(val)
            callback(val)
        else
            sliderBox.Text = tostring(default)
        end
    end)
    return frame, sliderBox, label
end

-- Roller ve işlevleri
local function isKiller(p)
    return p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife"))
end
local function isSheriff(p)
    return p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun"))
end
local function isInnocent(p)
    return not isKiller(p) and not isSheriff(p)
end

local function killRole(roleCheck)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            if roleCheck(p) then
                p.Character.Humanoid.Health = 0
            end
        end
    end
end

-- ESP Highlight
local function createESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local highlight = player.Character:FindFirstChildOfClass("Highlight") or Instance.new("Highlight")
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 1
            highlight.Adornee = player.Character
            highlight.Parent = player.Character
            if isKiller(player) then
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            elseif isSheriff(player) then
                highlight.FillColor = Color3.fromRGB(0, 0, 255)
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end

-- Kahkaha atma
local function laugh()
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🤣 HAHAHAHA", "All")
end

-- Otomatik kazanma (haritaya ışınlanma)
local function autoWin()
    local map = workspace:FindFirstChild("Map")
    if map and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(map.Position))
    end
end

-- FPS limiti ayarı (Delta Executor destekli)
local function setFPS(cap)
    if setfpscap then
        setfpscap(cap)
    elseif setfpscapfunction then
        setfpscapfunction(cap)
    elseif setfps then
        setfps(cap)
    end
end

-- Hız ve zıplama
local speed = 16
local jumpPower = 50
local function updateSpeedJump()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
        LocalPlayer.Character.Humanoid.JumpPower = jumpPower
    end
end

-- NoClip modu
local noclip = false
local noclipConn
local function toggleNoClip()
    noclip = not noclip
    if noclip then
        noclipConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- God Mode
local godMode = false
local godConn
local function toggleGodMode()
    godMode = not godMode
    if godMode then
        godConn = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
            else
                if godConn then
                    godConn:Disconnect()
                    godConn = nil
                end
            end
        end)
    else
        if godConn then
            godConn:Disconnect()
            godConn = nil
        end
    end
end

-- Chat bildirimi
local function sendChatNotification(msg)
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
end

-- Otomatik silah alma
local weaponPickupConn
local function autoPickupWeapon()
    if weaponPickupConn then weaponPickupConn:Disconnect() end
    weaponPickupConn = RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            for _, item in pairs(workspace:GetChildren()) do
                if item.Name == "Knife" or item.Name == "Gun" then
                    local dist = (item.Position - hrp.Position).Magnitude
                    if dist < 10 then
                        if item:IsA("Tool") then
                            item.Parent = LocalPlayer.Backpack
                        end
                    end
                end
            end
        end
    end)
end

-- Aimbot (basit, katili kilitler ve hedefe bakar)
local aimbotEnabled = false
local function getKiller()
    for _, p in pairs(Players:GetPlayers()) do
        if isKiller(p) then
            return p
        end
    end
    return nil
end
local function aimbot()
    if not aimbotEnabled then return end
    local target = getKiller()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                LocalPlayer.Character.HumanoidRootPart.Position,
                target.Character.Head.Position
            )
        end
    end
end
RunService.RenderStepped:Connect(aimbot)

-- Menü aç/kapa tuşu (CH Logo dokunma)
local toggleDebounce = false
CHLogo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not toggleDebounce then
        toggleDebounce = true
        MainFrame.Visible = not MainFrame.Visible
        wait(0.3)
        toggleDebounce = false
    end
end)

-- Dil seçimi sonrası menü butonlarını ekle
local currentLang = "TR"
local buttonY = 10
local buttonHeight = 50
local buttons = {}

local function clearButtons()
    for _, btn in pairs(buttons) do
        btn:Destroy()
    end
    buttons = {}
end

local function addButtonY()
    buttonY = buttonY + buttonHeight + 5
end

local function setupMenu(lang)
    clearButtons()
    buttonY = 10
    currentLang = lang

    local function tr(text) return (lang == "TR") and text or "" end
    local function en(text) return (lang == "EN") and text or "" end

    local function localize(trText, enText)
        if lang == "TR" then return trText else return enText end
    end

    buttons[#buttons+1] = AddButton(localize("🔪 Katili Öldür", "🔪 Kill the Murderer"), Scroll, buttonY, function() killRole(isKiller) end, "🔪")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("🔵 Şerifi Öldür", "🔵 Kill the Sheriff"), Scroll, buttonY, function() killRole(isSheriff) end, "🔵")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("🟢 Masumları Öldür", "🟢 Kill the Innocents"), Scroll, buttonY, function() killRole(isInnocent) end, "🟢")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("🤣 Kahkaha At", "🤣 Laugh"), Scroll, buttonY, laugh, "🤣")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("🏆 Otomatik Kazan", "🏆 Auto Win"), Scroll, buttonY, autoWin, "🏆")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("👁️ Rol ESP Göster", "👁️ Show Role ESP"), Scroll, buttonY, createESP, "👁️")
    addButtonY()
    buttons[#buttons+1] = AddButton(localize("🎮 FPS 60 Limiti", "🎮 FPS Limit 60"), Scroll, buttonY, function() setFPS(60) end, "🎮")
    addButtonY()
    buttons[#buttons+1] = AddToggle(localize("🚫 NoClip Aç/Kapa", "🚫 Toggle NoClip"), Scroll, buttonY, false, toggleNoClip, "🚫")
    addButtonY()
    buttons[#buttons+1] = AddToggle(localize("🛡️ God Mode Aç/Kapa", "🛡️ Toggle God Mode"), Scroll, buttonY, false, toggleGodMode, "🛡️")
    addButtonY()
    buttons[#buttons+1] = AddToggle(localize("🔫 Otomatik Silah Alma", "🔫 Auto Pickup Weapon"), Scroll, buttonY, false, auto
