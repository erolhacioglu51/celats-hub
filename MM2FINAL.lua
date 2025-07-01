local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI Setup
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "CelatsHubGui"

-- CH Logo
local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0, 50, 0, 50)
logo.Position = UDim2.new(0, 10, 0, 50)
logo.Text = "CH"
logo.BackgroundColor3 = Color3.new(0, 0, 0)
logo.TextColor3 = Color3.new(1, 1, 1)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 28
logo.Draggable = true
logo.Active = true

-- Menu Frame
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 180, 0, 740)
menu.Position = UDim2.new(0, 70, 0, 50)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menu.BorderSizePixel = 0
menu.Visible = false

logo.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Button helper
local y = 10
local function createBtn(name, text, callback)
    local btn = Instance.new("TextButton", menu)
    btn.Name = name
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
    y = y + 40
end

-- Role fetch helper
local function getRole(plr)
    if plr and plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Role") then
        return plr.leaderstats.Role.Value
    end
end

local function getPlayerByRole(role)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and getRole(p) == role then
            return p
        end
    end
end

-- Kill event
local function killTarget(target)
    local ev = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kill")
    if ev and target then
        ev:FireServer(target)
    end
end

-- Teleport function
local function teleportToPlayer(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
    end
end

-- ESP Variables
local espEnabled = false
local function applyPlayerESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if plr.Character:FindFirstChild("Highlight") then
                plr.Character.Highlight:Destroy()
            end
            if espEnabled then
                local highlight = Instance.new("Highlight", plr.Character)
                highlight.Name = "Highlight"
                local role = getRole(plr)
                if role == "Killer" then
                    highlight.FillColor = Color3.new(1, 0, 0)
                elseif role == "Sheriff" then
                    highlight.FillColor = Color3.new(0, 0, 1)
                else
                    highlight.FillColor = Color3.new(0, 1, 0)
                end
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 0.3
                highlight.OutlineTransparency = 0
            end
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if not espEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Highlight") then
                plr.Character.Highlight:Destroy()
            end
        end
    else
        applyPlayerESP()
    end
end

task.spawn(function()
    while true do
        if espEnabled then
            applyPlayerESP()
        end
        task.wait(3)
    end
end)

-- Otomatik Silah Alma ve Hızlı Tetikleme (Katillik için)
local autoWeaponPickup = false
local autoTriggerEnabled = false

createBtn("AutoWeapon", "🔫 Otomatik Silah Alma", function()
    autoWeaponPickup = not autoWeaponPickup
end)

createBtn("AutoTrigger", "⚡ Hızlı Tetikleme", function()
    autoTriggerEnabled = not autoTriggerEnabled
end)

task.spawn(function()
    while true do
        task.wait(0.3)
        if autoWeaponPickup then
            local gun = workspace:FindFirstChild("GunDrop")
            if gun and LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(gun.Position + Vector3.new(0, 3, 0))
            end
        end

        if autoTriggerEnabled then
            local myRole = getRole(LocalPlayer)
            if myRole == "Killer" then
                local killEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kill")
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and getRole(plr) ~= "Killer" then
                        if killEvent and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            killEvent:FireServer(plr)
                        end
                    end
                end
            end
        end
    end
end)

-- Sesli Bildirimler (Katil ve Serif Görünce)
local soundKatil = Instance.new("Sound", SoundService)
soundKatil.SoundId = "rbxassetid://138186576" -- Örnek kahkaha sesi
soundKatil.Volume = 1

local soundSerif = Instance.new("Sound", SoundService)
soundSerif.SoundId = "rbxassetid://138186576" -- Aynı ses farklı ayar olabilir
soundSerif.Volume = 0.7

local function notifyRoleAppeared(role)
    chatMessage = function(msg)
        local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if chatEvent then
            chatEvent:FireServer(msg, "All")
        end
    end

    if role == "Killer" then
        soundKatil:Play()
        chatMessage("🔴 Katil göründü!")
    elseif role == "Sheriff" then
        soundSerif:Play()
        chatMessage("🔵 Şerif göründü!")
    end
end

-- Oyuncu görünme takibi
local notifiedKiller = false
local notifiedSheriff = false

task.spawn(function()
    while true do
        task.wait(2)
        for _, plr in pairs(Players:GetPlayers()) do
            local r = getRole(plr)
            if r == "Killer" and not notifiedKiller then
                notifyRoleAppeared("Killer")
                notifiedKiller = true
            elseif r == "Sheriff" and not notifiedSheriff then
                notifyRoleAppeared("Sheriff")
                notifiedSheriff = true
            end
        end
    end
end)

-- Kill Menüsü Kısayolları
createBtn("KillKatil", "🔪 Katili Öldür", function()
    killTarget(getPlayerByRole("Killer"))
end)

createBtn("KillSerif", "🔪 Şerifi Öldür", function()
    killTarget(getPlayerByRole("Sheriff"))
end)

createBtn("KillMasumlar", "🔪 Masumları Öldür", function()
    local myRole = getRole(LocalPlayer)
    if myRole == "Killer" then
        local killEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kill")
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and getRole(plr) == "Innocent" and killEvent then
                killEvent:FireServer(plr)
            end
        end
    end
end)

createBtn("KillHepsi", "🔪 Herkesi Öldür (Kendin Hariç)", function()
    local killEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Kill")
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and killEvent then
            killEvent:FireServer(plr)
        end
    end
end)

-- Menüye diğer gerekli butonlar eklenebilir

print("Celat's Hub PRO MM2 Script Bölüm 1/2 yüklendi!"
    -- Kamera Kilidi (Auto Lock Target)
local camera = workspace.CurrentCamera
local autoLockTarget = nil
local autoLockEnabled = false

local function findAutoLockTarget()
    local myRole = getRole(LocalPlayer)
    if not myRole then return nil end
    if myRole == "Sheriff" then
        autoLockTarget = getPlayerByRole("Killer")
    elseif myRole == "Killer" then
        autoLockTarget = getPlayerByRole("Sheriff")
    else
        autoLockTarget = nil
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if autoLockEnabled and autoLockTarget and autoLockTarget.Character and autoLockTarget.Character:FindFirstChild("HumanoidRootPart") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, autoLockTarget.Character.HumanoidRootPart.Position)
        end
    end
end)

createBtn("ToggleCamLock", "🎯 Kamera Kilidi Aç/Kapat", function()
    autoLockEnabled = not autoLockEnabled
    if autoLockEnabled then
        findAutoLockTarget()
    else
        autoLockTarget = nil
    end
end)

-- NoClip Özelliği
local noClip = false
RunService.Stepped:Connect(function()
    if noClip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

createBtn("ToggleNoClip", "🚪 NoClip Aç/Kapat", function()
    noClip = not noClip
end)

-- Speed & Jump Ayarları
local function setSpeed(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end

local function setJump(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end

createBtn("Speed30", "⚡ Speed 30", function() setSpeed(30) end)
createBtn("Speed50", "⚡ Speed 50", function() setSpeed(50) end)
createBtn("Jump50", "🦘 Jump 50", function() setJump(50) end)
createBtn("Jump100", "🦘 Jump 100", function() setJump(100) end)

-- Mini Harita (Basit örnek, geliştirilebilir)
local mapFrame = Instance.new("Frame", gui)
mapFrame.Size = UDim2.new(0, 150, 0, 150)
mapFrame.Position = UDim2.new(1, -160, 1, -160)
mapFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mapFrame.BorderSizePixel = 0
mapFrame.Visible = true

local mapLabel = Instance.new("TextLabel", mapFrame)
mapLabel.Size = UDim2.new(1, 0, 0, 20)
mapLabel.BackgroundColor3 = Color3.fromRGB(40,40,40)
mapLabel.Text = "Mini Harita"
mapLabel.TextColor3 = Color3.new(1,1,1)
mapLabel.Font = Enum.Font.GothamBold
mapLabel.TextSize = 14
mapLabel.BorderSizePixel = 0

-- Dinamik FPS Ayarı
local fpsUnlocked = false
local function toggleFPSUnlock()
    fpsUnlocked = not fpsUnlocked
    if fpsUnlocked then
        pcall(function()
            setfpscap(999)
        end)
    else
        pcall(function()
            setfpscap(60)
        end)
    end
end

createBtn("FPSUnlock", "🎮 FPS Unlock", toggleFPSUnlock)

-- Otomatik Lobby Kick (Maç sonunda hızlı lobi dönüşü)
local function autoLobbyKick()
    if workspace:FindFirstChild("Lobby") and LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(workspace.Lobby.Position + Vector3.new(0,5,0))
    end
end

createBtn("LobbyKick", "🚀 Lobiye Işınlan", autoLobbyKick)

-- Troll Modu (Kahkaha efekti)
local trollEnabled = false
createBtn("TrollMode", "🤡 Troll Modu Aç/Kapat", function()
    trollEnabled = not trollEnabled
    if trollEnabled then
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://138186576"
        sound.Looped = true
        sound.Volume = 1
        sound:Play()
        sound.Name = "TrollLaugh"
    else
        local sound = workspace:FindFirstChild("TrollLaugh")
        if sound then
            sound:Stop()
            sound:Destroy()
        end
    end
end)

print("Celat's Hub PRO MM2 Script Bölüm 2/2 yüklendi!")
   local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI Setup (varsa önceki varsa temizle)
if PlayerGui:FindFirstChild("CelatsHubGui") then
    PlayerGui.CelatsHubGui:Destroy()
end

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "CelatsHubGui"

-- Dil seçenekleri
local languages = { ["TR"] = "Türkçe", ["EN"] = "English" }
local currentLang = "TR"

-- Dil seçeneğine göre yazılar
local texts = {
    ["TR"] = {
        close = "Kapat",
        lobbyAutoTP = "Otomatik Lobi Işınlanma",
        chatNotify = "Rollere Göre Chat Bildirimi",
        perfOpt = "Performans İyileştirme",
        miniMap = "Mini Harita Detayları",
        enable = "Aç",
        disable = "Kapat",
        language = "Dil Seçimi",
    },
    ["EN"] = {
        close = "Close",
        lobbyAutoTP = "Auto Lobby Teleport",
        chatNotify = "Role-based Chat Notify",
        perfOpt = "Performance Optimization",
        miniMap = "Mini Map Details",
        enable = "Enable",
        disable = "Disable",
        language = "Language",
    }
}

-- Menü Frame
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 220, 0, 350)
menu.Position = UDim2.new(0, 10, 0, 100)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.BorderSizePixel = 0

-- Başlık
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Text = "Celat's Hub PRO"
title.BorderSizePixel = 0

-- Kapat Butonu (Sağ üst köşe kırmızı çarpı)
local closeBtn = Instance.new("TextButton", menu)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 20, 20)
closeBtn.Text = "✖"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.BorderSizePixel = 0
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("Celat's Hub Script kapatıldı.")
end)

-- Buton Yaratma Fonksiyonu
local y = 50
local function createBtn(text, callback)
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
    y = y + 45
    return btn
end

-- Otomatik Lobby Işınlanma
local lobbyAutoTPEnabled = false
local function autoLobbyTeleport()
    if lobbyAutoTPEnabled and workspace:FindFirstChild("Lobby") and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Lobby.CFrame + Vector3.new(0, 5, 0)
    end
end

RunService.Heartbeat:Connect(function()
    autoLobbyTeleport()
end)

local lobbyBtn = createBtn(texts[currentLang].lobbyAutoTP.." ("..texts[currentLang].disable..")", function()
    lobbyAutoTPEnabled = not lobbyAutoTPEnabled
    lobbyBtn.Text = texts[currentLang].lobbyAutoTP.." ("..(lobbyAutoTPEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
end)

-- Rollere Göre Chat Bildirimleri
local chatNotifyEnabled = false
local function sendChatMessage(msg)
    local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
    if chatEvent then
        chatEvent:FireServer(msg, "All")
    end
end

local notifiedRoles = { killer = false, sheriff = false }
RunService.Heartbeat:Connect(function()
    if not chatNotifyEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        local role = nil
        if plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Role") then
            role = plr.leaderstats.Role.Value
        end
        if role == "Killer" and not notifiedRoles.killer then
            sendChatMessage("🔴 Katil göründü!")
            notifiedRoles.killer = true
        elseif role == "Sheriff" and not notifiedRoles.sheriff then
            sendChatMessage("🔵 Şerif göründü!")
            notifiedRoles.sheriff = true
        end
    end
end)

local chatNotifyBtn = createBtn(texts[currentLang].chatNotify.." ("..texts[currentLang].disable..")", function()
    chatNotifyEnabled = not chatNotifyEnabled
    if not chatNotifyEnabled then
        notifiedRoles.killer = false
        notifiedRoles.sheriff = false
    end
    chatNotifyBtn.Text = texts[currentLang].chatNotify.." ("..(chatNotifyEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
end)

-- Performans İyileştirme (Basit örnek: FPS Lock aç/kapa)
local perfOptEnabled = false
local function togglePerfOpt()
    perfOptEnabled = not perfOptEnabled
    if perfOptEnabled then
        pcall(function() setfpscap(999) end)
    else
        pcall(function() setfpscap(60) end)
    end
end

local perfBtn = createBtn(texts[currentLang].perfOpt.." ("..texts[currentLang].disable..")", function()
    togglePerfOpt()
    perfBtn.Text = texts[currentLang].perfOpt.." ("..(perfOptEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
end)

-- Mini Harita Detayları (Placeholder, kolayca geliştirilebilir)
local miniMapBtn = createBtn(texts[currentLang].miniMap.." (Yapım Aşamasında)", function()
    print("Mini harita detayları özelliği şimdilik yapım aşamasında!")
end)

-- Dil Seçimi Butonu
local langBtn = createBtn(texts[currentLang].language..": "..languages[currentLang], function()
    currentLang = currentLang == "TR" and "EN" or "TR"
    -- Menü buton yazılarını güncelle
    lobbyBtn.Text = texts[currentLang].lobbyAutoTP.." ("..(lobbyAutoTPEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
    chatNotifyBtn.Text = texts[currentLang].chatNotify.." ("..(chatNotifyEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
    perfBtn.Text = texts[currentLang].perfOpt.." ("..(perfOptEnabled and texts[currentLang].enable or texts[currentLang].disable)..")"
    miniMapBtn.Text = texts[currentLang].miniMap.." (Yapım Aşamasında)"
    langBtn.Text = texts[currentLang].language..": "..languages[currentLang]
end)

print("Celat's Hub PRO MM2 Script Bölüm 3/3 yüklendi!") 
