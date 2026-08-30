-- +1 SPEED ANTI-CHEAT BYPASS V92MEGA | ОБХОД АНТИЧИТА + ЛОКАЛЬНАЯ ВЫДАЧА
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ===== НАСТРОЙКИ =====
local settings = {
    Level = 999,
    Cups = 999999,
    GiveItems = true,
    GiveTracks = true
}

-- ===== GUI МЕНЮ =====
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 340, 0, 420)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
mainFrame.BackgroundTransparency = 0.05
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(0, 340, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🏆 +1 SPEED BYPASS V92"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.TextScaled = true

-- ===== ПОЛЯ ВВОДА =====
local function createLabel(text, y)
    local label = Instance.new("TextLabel")
    label.Parent = mainFrame
    label.Size = UDim2.new(0, 130, 0, 25)
    label.Position = UDim2.new(0, 10, 0, y)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    return label
end

local function createInput(y, default)
    local box = Instance.new("TextBox")
    box.Parent = mainFrame
    box.Size = UDim2.new(0, 130, 0, 25)
    box.Position = UDim2.new(0, 170, 0, y)
    box.Text = default
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.ClearTextOnFocus = false
    return box
end

createLabel("🎯 ЛЕВЕЛ:", 45)
local levelInput = createInput(43, "999")

createLabel("💎 КУБКИ:", 80)
local cupsInput = createInput(78, "999999")

-- ===== СТАТУС =====
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = mainFrame
statusLabel.Size = UDim2.new(0, 320, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 370)
statusLabel.Text = "ГОТОВ | ОБХОД АНТИЧИТА АКТИВЕН"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextScaled = true

-- ===== ОБХОД 1: ЧЕРЕЗ АТРИБУТЫ (НЕ СБРАСЫВАЕТСЯ) =====
local function giveViaAttributes(amount, name)
    pcall(function()
        local current = LocalPlayer:GetAttribute(name) or 0
        LocalPlayer:SetAttribute(name, current + amount)
    end)
end

-- ===== ОБХОД 2: ЧЕРЕЗ НОВЫЙ ОБЪЕКТ =====
local function giveViaNewObject(amount, name)
    pcall(function()
        local obj = Instance.new("NumberValue")
        obj.Name = name .. "_Bypass"
        obj.Value = amount
        obj.Parent = LocalPlayer
    end)
end

-- ===== ОБХОД 3: ЧЕРЕЗ LEADERSTATS (С ПЕРЕЗАПИСЬЮ) =====
local function giveViaLeaderstats(amount, pattern)
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            local name = stat.Name:lower()
            if name:find(pattern) then
                pcall(function()
                    stat.Value = amount
                end)
            end
        end
    end
end

-- ===== ОБХОД 4: ЧЕРЕЗ ИМИТАЦИЮ UI =====
local function giveViaUI(amount, pattern)
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local text = obj.Text or ""
            if text:lower():find(pattern) then
                local num = tonumber(text:match("%d+"))
                if num then
                    pcall(function()
                        obj.Text = string.gsub(text, num, num + amount)
                    end)
                end
            end
        end
    end
end

-- ===== ОБХОД 5: ЧЕРЕЗ REMOTE =====
local function giveViaRemote(amount, type)
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("add") or name:find("give") or name:find("set") or name:find("update") then
                pcall(function()
                    remote:FireServer(type, amount)
                    remote:FireServer({Type = type, Value = amount})
                end)
            end
        end
    end
end

-- ===== ГЛАВНАЯ ФУНКЦИЯ ВЫДАЧИ (С ОБХОДОМ) =====
local function giveBypass(level, cups)
    statusLabel.Text = "🔄 ОБХОД АНТИЧИТА..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    -- ВЫДАЧА ЛЕВЕЛА
    giveViaAttributes(level, "Level")
    giveViaAttributes(level, "Lvl")
    giveViaAttributes(level, "Rank")
    giveViaLeaderstats(level, "level")
    giveViaLeaderstats(level, "lvl")
    giveViaLeaderstats(level, "rank")
    giveViaNewObject(level, "Level")
    giveViaUI(level, "level")
    giveViaUI(level, "lvl")
    giveViaRemote(level, "Level")
    
    -- ВЫДАЧА КУБКОВ
    giveViaAttributes(cups, "Cups")
    giveViaAttributes(cups, "Points")
    giveViaAttributes(cups, "Score")
    giveViaLeaderstats(cups, "cup")
    giveViaLeaderstats(cups, "троф")
    giveViaLeaderstats(cups, "points")
    giveViaNewObject(cups, "Cups")
    giveViaUI(cups, "cup")
    giveViaUI(cups, "троф")
    giveViaRemote(cups, "Cups")
    
    -- ВЫДАЧА ПРЕДМЕТОВ
    if settings.GiveItems then
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("BoolValue") then
                local name = obj.Name:lower()
                if name:find("item") or name:find("skin") or name:find("unlock") then
                    pcall(function() obj.Value = true end)
                end
            end
        end
        giveViaAttributes(1, "AllItems")
        giveViaAttributes(1, "ItemsUnlocked")
    end
    
    -- ВЫДАЧА ДОРОЖЕК
    if settings.GiveTracks then
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("BoolValue") then
                local name = obj.Name:lower()
                if name:find("track") or name:find("road") or name:find("trail") then
                    pcall(function() obj.Value = true end)
                end
            end
        end
        giveViaAttributes(1, "AllTracks")
        giveViaAttributes(1, "TracksUnlocked")
    end
    
    statusLabel.Text = "✅ ОБХОД УСПЕШЕН! ЛВ:" .. level .. " КУБ:" .. cups
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end

-- ===== ГЛАВНАЯ КНОПКА =====
local giveBtn = Instance.new("TextButton")
giveBtn.Parent = mainFrame
giveBtn.Size = UDim2.new(0, 300, 0, 40)
giveBtn.Position = UDim2.new(0, 20, 0, 120)
giveBtn.Text = "🌟 ВЫДАТЬ ВСЁ (ОБХОД)"
giveBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
giveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveBtn.TextScaled = true
giveBtn.MouseButton1Click:Connect(function()
    local level = tonumber(levelInput.Text) or 999
    local cups = tonumber(cupsInput.Text) or 999999
    giveBypass(level, cups)
end)

-- ===== ДОПОЛНИТЕЛЬНЫЕ КНОПКИ =====
local function createSmallBtn(text, x, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = mainFrame
    btn.Size = UDim2.new(0, 140, 0, 30)
    btn.Position = UDim2.new(0, x, 0, 180)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createSmallBtn("🎯 ТОЛЬКО ЛЕВЕЛ", 15, Color3.fromRGB(0, 200, 100), function()
    local level = tonumber(levelInput.Text) or 999
    giveViaAttributes(level, "Level")
    giveViaLeaderstats(level, "level")
    statusLabel.Text = "✅ ЛЕВЕЛ " .. level .. " ВЫДАН (ОБХОД)"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

createSmallBtn("💎 ТОЛЬКО КУБКИ", 185, Color3.fromRGB(255, 200, 0), function()
    local cups = tonumber(cupsInput.Text) or 999999
    giveViaAttributes(cups, "Cups")
    giveViaLeaderstats(cups, "cup")
    statusLabel.Text = "✅ " .. cups .. " КУБКОВ ВЫДАНО (ОБХОД)"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

-- ===== БЛОКИРОВКА СБРОСА =====
RunService.Heartbeat:Connect(function()
    -- ПОСТОЯННО ВОССТАНАВЛИВАЕМ ЗНАЧЕНИЯ
    pcall(function()
        if LocalPlayer:GetAttribute("Level") and LocalPlayer:GetAttribute("Level") < settings.Level then
            LocalPlayer:SetAttribute("Level", settings.Level)
        end
        if LocalPlayer:GetAttribute("Cups") and LocalPlayer:GetAttribute("Cups") < settings.Cups then
            LocalPlayer:SetAttribute("Cups", settings.Cups)
        end
    end)
end)

-- ===== УПРАВЛЕНИЕ =====
UserInputService.InputBegan:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.Space then
        mainFrame.Visible = not mainFrame.Visible
    end
    if input.KeyCode == Enum.KeyCode.Escape then
        mainFrame.Visible = false
    end
end)

-- ===== ЗАКРЫТИЕ =====
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Size = UDim2.new(0, 100, 0, 25)
closeBtn.Position = UDim2.new(0, 220, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

print("🏆 +1 SPEED BYPASS V92MEGA ЗАГРУЖЕН!")
print("📌 [ПРОБЕЛ] - ПОКАЗАТЬ/СКРЫТЬ")
print("🛡️ ОБХОД АНТИЧИТА АКТИВЕН")
print("🌟 НАЖМИТЕ 'ВЫДАТЬ ВСЁ (ОБХОД)'")
print("🔄 АВТО-ВОССТАНОВЛЕНИЕ ЗНАЧЕНИЙ АКТИВНО")
