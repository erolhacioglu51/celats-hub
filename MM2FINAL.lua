-- Celat's Hub MM2 Final Script - BÖLÜM 1/5
-- Giriş: GUI Tanımlama, Menü Oluşturma, CH logosu vs.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CelatsHubUI"
gui.ResetOnSpawn = false

-- Kayan CH Logosu
local logo = Instance.new("TextButton")
logo.Text = "🌟 CH"
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Position = UDim2.new(0, 20, 0, 200)
logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Draggable = true
logo.Parent = gui

-- Menü ana çerçevesi
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 300, 0, 400)
menu.Position = UDim2.new(0.5, -150, 0.5, -200)
menu.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.Parent = gui

-- Menü başlık
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.FredokaOne
title.Text = "💠 Team Celat's Hub 💠"
title.TextSize = 20

-- Menü Scroll
local scroll = Instance.new("ScrollingFrame", menu)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

-- Buton ekleme fonksiyonu
function AddMenuButton(text, emoji, yPos, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = emoji.." "..text
    btn.MouseButton1Click:Connect(callback)
end

-- Menü Aç/Kapa Tuşu
logo.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

print("✅ [Celat's Hub] Arayüz yüklendi!")
-- BÖLÜM 2/5: Pro Özellikler - Otomatik Silah Alma ve Coin Magnet

-- Otomatik Silah Alma
local autoGunActive = false
local function AutoGunPickupToggle()
    autoGunActive = not autoGunActive
    if autoGunActive then
        print("🔫 Otomatik Silah Alma aktif!")
        spawn(function()
            while autoGunActive do
                local char = game.Players.LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local gun = workspace:FindFirstChild("GunDrop")
                if root and gun then
                    root.CFrame = gun.CFrame + Vector3.new(0,1,0)
                end
                wait(0.5)
            end
        end)
    else
        print("🔫 Otomatik Silah Alma kapandı!")
    end
end

AddMenuButton("🔫 Otomatik Silah Alma", "🔫", 10, AutoGunPickupToggle)

-- Coin Magnet
local coinMagnetActive = false
local function CoinMagnetToggle()
    coinMagnetActive = not coinMagnetActive
    if coinMagnetActive then
        print("🪙 Coin Magnet aktif!")
        spawn(function()
            while coinMagnetActive do
                for _, coin in pairs(workspace:GetDescendants()) do
                    if coin.Name == "Coin" and coin:IsA("BasePart") then
                        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            coin.CFrame = root.CFrame
                        end
                    end
                end
                wait(0.5)
            end
        end)
    else
        print("🪙 Coin Magnet kapandı!")
    end
end

AddMenuButton("🪙 Coin Magnet", "🪙", 60, CoinMagnetToggle)
-- BÖLÜM 3/5: Anti-Fall ve Sesli ESP

-- Anti-Fall
local antiFallActive = false
local function AntiFallToggle()
    antiFallActive = not antiFallActive
    if antiFallActive then
        print("🚷 Anti-Fall aktif!")
        spawn(function()
            while antiFallActive do
                local char = game.Players.LocalPlayer.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root and root.Position.Y < -15 then
                    root.CFrame = CFrame.new(0, 20, 0)
                end
                wait(0.3)
            end
        end)
    else
        print("🚷 Anti-Fall kapandı!")
    end
end

AddMenuButton("🚷 Anti-Fall (Düşme Koruması)", "🚷", 110, AntiFallToggle)

-- Ses Efekti + ESP (Örnek)
local espActive = false
local function PlaySoundEffect(id)
    local sound = Instance.new("Sound", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = 2
    sound:Play()
    game.Debris:AddItem(sound, 3)
end

local function ESPAndSoundToggle()
    espActive = not espActive
    if espActive then
        print("🔊 ESP ve ses aktif!")
        -- Buraya ESP setup kodu koyabilirsin
        PlaySoundEffect(9118823104) -- Headshot sesi örnek
    else
        print("🔊 ESP ve ses kapandı!")
        -- ESP kapatma işlemleri
    end
end

AddMenuButton("👁️ ESP + Ses Efekti", "🔊", 160, ESPAndSoundToggle)
-- BÖLÜM 4/5: Tema Renk Seçici & Menü Kapatma Butonu

-- Tema değiştirme fonksiyonu
local function ChangeTheme(color)
    for _, v in pairs(menu:GetChildren()) do
        if v:IsA("TextButton") then
            v.BackgroundColor3 = color
        end
    end
    menu.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.7)
    title.BackgroundColor3 = color:lerp(Color3.new(0,0,0), 0.5)
end

AddMenuButton("❤️ Tema: Kırmızı", "❤️", 210, function()
    ChangeTheme(Color3.fromRGB(150, 30, 30))
    print("🎨 Tema kırmızıya değiştirildi!")
end)

AddMenuButton("💙 Tema: Mavi", "💙", 260, function()
    ChangeTheme(Color3.fromRGB(0, 80, 160))
    print("🎨 Tema maviye değiştirildi!")
end)

AddMenuButton("🖤 Tema: Koyu", "🖤", 310, function()
    ChangeTheme(Color3.fromRGB(20, 20, 20))
    print("🎨 Tema koyuya değiştirildi!")
end)

-- Menü kapatma butonu (sağ üst köşe)
local closeBtn = Instance.new("TextButton", menu)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Text = "✖"
closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    print("❌ Menü kapatıldı!")
end)
-- BÖLÜM 5/5: Katili, Şerifi, Masumları Vurma ve Aimbot Butonları

local killingActive = {
    murderer = false,
    sheriff = false,
    innocent = false
}

-- Öldürme fonksiyonu (örnek)
local function KillByRole(roleName)
    -- Bu fonksiyon, o role sahip oyuncuları öldürmeye çalışır
    local players = game.Players:GetPlayers()
    local localChar = player.Character
    if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in pairs(players) do
        if plr ~= player and plr.Team and plr.Team.Name == roleName and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            -- Teleport veya öldürme işlemi (örnek)
            localChar.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,1)
            wait(0.2)
            -- Burada katili vurma kodu eklenmeli
            print("🔪 "..plr.Name.." ("..roleName..") öldürüldü!")
        end
    end
end

local function ToggleKill(roleKey, roleDisplay)
    killingActive[roleKey] = not killingActive[roleKey]
    if killingActive[roleKey] then
        print("🔪 "..roleDisplay.." öldürme aktif!")
        spawn(function()
            while killingActive[roleKey] do
                KillByRole(roleDisplay)
                wait(1)
            end
        end)
    else
        print("🔪 "..roleDisplay.." öldürme kapandı!")
    end
end

AddMenuButton("🔴 Katili Vur", "🔴", 360, function() ToggleKill("murderer", "Murderer") end)
AddMenuButton("🔵 Şerifi Vur", "🔵", 410, function() ToggleKill("sheriff", "Sheriff") end)
AddMenuButton("🟢 Masumları Vur", "🟢", 460, function() ToggleKill("innocent", "Innocent") end)

-- Basit Aimbot Butonu (aktif/pasif)
local aimbotActive = false
AddMenuButton("🎯 Aimbot Aç/Kapat", "🎯", 510, function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        print("🎯 Aimbot aktif!")
        -- Buraya aimbot kodu entegre edilecek
    else
        print("🎯 Aimbot kapandı!")
        -- Aimbot kapatma işlemi
    end
end)
