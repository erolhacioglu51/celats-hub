-- Celat's Hub MM2 Script - Bölüm 1/4
-- GUI, Dil Seçimi ve CH Logosu 🌀💙

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Önce varsa eski GUI'yi temizle 🧹
if CoreGui:FindFirstChild("CelatsHubGUI") then
    CoreGui.CelatsHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CelatsHubGUI"
ScreenGui.Parent = CoreGui

-- Yüzen CH Logosu (sürüklenebilir) 🌀
local CHLogo = Instance.new("TextButton")
CHLogo.Name = "CHLogo"
CHLogo.Text = "CH"
CHLogo.Font = Enum.Font.GothamBlack
CHLogo.TextSize = 28
CHLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
CHLogo.BackgroundColor3 = Color3.fromRGB(10, 10, 50) -- Mavi tonlarında
CHLogo.BorderSizePixel = 0
CHLogo.Size = UDim2.new(0, 60, 0, 60)
CHLogo.Position = UDim2.new(0, 15, 0.5, -30)
CHLogo.Parent = ScreenGui
CHLogo.Active = true
CHLogo.Draggable = true

-- Menü Frame (başlangıçta görünmez) 📋
local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuFrame"
MenuFrame.Size = UDim2.new(0, 320, 0, 480)
MenuFrame.Position = UDim2.new(0, 85, 0.5, -240)
MenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 60)
MenuFrame.BorderSizePixel = 0
MenuFrame.Visible = false
MenuFrame.Parent = ScreenGui
MenuFrame.Active = true
MenuFrame.Draggable = true

-- Menü başlık etiketi 🏷️
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MenuFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.BackgroundColor3 = Color3.fromRGB(5, 5, 35)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "Team Celat's Hub"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 26
TitleLabel.TextColor3 = Color3.fromRGB(100, 170, 255)
TitleLabel.TextStrokeTransparency = 0.6

-- Menü kapatma butonu (sağ üstte ✖️) ❌
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MenuFrame
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
CloseBtn.Text = "✖"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = true

CloseBtn.MouseButton1Click:Connect(function()
    MenuFrame.Visible = false
end)

-- Dil seçimi yazısı 🌐
local LangLabel = Instance.new("TextLabel")
LangLabel.Parent = MenuFrame
LangLabel.Size = UDim2.new(1, -20, 0, 32)
LangLabel.Position = UDim2.new(0, 10, 0, 60)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = "Select Language / Dil Seçiniz"
LangLabel.Font = Enum.Font.Gotham
LangLabel.TextSize = 20
LangLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
LangLabel.TextStrokeTransparency = 0.8

-- Dil butonları 🟦🟩
local languages = {"Türkçe 🇹🇷", "English 🇬🇧"}
local selectedLang = nil

local function clearLangButtons()
    for _, child in pairs(MenuFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Name:find("LangBtn") then
            child:Destroy()
        end
    end
end

local function createLangButton(lang, posX)
    local btn = Instance.new("TextButton")
    btn.Name = "LangBtn_" .. lang
    btn.Parent = MenuFrame
    btn.Size = UDim2.new(0, 140, 0, 45)
    btn.Position = UDim2.new(0, 10 + (posX * 150), 0, 100)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
    btn.BorderSizePixel = 0
    btn.Text = lang
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.AutoButtonColor = true

    btn.MouseButton1Click:Connect(function()
        selectedLang = lang
        clearLangButtons()
        MenuFrame.Visible = true
        print("Dil seçildi: " .. selectedLang)
        -- 2. bölüm kodunu buraya entegre edeceğiz
    end)
end

for i, lang in ipairs(languages) do
    createLangButton(lang, i - 1)
end

-- CH logosuna basınca menü aç/kapa 🔵
CHLogo.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

print("Celat's Hub Bölüm 1 yüklendi! 🚀")
-- Celat's Hub MM2 Script - Bölüm 2/4
-- ESP & Highlight Sistemi 🕵️‍♂️✨

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Eski highlight klasörünü temizle 🧹
local HighlightFolder = CoreGui:FindFirstChild("CH_Highlights")
if HighlightFolder then
    HighlightFolder:Destroy()
end

HighlightFolder = Instance.new("Folder")
HighlightFolder.Name = "CH_Highlights"
HighlightFolder.Parent = CoreGui

-- Renkler ve roller 🎨
local colors = {
    ["Murderer"] = Color3.fromRGB(255, 50, 50),  -- 🔴 Katil
    ["Sheriff"] = Color3.fromRGB(50, 100, 255),  -- 🔵 Şerif
    ["Innocent"] = Color3.fromRGB(50, 255, 50),  -- 🟢 Masum
}

-- Oyuncunun rolünü al (oyuna göre uyarlanabilir)
local function getRole(player)
    local role = player:GetAttribute("Role")
    if role then
        return role
    end
    return "Innocent" -- default 🟢
end

-- Highlight ekleme fonksiyonu 🎯
local function addHighlight(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    if HighlightFolder:FindFirstChild(player.Name) then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name
    highlight.Adornee = player.Character
    local role = getRole(player)
    highlight.FillColor = colors[role] or Color3.new(1, 1, 1)
    highlight.OutlineColor = colors[role] or Color3.new(1, 1, 1)
    highlight.Parent = HighlightFolder
end

-- Her Heartbeat'de güncelle 🕰️
RunService.Heartbeat:Connect(function()
    -- Eski highlightları temizle
    for _, h in pairs(HighlightFolder:GetChildren()) do
        if not Players:FindFirstChild(h.Name) or not Players[h.Name].Character then
            h:Destroy()
        end
    end
    -- Yeni highlight ekle
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            addHighlight(player)
        end
    end
end)

print("Celat's Hub Bölüm 2 yüklendi! 🎉")
-- Celat's Hub MM2 Script - Bölüm 3/4
-- Teleport Sistemleri + Menü Butonları ve Emojiler 🚀🔘

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local MenuFrame = script.Parent or game:GetService("CoreGui").CelatsHubGUI.MenuFrame

-- Teleport butonlarını ekleyeceğimiz container (ScrollFrame ile kaydırma da yapabiliriz)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MenuFrame
ScrollFrame.Size = UDim2.new(1, -20, 1, -150)
ScrollFrame.Position = UDim2.new(0, 10, 0, 130)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
ScrollFrame.ScrollBarThickness = 8

-- Buton oluşturma fonksiyonu (emoji ile) 😎
local function createButton(name, emoji, posY, onClick)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 90)
    btn.BorderSizePixel = 0
    btn.Text = emoji .. "  " .. name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.AutoButtonColor = true
    btn.Parent = ScrollFrame

    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- Teleport fonksiyonları örnek (lokasyon isimleri haritaya göre değişmeli) 📍
local teleportLocations = {
    ["Lobby"] = CFrame.new(0, 10, 0), -- Örnek konum, değiştirmelisin
    ["Map Center"] = CFrame.new(50, 10, 50), -- Örnek
    -- İstersen daha fazla ekle
}

-- Teleport fonksiyonu 🎯
local function teleportTo(locationName)
    local cf = teleportLocations[locationName]
    if cf and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = cf
        print("Teleport edildi: " .. locationName)
    else
        warn("Teleport başarısız: " .. tostring(locationName))
    end
end

-- Butonları oluştur (emoji ve isimle) 🛠️
local buttonList = {
    {name = "Teleport Lobby", emoji = "🏠", action = function() teleportTo("Lobby") end},
    {name = "Teleport Map Center", emoji = "🗺️", action = function() teleportTo("Map Center") end},
    -- Buraya istediğin kadar ekle
}

-- Butonları ScrollFrame içine diz
for i, btnInfo in ipairs(buttonList) do
    createButton(btnInfo.name, btnInfo.emoji, (i-1)*50, btnInfo.action)
end

print("Celat's Hub Bölüm 3 yüklendi! 🚀🎮")
-- Celat's Hub MM2 Script - Bölüm 4/4
-- Kill Menü, Aimbot & Chat Bildirimleri + Menü Kapatma Butonu ⚔️🎯💬

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")
local RunService = game:GetService("RunService")

local MenuFrame = script.Parent or game:GetService("CoreGui").CelatsHubGUI.MenuFrame
local ScrollFrame = MenuFrame:FindFirstChildOfClass("ScrollingFrame")

-- Kill Menüsü Butonları Listesi ve Emoji 🚩
local killButtons = {
    {name = "Katil'i Vur 🎯", emoji = "🔫"},
    {name = "Şerifi Vur 🔵", emoji = "🔵"},
    {name = "Masumları Vur 🟢", emoji = "🟢"},
}

-- Aimbot aktifliği kontrolü 🎯
local aimbotEnabled = false

-- Hedef oyuncu için aimbot fonksiyonu
local function aimbot()
    if not aimbotEnabled then return end
    local target
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local role = player:GetAttribute("Role") or "Innocent"
            if role == "Murderer" then
                target = player
                break
            end
        end
    end
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(hrp.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end

-- Aimbot toggle butonu ekle 🎯
local function createAimbotButton(posY)
    local btn = Instance.new("TextButton")
    btn.Name = "AimbotBtn"
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 90, 40)
    btn.BorderSizePixel = 0
    btn.Text = "🎯 Aimbot Kapalı"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.AutoButtonColor = true
    btn.Parent = ScrollFrame

    btn.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        btn.Text = aimbotEnabled and "🎯 Aimbot Açık" or "🎯 Aimbot Kapalı"
        print("Aimbot durumu:", aimbotEnabled and "Açık" or "Kapalı")
    end)
end

-- Kill menü butonları oluştur ve işlevleri ata 🗡️
local function createKillButtons(startY)
    for i, info in ipairs(killButtons) do
        local btn = Instance.new("TextButton")
        btn.Name = info.name:gsub(" ", "") .. "Btn"
        btn.Size = UDim2.new(1, 0, 0, 45)
        btn.Position = UDim2.new(0, 0, 0, startY + (i-1)*50)
        btn.BackgroundColor3 = Color3.fromRGB(70, 40, 40)
        btn.BorderSizePixel = 0
        btn.Text = info.emoji .. "  " .. info.name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 20
        btn.TextColor3 = Color3.fromRGB(230, 230, 255)
        btn.AutoButtonColor = true
        btn.Parent = ScrollFrame

        btn.MouseButton1Click:Connect(function()
            print(info.name .. " butonuna basıldı!")
            -- Örnek: Katili vur fonksiyonu (bunu oyun RPC'sine göre doldur)
            -- Burada sadece örnek console mesajı bırakıyorum
            -- Gerçek oyunda RemoteEvent veya oyun fonksiyonları çağrılır
        end)
    end
end

-- Chat bildirim fonksiyonu (örnek) 🗣️
local function sendChatNotification(message)
    local Chat = game:GetService("Chat")
    Chat:Chat(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(), message, Enum.ChatColor.Red)
end

-- Menüye kapatma butonu (başka yeri kapatabilir) ❌
local CloseBtn = MenuFrame:FindFirstChild("CloseBtn")
if CloseBtn then
    CloseBtn.MouseButton1Click:Connect(function()
        MenuFrame.Visible = false
        print("Menü kapatıldı ❌")
    end)
end

-- Aimbot butonunu ve Kill menü butonlarını oluştur
createAimbotButton(ScrollFrame.CanvasSize.Y.Offset + 10)
createKillButtons(ScrollFrame.CanvasSize.Y.Offset + 70)

-- RunService ile aimbot sürekli çalıştır
RunService.Heartbeat:Connect(function()
    if aimbotEnabled then
        aimbot()
    end
end)

print("Celat's Hub Bölüm 4 yüklendi! 🏆🔥")
local RunService = game:GetService("RunService")
local noclipEnabled = false
local LocalPlayer = game:GetService("Players").LocalPlayer

local function noclipToggle()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        print("Noclip Açıldı 🚀")
    else
        print("Noclip Kapandı 🛑")
    end
end

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    elseif LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") and not part.CanCollide then
                part.CanCollide = true
            end
        end
    end
end)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function enableGodMode()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
            humanoid.MaxHealth = math.huge -- Sonsuz sağlık
            humanoid.HealthChanged:Connect(function()
                humanoid.Health = humanoid.MaxHealth
            end)
            print("God Mode Açıldı 🛡️")
        end
    end
end

local function disableGodMode()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = 100
            print("God Mode Kapandı 🛡️")
        end
    end
end
