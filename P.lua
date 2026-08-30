-- +1 SPEED ADMIN MENU V92MEGA | ОДНА КНОПКА = ВСЁ СРАЗУ
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ===== НАСТРОЙКИ =====
local settings = {
    Level = 999,
    Cups = 999999,
    GiveItems = true,
    GiveTracks = true,
    GiveAll = true
}

-- ===== GUI МЕНЮ =====
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 320, 0, 350)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false -- ПО УМОЛЧАНИЮ СКРЫТО

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(0, 320, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🏆 +1 SPEED ADMIN V92"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.TextScaled = true

-- ПОЛЯ
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
    box.Position = UDim2.new(0, 160, 0, y)
    box.Text = default
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    return box
end

createLabel("🎯 ЛЕВЕЛ:", 45)
local levelInput = createInput(43, "999")

createLabel("💎 КУБКИ:", 80)
local cupsInput = createInput(78, "999999")

-- ===== ВЫДАЧА =====
local function giveLevel(amount)
    local success = false
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            local name = stat.Name:lower()
            if name:find("level") or name:find("lvl") or name:find("rank") then
                pcall(function()
                    stat.Value = amount
                    success = true
                end)
            end
        end
    end
    pcall(function()
        LocalPlayer:SetAttribute("Level", amount)
        LocalPlayer:SetAttribute("Lvl", amount)
        success = true
    end)
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("NumberValue") or obj:IsA("IntValue") then
            local name = obj.Name:lower()
            if name:find("level") or name:find("lvl") or name:find("rank") then
                pcall(function()
                    obj.Value = amount
                    success = true
                end)
            end
        end
    end
    return success
end

local function giveCups(amount)
    local success = false
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            local name = stat.Name:lower()
            if name:find("cup") or name:find("троф") or name:find("points") or name:find("score") then
                pcall(function()
                    stat.Value = amount
                    success = true
                end)
            end
        end
    end
    pcall(function()
        LocalPlayer:SetAttribute("Cups", amount)
        LocalPlayer:SetAttribute("Points", amount)
        success = true
    end)
    return success
end

local function giveAllItems()
    local success = false
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Folder") or obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("item") or name:find("inventory") or name:find("shop") then
                for _, child in pairs(obj:GetChildren()) do
                    if child:IsA("BoolValue") then
                        pcall(function()
                            child.Value = true
                            success = true
                        end)
                    end
                    if child:IsA("NumberValue") then
                        pcall(function()
                            child.Value = 1
                            success = true
                        end)
                    end
                end
            end
        end
    end
    pcall(function()
        LocalPlayer:SetAttribute("AllItems", true)
        LocalPlayer:SetAttribute("ItemsUnlocked", true)
        success = true
    end)
    return success
end

local function giveAllTracks()
    local success = false
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Folder") or obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("track") or name:find("road") or name:find("trail") or name:find("path") then
                for _, child in pairs(obj:GetChildren()) do
                    if child:IsA("BoolValue") then
                        pcall(function()
                            child.Value = true
                            success = true
                        end)
                    end
                end
            end
        end
    end
    pcall(function()
        LocalPlayer:SetAttribute("AllTracks", true)
        LocalPlayer:SetAttribute("TracksUnlocked", true)
        success = true
    end)
    return success
end

local function giveAll()
    local level = tonumber(levelInput.Text) or 999
    local cups = tonumber(cupsInput.Text) or 999999
    
    giveLevel(level)
    giveCups(cups)
    giveAllItems()
    giveAllTracks()
    
    statusLabel.Text = "✅ ВСЁ ВЫДАНО! ЛВ:" .. level .. " КУБ:" .. cups
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end

-- ===== ГЛАВНАЯ КНОПКА =====
local giveBtn = Instance.new("TextButton")
giveBtn.Parent = mainFrame
giveBtn.Size = UDim2.new(0, 280, 0, 40)
giveBtn.Position = UDim2.new(0, 20, 0, 120)
giveBtn.Text = "🌟 ВЫДАТЬ ВСЁ СРАЗУ"
giveBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
giveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
giveBtn.TextScaled = true
giveBtn.MouseButton1Click:Connect(giveAll)

-- ДОПОЛНИТЕЛЬНЫЕ КНОПКИ
local function createSmallBtn(text, y, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = mainFrame
    btn.Size = UDim2.new(0, 130, 0, 30)
    btn.Position = UDim2.new(0, y, 0, 180)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createSmallBtn("🎯 ЛЕВЕЛ", 20, Color3.fromRGB(0, 200, 100), function()
    local level = tonumber(levelInput.Text) or 999
    giveLevel(level)
    statusLabel.Text = "✅ ЛЕВЕЛ " .. level .. " ВЫДАН!"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

createSmallBtn("💎 КУБКИ", 170, Color3.fromRGB(255, 200, 0), function()
    local cups = tonumber(cupsInput.Text) or 999999
    giveCups(cups)
    statusLabel.Text = "✅ " .. cups .. " КУБКОВ ВЫДАНО!"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

-- СТАТУС
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = mainFrame
statusLabel.Size = UDim2.new(0, 300, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 310)
statusLabel.Text = "ГОТОВ"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextScaled = true

-- ===== ОТКРЫТИЕ ПО КНОПКЕ (ПРОБЕЛ) =====
UserInputService.InputBegan:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.Space then
        mainFrame.Visible = not mainFrame.Visible
    end
    if input.KeyCode == Enum.KeyCode.Escape then
        mainFrame.Visible = false
    end
end)

print("🏆 +1 SPEED ADMIN MENU V92MEGA ЗАГРУЖЕН!")
print("📌 НАЖМИТЕ [ПРОБЕЛ] ЧТОБЫ ОТКРЫТЬ МЕНЮ")
print("🛑 [ESC] - ЗАКРЫТЬ МЕНЮ")
print("🌟 НАЖМИТЕ 'ВЫДАТЬ ВСЁ' ДЛЯ ПОЛУЧЕНИЯ ВСЕГО")
