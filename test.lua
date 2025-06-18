-- Celat's Hub - Test Sürümü
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "CelatsHubTest"

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = "CH"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 22
ToggleBtn.Draggable = true
ToggleBtn.Active = true

-- Ana Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Visible = false
MainFrame.BorderSizePixel = 0

-- Başlık
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Celat's Hub"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.new(0, 0, 0)
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.new(0.2, 0.2, 0.2)
Title.TextSize = 28

-- Dil Seçim Paneli
local LanguageFrame = Instance.new("Frame", MainFrame)
LanguageFrame.Size = UDim2.new(1, 0, 0, 80)
LanguageFrame.Position = UDim2.new(0, 0, 0, 60)
LanguageFrame.BackgroundTransparency = 1

local BtnTR = Instance.new("TextButton", LanguageFrame)
BtnTR.Size = UDim2.new(0.45, 0, 0.8, 0)
BtnTR.Position = UDim2.new(0.05, 0, 0.1, 0)
BtnTR.Text = "Türkçe"
BtnTR.Font = Enum.Font.GothamBold
BtnTR.TextSize = 22
BtnTR.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
BtnTR.TextColor3 = Color3.new(1, 1, 1)

local BtnEN = Instance.new("TextButton", LanguageFrame)
BtnEN.Size = UDim2.new
