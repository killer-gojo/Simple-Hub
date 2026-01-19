local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- 1. CRÉATION DE L'ÉCRAN (CORRIGÉ POUR ÉCRAN ENTIER)
local SG = Instance.new("ScreenGui", player.PlayerGui)
SG.Name = "SimpleLoader"
SG.DisplayOrder = 999
SG.IgnoreGuiInset = true -- FORCE LE REMPLISSAGE TOTAL (MÊME SOUS LA BARRE ROBLOX)

local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(1, 0, 1, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0 -- Enlève les bordures gênantes

local container = Instance.new("Frame", Main)
container.Size = UDim2.new(0.8, 0, 0, 60) -- Un peu plus large pour ne pas couper le texte
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", container)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 2. ANIMATION
TweenService:Create(Main, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()
task.wait(0.8)

local fullText = "Simple Hub"
for i = 1, #fullText do
    local char = string.sub(fullText, i, i)
    local letter = Instance.new("TextLabel", container)
    letter.Text = char
    -- Ajustement de la taille auto des lettres
    letter.Size = UDim2.new(0, (char == " " and 20 or 35), 1, 0)
    letter.BackgroundTransparency = 1
    letter.TextTransparency = 1
    letter.TextColor3 = Color3.fromHex("13DECD")
    letter.Font = Enum.Font.SpecialElite
    letter.TextSize = 50
    letter.LayoutOrder = i
    
    TweenService:Create(letter, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.12) -- Un peu plus rapide pour rester sous les 4s
end

task.wait(1.2)

-- 3. FADE OUT GÉNÉRAL
for _, v in pairs(container:GetChildren()) do
    if v:IsA("TextLabel") then
        TweenService:Create(v, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    end
end
local lastTween = TweenService:Create(Main, TweenInfo.new(0.8), {BackgroundTransparency = 1})
lastTween:Play()

lastTween.Completed:Connect(function()
    SG:Destroy()
    
    -- CHARGEMENT DU GITHUB
    local success, scriptContent = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/killer-gojo/Simple-Hub/refs/heads/main/Simple-Hub.lua")
    end)

    if success then
        loadstring(scriptContent)()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Simple Hub",
            Text = "Chargement terminé !",
            Duration = 3
        })
    end
end)