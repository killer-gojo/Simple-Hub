local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")

-- ==========================================
-- NETTOYAGE DES ANCIENNES SESSIONS (ANTI-BUG)
-- ==========================================
if _G.SimpleHubConnection then
    _G.SimpleHubConnection:Disconnect()
    _G.SimpleHubConnection = nil
end

_G.SimpleHubRunning = false -- Arrête l'ancienne boucle Refresh
task.wait(0.1) -- Laisse le temps au script précédent de s'éteindre

if player.PlayerGui:FindFirstChild("SimpleHub") then
    player.PlayerGui.SimpleHub:Destroy()
end

-- Démarrage de la nouvelle session
_G.SimpleHubRunning = true

-- ==========================================
-- CRÉATION DE L'INTERFACE
-- ==========================================
local UI = Instance.new("ScreenGui")
UI.Name = "SimpleHub"
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = UI
frame.Size = UDim2.new(0, 480, 0, 320)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromHex("6150A8")
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- BARRE DE TITRE
local titreBarre = Instance.new("Frame", frame)
titreBarre.Name = "TitleBar"
titreBarre.Size = UDim2.new(1, 0, 0, 35)
titreBarre.BackgroundColor3 = Color3.fromHex("13DECD")
Instance.new("UICorner", titreBarre).CornerRadius = UDim.new(0, 10)

local texte_titre = Instance.new("TextLabel", titreBarre)
texte_titre.Text = "Simple Hub"
texte_titre.Size = UDim2.new(1, 0, 1, 0)
texte_titre.BackgroundTransparency = 1
texte_titre.TextColor3 = Color3.fromHex("FF0000")
texte_titre.Font = Enum.Font.SourceSansBold
texte_titre.TextSize = 20

-- BOUTON TOGGLE (IMAGE)
local bouton = Instance.new("ImageButton", UI)
bouton.Size = UDim2.new(0, 45, 0, 45)
bouton.Position = UDim2.new(0.02, 0, 0.2, 0)
bouton.Image = "rbxassetid://7468883533" 
Instance.new("UICorner", bouton).CornerRadius = UDim.new(0.3, 0)
bouton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    bouton.Image = frame.Visible and "rbxassetid://7468883533" or "rbxassetid://257125765"
end)

-- LOGIQUE DE DRAG
local dragging, dragStart, startPos
titreBarre.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = frame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- SYSTÈME D'ONGLETS
local tabsFrame = Instance.new("Frame", frame)
tabsFrame.Size = UDim2.new(0, 110, 0.8, 0)
tabsFrame.Position = UDim2.new(0.04, 0, 0.15, 0) 
tabsFrame.BackgroundColor3 = Color3.fromHex("1C2833")
Instance.new("UICorner", tabsFrame)
Instance.new("UIListLayout", tabsFrame).Padding = UDim.new(0, 5)

local pagesFolder = Instance.new("Frame", frame)
pagesFolder.Size = UDim2.new(0.7, 0, 0.8, 0)
pagesFolder.Position = UDim2.new(0.28, 0, 0.15, 0)
pagesFolder.BackgroundTransparency = 1

local allPages = {}
local function createPage(name)
    local p = Instance.new("ScrollingFrame", pagesFolder)
    p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.Visible = false
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y; p.ScrollBarThickness = 2
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 10)
    allPages[name] = p
    
    local b = Instance.new("TextButton", tabsFrame)
    b.Size = UDim2.new(0.95, 0, 0, 35)
    b.Text = name; b.BackgroundColor3 = Color3.fromHex("3920A2"); b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _, pg in pairs(allPages) do pg.Visible = false end
        p.Visible = true
    end)
    return p
end

local mainPage = createPage("Main")
local tweakPage = createPage("Tweak")
local lockPage = createPage("Lock On")
local visualPage = createPage("Visual")
local creditsPage = createPage("Credits")

-- PAGE CREDITS FIXE
creditsPage.ScrollingEnabled = false
local creditText = Instance.new("TextLabel", creditsPage)
creditText.Size = UDim2.new(1, 0, 1, 0)
creditText.BackgroundTransparency = 1; creditText.TextSize = 22; creditText.TextColor3 = Color3.new(1, 1, 1)
creditText.Font = Enum.Font.SourceSansBold; creditText.Text = "Made by killer_gojo"

mainPage.Visible = true

-- ==========================================
-- FACTORIES (MODULES & TOGGLES)
-- ==========================================
local function addModule(page, title, defaultText, callback)
    local mod = Instance.new("Frame", page)
    mod.Size = UDim2.new(0.95, 0, 0, 75); mod.BackgroundColor3 = Color3.fromHex("F100E5")
    Instance.new("UICorner", mod)

    local tl = Instance.new("TextLabel", mod)
    tl.Size = UDim2.new(1, 0, 0.4, 0); tl.Text = "  " .. title
    tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.new(0,0,0); tl.Font = Enum.Font.SourceSansBold; tl.TextXAlignment = Enum.TextXAlignment.Left

    local statusLabel = Instance.new("TextLabel", mod)
    statusLabel.Size = UDim2.new(0.4, 0, 0.5, 0); statusLabel.Position = UDim2.new(0, 0, 0.4, 0)
    statusLabel.Text = "Current: --"; statusLabel.BackgroundTransparency = 1

    local tb = Instance.new("TextBox", mod)
    tb.Size = UDim2.new(0.2, 0, 0.4, 0); tb.Position = UDim2.new(0.45, 0, 0.45, 0)
    tb.PlaceholderText = defaultText; Instance.new("UICorner", tb)

    local btn = Instance.new("TextButton", mod)
    btn.Size = UDim2.new(0.25, 0, 0.4, 0); btn.Position = UDim2.new(0.7, 0, 0.45, 0)
    btn.Text = "Set"; btn.BackgroundColor3 = Color3.fromHex("009900"); Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() callback(tonumber(tb.Text)) end)
    return statusLabel
end

local function addToggle(page, title, callback)
    local active = false
    local mod = Instance.new("Frame", page)
    mod.Size = UDim2.new(0.95, 0, 0, 50); mod.BackgroundColor3 = Color3.fromHex("F100E5")
    Instance.new("UICorner", mod)

    local tl = Instance.new("TextLabel", mod)
    tl.Size = UDim2.new(0.6, 0, 1, 0); tl.Text = "  " .. title
    tl.BackgroundTransparency = 1; tl.Font = Enum.Font.SourceSansBold; tl.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton", mod)
    btn.Size = UDim2.new(0.3, 0, 0.7, 0); btn.Position = UDim2.new(0.65, 0, 0.15, 0)
    btn.Text = "OFF"; btn.BackgroundColor3 = Color3.fromHex("FF0000"); Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and "ON" or "OFF"
        btn.BackgroundColor3 = active and Color3.fromHex("009900") or Color3.fromHex("FF0000")
        callback(active)
    end)
end

-- ==========================================
-- FONCTIONNALITÉS
-- ==========================================
local wsL = addModule(mainPage, "Vitesse", "16", function(v) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = v or 16 end end)
local jpL = addModule(mainPage, "Saut", "50", function(v) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.JumpPower = v or 50 end end)
local gL = addModule(mainPage, "Gravité", "196.2", function(v) workspace.Gravity = v or 196.2 end)

local infJumpEnabled = false
_G.SimpleHubConnection = UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

addToggle(tweakPage, "Infinite Jump", function(state)
    infJumpEnabled = state
end)

-- BOUCLE DE RAFRAÎCHISSEMENT
task.spawn(function()
    while _G.SimpleHubRunning and task.wait(0.5) do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                wsL.Text = "Current: " .. math.floor(player.Character.Humanoid.WalkSpeed)
                jpL.Text = "Current: " .. math.floor(player.Character.Humanoid.JumpPower)
            end
            gL.Text = "Current: " .. math.floor(workspace.Gravity)
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftAlt then frame.Visible = not frame.Visible end
end)
