local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local CelatsGUI = Instance.new("ScreenGui")
CelatsGUI.Name = "CelatsHubPro"
CelatsGUI.ResetOnSpawn = false
CelatsGUI.Parent = CoreGui

-- En üstte Team Celat's Hub yazısı
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

-- Dil seçim ekranı
local langFrame = Instance.new("Frame")
langFrame.Size = UDim2.new(0, 300, 0, 150)
langFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
langFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
langFrame.BorderSizePixel = 0
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
    btn.Size = UDim2.new(0, 120, 0, 50)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Parent = langFrame

    btn.MouseButton1Click:Connect(function()
        callback()
    end)
end

local selectedLanguage = nil

-- Main GUI (butonların olduğu kısım)
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

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.FillDirection = Enum.FillDirection.Vertical
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ListLayout.Parent = MainFrame

local clickSound = Instance.new("Sound", CelatsGUI)
clickSound.SoundId = "rbxassetid://12222005"
clickSound.Volume = 1

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
        end
    end)
end

-- Speed & Jump TextBoxlar
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 210, 0, 40)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 18
speedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Parent = MainFrame

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0, 210, 0, 40)
jumpBox.Font = Enum.Font.SourceSans
jumpBox.TextSize = 18
jumpBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpBox.Parent = MainFrame

-- Dil bazlı metinler için tablolar
local texts = {
    TR = {
        speedPlaceholder = "Hız (Varsayılan: 16)",
        jumpPlaceholder = "Zıplama (Varsayılan: 50)",
        applySpeedJump = "⚙️ Speed & Jump Uygula",
        roleHighlight = "✨ Rol Highlight",
        roleDetect = "🎯 Rol Tespiti",
        killKiller = "🔪 Katili Öldür",
        killSheriff = "🔫 Şerifi Öldür",
        coinESP = "💰 Coin ESP",
        godMode = "🛡️ God Mode",
        noclip = "🚪 NoClip",
        autoWin = "🏆 Otomatik Kazan",
        closeMenu = "❌ Menüyü Kapat"
    },
    EN = {
        speedPlaceholder = "Speed (Default: 16)",
        jumpPlaceholder = "Jump (Default: 50)",
        applySpeedJump = "⚙️ Apply Speed & Jump",
        roleHighlight = "✨ Role Highlight",
        roleDetect = "🎯 Role Detection",
        killKiller = "🔪 Kill Killer",
        killSheriff = "🔫 Kill Sheriff",
        coinESP = "💰 Coin ESP",
        godMode = "🛡️ God Mode",
        noclip = "🚪 NoClip",
        autoWin = "🏆 Auto Win",
        closeMenu = "❌ Close Menu"
    }
}

-- Dil seçimine göre arayüzü güncelle
local function UpdateTexts(lang)
    local t = texts[lang]
    speedBox.PlaceholderText = t.speedPlaceholder
    jumpBox.PlaceholderText = t.jumpPlaceholder

    -- Önce tüm butonları temizle
    for _, child in pairs(MainFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    -- Butonları ekle
    AddButton(t.applySpeedJump, function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then
            h.WalkSpeed = tonumber(speedBox.Text) or 16
            h.JumpPower = tonumber(jumpBox.Text) or 50
        end
    end)

    local highlightEnabled = false
    local function ToggleHighlight()
        if highlightEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local oldHighlight = p.Character.HumanoidRootPart:FindFirstChild("RoleHighlight")
                    if oldHighlight then oldHighlight:Destroy() end
                end
            end
            highlightEnabled = false
        else
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

    AddButton(t.roleHighlight, ToggleHighlight)

    AddButton(t.roleDetect, function()
        for _, p in pairs(Players:GetPlayers()) do
            if p.Backpack:FindFirstChild("Knife") then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔪 Killer: "..p.Name,"All")
            elseif p.Backpack:FindFirstChild("Gun") then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔫 Sheriff: "..p.Name,"All")
            end
        end
    end)

    AddButton(t.killKiller, function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Backpack:FindFirstChild("Knife") and p.Character then
                p.Character:BreakJoints()
            end
        end
    end)

    AddButton(t.killSheriff, function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Backpack:FindFirstChild("Gun") and p.Character then
                p.Character:BreakJoints()
            end
        end
    end)

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

    AddButton(t.coinESP, ToggleCoinESP)

    AddButton(t.godMode, function()
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Name = "GOD"
        end
    end)

    AddButton(t.noclip, function()
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

    AddButton(t.autoWin, function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                p.Character:BreakJoints()
            end
        end
    end)

    AddButton(t.closeMenu, function()
        MainFrame.Visible = false
        if activeButton then
            activeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            activeButton = nil
        end
    end)
end

-- Dil butonları
createLangButton("Türkçe", UDim2.new(0, 20, 0, 70), function()
    selectedLanguage = "TR"
    langFrame.Visible = false
    TitleLabel.Text = "Team Celat's Hub"
    MainFrame.Visible = true
    UpdateTexts("TR")
end)

createLangButton("English", UDim2.new(0, 160, 0, 70), function()
    selectedLanguage = "EN"
    langFrame.Visible = false
    TitleLabel.Text = "Team Celat's Hub"
    MainFrame.Visible = true
    UpdateTexts("EN")
end)
