game.StarterGui:SetCore("SendNotification", {
    Title = "Celat's Hub",
    Text = "Script başarıyla yüklendi!",
    Duration = 5
})
-- Celat's Hub - PRO MM2 Script (Delta Executor Uyumlu) -- Hazırlayan: Team Celat’s Hub™

local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local CoreGui = game:GetService("CoreGui")

-- GUI Kurulumu local CelatsGUI = Instance.new("ScreenGui", CoreGui) CelatsGUI.Name = "CelatsHubPro"

-- Yüzen CH Logosu local CHLogo = Instance.new("TextButton") CHLogo.Name = "CHLogo" CHLogo.Text = "CH" CHLogo.Size = UDim2.new(0, 60, 0, 60) CHLogo.Position = UDim2.new(0, 20, 0.4, 0) CHLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 0) CHLogo.TextColor3 = Color3.fromRGB(255, 255, 255) CHLogo.Font = Enum.Font.SourceSansBold CHLogo.TextSize = 24 CHLogo.Draggable = true CHLogo.Active = true CHLogo.Parent = CelatsGUI

-- Ana Menü Frame local MainFrame = Instance.new("Frame") MainFrame.Name = "MainFrame" MainFrame.Size = UDim2.new(0, 350, 0, 500) MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250) MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) MainFrame.BorderSizePixel = 0 MainFrame.Visible = false MainFrame.Parent = CelatsGUI

-- Aç/Kapat CHLogo.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- UIGrid local Grid = Instance.new("UIGridLayout", MainFrame) Grid.CellSize = UDim2.new(1, -10, 0, 40) Grid.CellPadding = UDim2.new(0, 0, 0, 6)

-- Buton Oluşturma local function AddButton(text, callback) local btn = Instance.new("TextButton") btn.Size = UDim2.new(1, -10, 0, 40) btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) btn.TextColor3 = Color3.fromRGB(255, 255, 255) btn.Text = text btn.Font = Enum.Font.SourceSansBold btn.TextSize = 18 btn.Parent = MainFrame btn.MouseButton1Click:Connect(callback) end

-- ROL TESPİTİ + CHAT AddButton("🎯 Rol Tespiti", function() for _, p in pairs(Players:GetPlayers()) do if p.Backpack:FindFirstChild("Knife") then game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔪 Katil: "..p.Name, "All") elseif p.Backpack:FindFirstChild("Gun") then game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🔫 Şerif: "..p.Name, "All") end end end)

-- KATİLİ ÖLDÜR AddButton("🔪 Katili Öldür", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Backpack:FindFirstChild("Knife") and p.Character then p.Character:BreakJoints() end end end)

-- ŞERİFİ ÖLDÜR AddButton("🔫 Şerifi Öldür", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Backpack:FindFirstChild("Gun") and p.Character then p.Character:BreakJoints() end end end)

-- COIN ESP AddButton("💰 Coin ESP", function() for _, obj in pairs(workspace:GetDescendants()) do if obj.Name == "Coin" then local gui = Instance.new("BillboardGui", obj) gui.Size = UDim2.new(0, 50, 0, 20) gui.AlwaysOnTop = true gui.Adornee = obj local label = Instance.new("TextLabel", gui) label.Size = UDim2.new(1, 0, 1, 0) label.BackgroundTransparency = 1 label.Text = "💰" label.TextScaled = true label.TextColor3 = Color3.fromRGB(255, 223, 0) end end end)

-- LOBİYE IŞINLAN AddButton("🏠 Lobiye Işınlan", function() LocalPlayer.Character:MoveTo(Vector3.new(0, 100, 0)) end)

-- MAPE IŞINLAN AddButton("🗺️ Mape Işınlan", function() local map = workspace:FindFirstChild("Map") or workspace:FindFirstChildWhichIsA("Model") if map and map:IsA("Model") then LocalPlayer.Character:MoveTo(map:GetBoundingBox()) end end)

-- GOD MODE AddButton("🛡️ God Mode", function() LocalPlayer.Character.Humanoid.Name = "GOD" end)

-- NOCLIP AddButton("🚪 NoClip", function() game:GetService("RunService").Stepped:Connect(function() for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end) end)

-- HIZ & ZIPLAMA AddButton("⚙️ Speed & Jump Boost", function() local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") h.WalkSpeed = 100 h.JumpPower = 120 end)

-- OTOMATİK KAZAN AddButton("🏆 Otomatik Kazan", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then p.Character:BreakJoints() end end end)

-- KAPAT AddButton("❌ Menüyü Kapat", function() MainFrame.Visible = false end)

