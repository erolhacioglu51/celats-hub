-- Celat's Hub - PRO MM2 Script (Delta Executor Uyumlu)
-- Hazırlayan: Team Celat’s Hub™

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local CelatsGUI = Instance.new("ScreenGui", CoreGui)
CelatsGUI.Name = "CelatsHubPro"
CelatsGUI.ResetOnSpawn = false

local IntroFrame = Instance.new("Frame", CelatsGUI)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.ZIndex = 10

local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.Text = "Celat's Hub Yükleniyor..."
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.BackgroundTransparency = 1
IntroText.TextScaled = true
IntroText.Font = Enum.Font.SourceSansBold

spawn(function()
    wait(3)
    IntroFrame:Destroy()
end)

local clickSound = Instance.new("Sound", CelatsGUI)
clickSound.SoundId = "rbxassetid://12222005"
clickSound.Volume = 1

local CHLogo = Instance.new("TextButton")
CHLogo.Name = "CHLogo"
CHLogo.Text = "CH"
CHLogo.Size = UDim2.new(0, 60, 0, 60)
CHLogo.Position = UDim2.new(0, 20, 0.4, 0)
CHLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CHLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
CHLogo.Font = Enum.Font.SourceSansBold
CHLogo.TextSize = 24
CHLogo.Draggable = true
CHLogo.Active = true
CHLogo.Parent = CelatsGUI

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 650)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = CelatsGUI

CHLogo.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.FillDirection = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ListLayout.Parent = MainFrame

local activeButton = nil

local function AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 430, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Parent = MainFrame

    btn.MouseButton1Click:Connect(function()
        clickSound:Play()
        if activeButton ~= btn then
            if activeButton then
                activeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            activeButton = btn
            callback()
        else
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            activeButton = nil
            -- Buraya kapatma kodu eklenebilir, örn highlight iptali
        end
    end)
end

-- TextBox'lu Speed & Jump
local speedBox = Instance.new("TextBox")
speedBox.PlaceholderText = "Speed (Varsayılan: 16)"
speedBox.Size = UDim2.new(0, 210, 0, 40)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 18
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Parent = MainFrame

local jumpBox = Instance.new("TextBox")
jumpBox.PlaceholderText = "Jump (Varsayılan: 50)"
jumpBox.Size = UDim2.new(0, 210, 0, 40)
jumpBox.Font = Enum.Font.SourceSans
jumpBox.TextSize = 18
jumpBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBox.Parent = MainFrame

AddButton("⚙️ Uygula Speed & Jump", function()
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = tonumber(speedBox.Text) or 16
        h.JumpPower = tonumber(jumpBox.Text) or 50
    end
end)

-- Rol Highlight için aktif durumu kontrolü
local highlightEnabled = false
local function ToggleHighlight()
    if highlightEnabled then
        -- Kapat
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local oldHighlight = p.Character.HumanoidRootPart:FindFirstChild("RoleHighlight")
                if oldHighlight then oldHighlight:Destroy() end
            end
        end
        highlightEnabled = false
    else
        -- Aç
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local oldHighlight = p.Character.HumanoidRootPart:FindFirstChild("RoleHighlight")
                if oldHighlight then oldHighlight:Destroy() end

                local highlight = Instance.new("BoxHandleAdornment")
                highlight.Name = "RoleHighlight"
                highlight.Adornee = p.Character.HumanoidRootPart
                highlight.AlwaysOnTop = true
                highlight.ZIndex = 10
                highlight.Size = Vector3.new(4, 6, 2)
                highlight.Transparency = 0.6
                highlight.Parent = p.Character.HumanoidRootPart

                if p.Backpack:FindFirstChild("Knife") then
                    highlight.Color3 = Color3.fromRGB(255, 0, 0)
                elseif p.Backpack:FindFirstChild("Gun") then
                    highlight.Color3 = Color3.fromRGB(0, 170, 255)
                else
                    highlight.Color3 = Color3.fromRGB(0, 255, 0)
                end
            end
        end
        highlightEnabled = true
    end
end

AddButton("✨ Rol Highlight", function()
    ToggleHighlight()
end)

-- Rol Tespiti ve Chat Bildirimi
AddButton("🎯 Rol Tespiti", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Knife") then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔪 Katil: "..p.Name, "All")
        elseif p.Backpack:FindFirstChild("Gun") then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔫 Şerif: "..p.Name, "All")
        end
    end
end)

-- Katili Öldür
AddButton("🔪 Katili Öldür", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Backpack:FindFirstChild("Knife") and p.Character then
            p.Character:BreakJoints()
        end
    end
end)

-- Şerifi Öldür
AddButton("🔫 Şerifi Öldür", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Backpack:FindFirstChild("Gun") and p.Character then
            p.Character:BreakJoints()
        end
    end
end)

-- Coin ESP
local coinESPEnabled = false
local function ToggleCoinESP()
    if coinESPEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Coin" then
                local gui = obj:FindFirstChild("CoinESP")
                if gui then gui:Destroy() end
            end
        end
        coinESPEnabled = false
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Coin" then
                if not obj:FindFirstChild("CoinESP") then
                    local gui = Instance.new("BillboardGui", obj)
                    gui.Name = "CoinESP"
                    gui.Size = UDim2.new(0, 50, 0, 20)
                    gui.Adornee = obj
                    gui.AlwaysOnTop = true

                    local label = Instance.new("TextLabel", gui)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = "💰"
                    label.TextScaled = true
                    label.TextColor3 = Color3.fromRGB(255, 223, 0)
                    label.Font = Enum.Font.SourceSansBold
                end
            end
        end
        coinESPEnabled = true
    end
end

AddButton("💰 Coin ESP", function()
    ToggleCoinESP()
end)

-- God Mode
AddButton("🛡️ God Mode", function()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Name = "GOD"
    end
end)

-- NoClip
AddButton("🚪 NoClip", function()
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- Otomatik Kazan
AddButton("🏆 Otomatik Kazan", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            p.Character:BreakJoints()
        end
    end
end)

-- Menüyü Kapat
AddButton("❌ Menüyü Kapat", function()
    MainFrame.Visible = false
    if activeButton then
        activeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        activeButton = nil
    end
end)
