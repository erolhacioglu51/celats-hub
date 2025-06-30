-- Celat's Hub - PRO MM2 Script (Delta Executor Uyumlu)
-- Hazırlayan: Team Celat’s Hub™

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- GUI Kurulumu
local CelatsGUI = Instance.new("ScreenGui", CoreGui)
CelatsGUI.Name = "CelatsHubPro"
CelatsGUI.ResetOnSpawn = false

-- Giriş Ekranı
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

-- Giriş ekranı animasyonu
spawn(function()
    wait(3)
    IntroFrame:Destroy()
end)

-- Ses efekti
local clickSound = Instance.new("Sound", CelatsGUI)
clickSound.SoundId = "rbxassetid://12222005"  -- Tıklama sesi
clickSound.Volume = 1

-- Yüzen CH Logosu
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

-- Ana Menü Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 580)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = CelatsGUI

-- Aç/Kapat
CHLogo.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- UIList
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.FillDirection = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ListLayout.Parent = MainFrame

-- Buton Oluşturma Fonksiyonu
local function AddButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 380, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(function()
        clickSound:Play()
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.2)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        callback()
    end)
end

-- TextBox'lu Speed & Jump Ayarı
local speedBox = Instance.new("TextBox")
speedBox.PlaceholderText = "Speed (Varsayılan: 16)"
speedBox.Size = UDim2.new(0, 180, 0, 35)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 16
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Parent = MainFrame

local jumpBox = Instance.new("TextBox")
jumpBox.PlaceholderText = "Jump (Varsayılan: 50)"
jumpBox.Size = UDim2.new(0, 180, 0, 35)
jumpBox.Font = Enum.Font.SourceSans
jumpBox.TextSize = 16
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

-- Rol Renkli ESP
AddButton("👁️ Rol ESP", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            -- Önce varsa önceki tagı sil
            local oldTag = p.Character.Head:FindFirstChild("RoleTag")
            if oldTag then oldTag:Destroy() end

            local color = Color3.fromRGB(0, 255, 0) -- Masum: Yeşil
            if p.Backpack:FindFirstChild("Knife") then
                color = Color3.fromRGB(255, 0, 0) -- Katil: Kırmızı
            elseif p.Backpack:FindFirstChild("Gun") then
                color = Color3.fromRGB(0, 170, 255) -- Şerif: Mavi
            end

            local tag = Instance.new("BillboardGui", p.Character.Head)
            tag.Name = "RoleTag"
            tag.Size = UDim2.new(0, 100, 0, 20)
            tag.Adornee = p.Character.Head
            tag.AlwaysOnTop = true

            local txt = Instance.new("TextLabel", tag)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = p.Name
            txt.TextColor3 = color
            txt.TextScaled = true
            txt.Font = Enum.Font.SourceSansBold
        end
    end
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
AddButton("💰 Coin ESP", function()
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
end)

-- Lobiye Işınlan
AddButton("🏠 Lobiye Işınlan", function()
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        LocalPlayer.Character:MoveTo(Vector3.new(0, 100, 0))
    end
end)

-- Mape Işınlan
AddButton("🗺️ Mape Işınlan", function()
    local map = workspace:FindFirstChild("Map") or workspace:FindFirstChildWhichIsA("Model")
    if map and map:IsA("Model") then
        local cf = map:GetBoundingBox()
        if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
            LocalPlayer.Character:MoveTo(cf.Position)
        end
    end
end)

-- God Mode
AddButton("🛡️ God Mode", function()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Name = "GOD" -- Basit koruma (bazı oyunlarda işe yarar)
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
end)
