-- Team Celat's Hub - PRO MM2 Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- GUI Setup
local CelatsGUI = Instance.new("ScreenGui")
CelatsGUI.Name = "CelatsHubPro"
CelatsGUI.ResetOnSpawn = false
CelatsGUI.Parent = CoreGui

-- CH Logo (Sürüklenebilir, tıklayınca menü açar)
local CHLogo = Instance.new("TextLabel")
CHLogo.Name = "CHLogo"
CHLogo.Size = UDim2.new(0, 100, 0, 40)
CHLogo.Position = UDim2.new(0, 10, 0, 60)
CHLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
CHLogo.TextColor3 = Color3.new(1, 1, 1)
CHLogo.Text = "CH"
CHLogo.Font = Enum.Font.GothamBlack
CHLogo.TextSize = 24
CHLogo.Active = true
CHLogo.Draggable = true
CHLogo.Parent = CelatsGUI

-- Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 650)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = CelatsGUI

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = MainFrame

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
TitleLabel.Text = "Team Celat's Hub"
TitleLabel.Font = Enum.Font.Arcade
TitleLabel.TextSize = 32
TitleLabel.TextStrokeTransparency = 0
TitleLabel.Parent = MainFrame

-- Language Setup
local currentLang = "TR"
local function localize(tr, en)
    return currentLang == "TR" and tr or en
end

-- Button Creator with Emoji and toggle highlight
local buttons = {}
local toggledButtons = {}
local function CreateButton(text, emoji, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = emoji .. " " .. text
    btn.Parent = MainFrame

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        toggledButtons[text] = toggled
        callback(toggled)
    end)
    buttons[text] = btn
    return btn
end

local function CreateSimpleButton(text, emoji, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = emoji .. " " .. text
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Role Checkers
local function IsKiller(p)
    return p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife"))
end
local function IsSheriff(p)
    return p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun"))
end
local function IsInnocent(p)
    return not IsKiller(p) and not IsSheriff(p)
end

-- Kill players by role
local function KillByRole(roleFunc)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            if roleFunc(p) then
                p.Character.Humanoid.Health = 0
            end
        end
    end
end

-- Chat notification
local function SendChat(msg)
    local chatEvent = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
    chatEvent:FireServer(msg, "All")
end

-- ESP Highlights
local espEnabled = false
local function UpdateESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local hl = p.Character:FindFirstChildOfClass("Highlight")
            if espEnabled then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Parent = p.Character
                    hl.Adornee = p.Character
                end
                if IsKiller(p) then
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                elseif IsSheriff(p) then
                    hl.FillColor = Color3.fromRGB(0, 0, 255)
                else
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                end
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 1
            else
                if hl then
                    hl:Destroy()
                end
            end
        end
    end
end-- Toggle ESP
local function ToggleESP(state)
    espEnabled = state
    UpdateESP()
    SendChat(state and localize("ESP Açıldı!", "ESP Enabled!") or localize("ESP Kapatıldı!", "ESP Disabled!"))
end

-- Speed & Jump
local speed = 16
local jumpPower = 50
local function UpdateSpeedJump()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
        LocalPlayer.Character.Humanoid.JumpPower = jumpPower
    end
end

local function SetSpeed(val)
    speed = val
    UpdateSpeedJump()
    SendChat(localize("Hız ayarlandı: ", "Speed set to: ") .. val)
end

local function SetJump(val)
    jumpPower = val
    UpdateSpeedJump()
    SendChat(localize("Zıplama ayarlandı: ", "Jump set to: ") .. val)
end

-- Auto Pickup Weapon
local autoPickup = false
local pickupConn
local function ToggleAutoPickup(state)
    autoPickup = state
    if autoPickup then
        pickupConn = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, item in pairs(workspace:GetChildren()) do
                    if (item.Name == "Knife" or item.Name == "Gun") and item:IsA("Tool") then
                        local dist = (item.Position - hrp.Position).Magnitude
                        if dist < 10 then
                            item.Parent = LocalPlayer.Backpack
                        end
                    end
                end
            end
        end)
    else
        if pickupConn then
            pickupConn:Disconnect()
            pickupConn = nil
        end
    end
    SendChat(localize("Otomatik silah alma " .. (state and "açıldı!" or "kapandı!"), "Auto pickup " .. (state and "enabled!" or "disabled!")))
end

-- God Mode
local godMode = false
local godConn
local function ToggleGodMode(state)
    godMode = state
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
    SendChat(localize("God Mode " .. (state and "açıldı!" or "kapandı!"), "God Mode " .. (state and "enabled!" or "disabled!")))
end

-- NoClip
local noclip = false
local noclipConn
local function ToggleNoClip(state)
    noclip = state
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
    SendChat(localize("NoClip " .. (state and "açıldı!" or "kapandı!"), "NoClip " .. (state and "enabled!" or "disabled!")))
end

-- Aimbot (Katil'i hedefler)
local aimbot = false
RunService.RenderStepped:Connect(function()
    if aimbot then
        local target = nil
        for _, p in pairs(Players:GetPlayers()) do
            if IsKiller(p) then
                target = p
                break
            end
        end
        if target and target.Character and target.Character:FindFirstChild("Head") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, target.Character.Head.Position)
            end
        end
    end
end)

-- Kill Buttons (Tek Tıkla)
CreateSimpleButton(localize("Katil Katili Öldür", "Kill Murderer"), "🔪", function()
    KillByRole(IsKiller)
    SendChat(localize("Katil Öldürüldü!", "Killer killed!"))
end)
CreateSimpleButton(localize("Şerifi Öldür", "Kill Sheriff"), "🔵", function()
    KillByRole(IsSheriff)
    SendChat(localize("Şerif Öldürüldü!", "Sheriff killed!"))
end)
CreateSimpleButton(localize("Masumları Öldür", "Kill Innocents"), "🟢", function()
    KillByRole(IsInnocent)
    SendChat(localize("Masumlar Öldürüldü!", "Innocents killed!"))
end)

-- Toggles with highlight
CreateButton(localize("ESP", "ESP"), "👁️", ToggleESP)
CreateButton(localize("Otomatik Silah Alma", "Auto Pickup"), "🎒", ToggleAutoPickup)
CreateButton(localize("God Mode", "God Mode"), "🛡️", ToggleGodMode)
CreateButton(localize("NoClip", "NoClip"), "👻", ToggleNoClip)
CreateButton(localize("Aimbot (Katil Hedefle)", "Aimbot (Lock Killer)"), "🎯", function(state)
    aimbot = state
    SendChat(localize("Aimbot " .. (state and "açıldı!" or "kapandı!"), "Aimbot " .. (state and "enabled!" or "disabled!")))
end)

-- Speed / Jump Ayarları
local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.9, 0, 0, 30)
speedSlider.Position = UDim2.new(0.05, 0, 0, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.Font = Enum.Font.SourceSansBold
speedSlider.TextSize = 18
speedSlider.PlaceholderText = localize("Hız (16-100)", "Speed (16-100)")
speedSlider.Text = tostring(speed)
speedSlider.Parent = MainFrame

speedSlider.FocusLost:Connect(function()
    local val = tonumber(speedSlider.Text)
    if val and val >= 16 and val <= 100 then
        SetSpeed(val)
    else
        speedSlider.Text = tostring(speed)
    end
end)

local jumpSlider = Instance.new("TextBox")
jumpSlider.Size = UDim2.new(0.9, 0, 0, 30)
jumpSlider.Position = UDim2.new(0.05, 0, 0, 40)
jumpSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpSlider.TextColor3 = Color3.new(1,1,1)
jumpSlider.Font = Enum.Font.SourceSansBold
jumpSlider.TextSize = 18
jumpSlider.PlaceholderText = localize("Zıplama (50-200)", "Jump (50-200)")
jumpSlider.Text = tostring(jumpPower)
jumpSlider.Parent = MainFrame

jumpSlider.FocusLost:Connect(function()
    local val = tonumber(jumpSlider.Text)
    if val and val >= 50 and val <= 200 then
        SetJump(val)
    else
        jumpSlider.Text = tostring(jumpPower)
    end
end)

-- Menü aç/kapa
local toggleDebounce = false
CHLogo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not toggleDebounce then
        toggleDebounce = true
        MainFrame.Visible = not MainFrame.Visible
        wait(0.3)
        toggleDebounce = false
    end
end)

print("Team Celat's Hub PRO Script loaded!")
