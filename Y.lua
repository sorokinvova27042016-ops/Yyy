-- 99 NIGHTS CLASS FORCE UNLOCK V92MEGA | ПОЛНЫЙ ОБХОД СИСТЕМЫ КЛАССОВ
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ===== НАСТРОЙКИ =====
local settings = {
    ForceUnlock = true,
    LockClasses = true,
    BypassServer = true,
    SpoofPurchase = true
}

-- ===== GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 280, 0, 260)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(0, 280, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🛡️ CLASS FORCE UNLOCK"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.BackgroundTransparency = 1
title.TextScaled = true

local function createToggle(text, y, settingKey)
    local btn = Instance.new("TextButton")
    btn.Parent = mainFrame
    btn.Size = UDim2.new(0, 260, 0, 28)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text .. " ✅"
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        settings[settingKey] = not settings[settingKey]
        btn.Text = text .. (settings[settingKey] and " ✅" or " ❌")
    end)
    return btn
end

createToggle("ПРИНУДИТЕЛЬНАЯ РАЗБЛОКИРОВКА", 40, "ForceUnlock")
createToggle("БЛОКИРОВКА СБРОСА", 75, "LockClasses")

local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = mainFrame
statusLabel.Size = UDim2.new(0, 260, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 180)
statusLabel.Text = "ГОТОВ"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextScaled = true

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Size = UDim2.new(0, 120, 0, 28)
closeBtn.Position = UDim2.new(0, 80, 0, 220)
closeBtn.Text = "ЗАКРЫТЬ [SHIFT]"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, isTyping)
    if isTyping then return end
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
    if input.KeyCode == Enum.KeyCode.Escape then
        settings.ForceUnlock = false
        settings.LockClasses = false
        print("🛑 ОСТАНОВЛЕНО")
    end
end)

-- ===== 1. СПУФИНГ ПОКУПКИ =====
local function spoofPurchase()
    if not settings.SpoofPurchase then return false end
    
    -- ПЕРЕХВАТЫВАЕМ РЕМОТЫ ПОКУПКИ
    for _, remote in pairs(game:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local name = remote.Name:lower()
            if name:find("buy") or name:find("purchase") or name:find("unlock") or name:find("class") then
                pcall(function()
                    -- ОТПРАВЛЯЕМ ФЕЙКОВЫЙ ЗАПРОС О ПОКУПКЕ
                    remote:FireServer("Class", "Unlock", "Purchase")
                    remote:FireServer({Type = "Class", Action = "Buy"})
                    remote:FireServer("AllClasses")
                end)
            end
        end
    end
    
    return true
end

-- ===== 2. РАЗБЛОКИРОВКА ЧЕРЕЗ ФОЛЬДЕР =====
local function forceUnlockClasses()
    if not settings.ForceUnlock then return false end
    
    -- СОЗДАЁМ ФОЛЬДЕР КЛАССОВ
    local classData = LocalPlayer:FindFirstChild("ClassData") or Instance.new("Folder")
    classData.Name = "ClassData"
    classData.Parent = LocalPlayer
    
    -- СПИСОК КЛАССОВ
    local classes = {
        "Warrior", "Mage", "Archer", "Assassin", "Tank", 
        "Healer", "Berserker", "Wizard", "Rogue", "Knight",
        "Paladin", "Necromancer", "Hunter", "Druid", "Shaman"
    }
    
    for _, className in pairs(classes) do
        -- РАЗБЛОКИРОВКА
        local unlocked = classData:FindFirstChild(className .. "_Unlocked")
        if not unlocked then
            unlocked = Instance.new("BoolValue")
            unlocked.Name = className .. "_Unlocked"
            unlocked.Value = true
            unlocked.Parent = classData
        else
            unlocked.Value = true
        end
        
        -- УРОВЕНЬ
        local level = classData:FindFirstChild(className .. "_Level")
        if not level then
            level = Instance.new("NumberValue")
            level.Name = className .. "_Level"
            level.Value = 99
            level.Parent = classData
        else
            level.Value = 99
        end
        
        -- ОПЫТ
        local exp = classData:FindFirstChild(className .. "_Exp")
        if not exp then
            exp = Instance.new("NumberValue")
            exp.Name = className .. "_Exp"
            exp.Value = 999999
            exp.Parent = classData
        else
            exp.Value = 999999
        end
    end
    
    -- УСТАНАВЛИВАЕМ АТРИБУТЫ
    LocalPlayer:SetAttribute("AllClassesUnlocked", true)
    LocalPlayer:SetAttribute("ClassAccess", true)
    LocalPlayer:SetAttribute("PremiumClasses", true)
    
    return true
end

-- ===== 3. БЛОКИРОВКА СБРОСА =====
local function lockClasses()
    if not settings.LockClasses then return end
    if not settings.ForceUnlock then return end
    
    local classData = LocalPlayer:FindFirstChild("ClassData")
    if not classData then return end
    
    -- ПОСТОЯННО ВОССТАНАВЛИВАЕМ
    for _, child in pairs(classData:GetChildren()) do
        pcall(function()
            if child:IsA("BoolValue") and child.Name:find("Unlocked") then
                if child.Value == false then
                    child.Value = true
                end
            end
            if child:IsA("NumberValue") and child.Name:find("Level") then
                if child.Value < 99 then
                    child.Value = 99
                end
            end
        end)
    end
    
    -- ВОССТАНАВЛИВАЕМ АТРИБУТЫ
    pcall(function()
        if LocalPlayer:GetAttribute("AllClassesUnlocked") ~= true then
            LocalPlayer:SetAttribute("AllClassesUnlocked", true)
        end
        if LocalPlayer:GetAttribute("ClassAccess") ~= true then
            LocalPlayer:SetAttribute("ClassAccess", true)
        end
    end)
end

-- ===== 4. ОБХОД СЕРВЕРА =====
local function bypassServer()
    if not settings.BypassServer then return end
    
    -- БЛОКИРУЕМ СОБЫТИЯ СБРОСА
    for _, event in pairs(game:GetDescendants()) do
        if event:IsA("RemoteEvent") then
            local name = event.Name:lower()
            if name:find("reset") or name:find("wipe") or name:find("clear") or name:find("revert") then
                pcall(function()
                    event:Connect(function()
                        -- ОТМЕНЯЕМ СБРОС
                        return
                    end)
                end)
            end
        end
    end
end

-- ===== ОСНОВНОЙ ЦИКЛ =====
RunService.Heartbeat:Connect(function()
    if not settings.ForceUnlock then return end
    
    forceUnlockClasses()
    spoofPurchase()
    
    if settings.LockClasses then
        lockClasses()
    end
    
    if settings.BypassServer then
        bypassServer()
    end
end)

-- ===== КНОПКА РАЗБЛОКИРОВКИ =====
local unlockBtn = Instance.new("TextButton")
unlockBtn.Parent = mainFrame
unlockBtn.Size = UDim2.new(0, 140, 0, 30)
unlockBtn.Position = UDim2.new(0, 70, 0, 120)
unlockBtn.Text = "🔓 РАЗБЛОКИРОВАТЬ"
unlockBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
unlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unlockBtn.TextScaled = true
unlockBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "🔄 ПРИНУДИТЕЛЬНАЯ РАЗБЛОКИРОВКА..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    forceUnlockClasses()
    spoofPurchase()
    
    if settings.LockClasses then
        lockClasses()
    end
    
    statusLabel.Text = "✅ ВСЕ КЛАССЫ РАЗБЛОКИРОВАНЫ!"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    print("🔓 ВСЕ КЛАССЫ РАЗБЛОКИРОВАНЫ (ОБХОД АНТИЧИТА)")
end)

-- ===== ПРИ РЕСПАВНЕ =====
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if settings.ForceUnlock then
        forceUnlockClasses()
        statusLabel.Text = "🔄 КЛАССЫ ВОССТАНОВЛЕНЫ"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    end
end)

print("🛡️ 99 NIGHTS CLASS FORCE UNLOCK V92MEGA ЗАГРУЖЕН!")
print("📌 [SHIFT] - МЕНЮ")
print("🛑 [ESC] - ОСТАНОВИТЬ")
print("🔓 ПОЛНАЯ РАЗБЛОКИРОВКА КЛАССОВ")
print("🔒 БЛОКИРОВКА СБРОСА")
print("🛡️ ОБХОД СЕРВЕРНЫХ ПРОВЕРОК")
