-- Celat's Hub TEST Sürümü - Sadece CH Butonu ve Dil Seçimi (DÜZENLİ)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI Oluştur
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CelatsHubTest"

-- Ana Menü Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 250)
main.Position = UDim2.new(0.5, -200, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
main.Visible = false
main.Name = "MainUI"
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Celat's Hub Başlık
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Celat's Hub"
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextColor3 = Color3.new(0, 0, 0)

-- Dil Seçim Frame
local langFrame = Instance.new("Frame", main)
langFrame.Size = UDim2.new(1, 0, 0, 150)
langFrame.Position = UDim2.new(0, 0, 0, 50)
langFrame.BackgroundTransparency = 1

local turkce = Instance.new("TextButton", langFrame)
turkce.Size = UDim2.new(0.4, 0, 0.4, 0)
turkce.Position = UDim2.new(0.05, 0, 0.3, 0)
turkce.Text = "Türkçe"
turkce.Font = Enum.Font.GothamBold
turkce.TextSize = 22
turkce.BackgroundColor3 = Color3.fromRGB(10,10,10)
turkce.TextColor3 = Color3.fromRGB(255,255,255)
turkce.BorderSizePixel = 0

local ingilizce = Instance.new("TextButton", langFrame)
ingilizce.Size = UDim2.new(0.4, 0, 0.4, 0)
ingilizce.Position = UDim2.new(0.55, 0, 0.3, 0)
ingilizce.Text = "English"
ingilizce.Font = Enum.Font.GothamBold
ingilizce.TextSize = 22
ingilizce.BackgroundColor3 = Color3.fromRGB(10,10,10)
ingilizce.TextColor3 = Color3.fromRGB(255,255,255)
ingilizce.BorderSizePixel = 0

-- CH (Aç/Kapat) Butonu
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 50, 0, 50)
toggle.Position = UDim2.new(0, 20, 0.5, -25)
toggle.Text = "CH"
toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 20
toggle.Name = "ToggleCH"
toggle.BorderSizePixel = 0
toggle.Active = true
toggle.Draggable = true

-- Buton Fonksiyonu: Aç / Kapat
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- Dil Seçimi
turkce.MouseButton1Click:Connect(function()
	print("Dil seçimi: Türkçe")
	turkce.Text = "Seçildi ✓"
	ingilizce.Text = "English"
end)

ingilizce.MouseButton1Click:Connect(function()
	print("Language selected: English")
	ingilizce.Text = "Selected ✓"
	turkce.Text = "Türkçe"
end)

print("✅ Celat's Hub TEST Sürümü Yüklendi.")
