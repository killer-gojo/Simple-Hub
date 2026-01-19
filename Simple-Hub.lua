local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")

-- ANTI MULTI GUI
if player.PlayerGui:FindFirstChild("SimpleHub") then
    player.PlayerGui.SimpleHub:Destroy()
end

local UI = Instance.new("ScreenGui")
UI.Name = "SimpleHub"
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Parent = UI
frame.Size = UDim2.new(0, 480, 0, 320)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromHex("6150A8")
frame.ClipsDescendants = true
frame.Visible = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- TITLE BAR (La barre de titre demandée)
local titreBarre = Instance.new("Frame")
titreBarre.Name = "TitleBar"
titreBarre.Parent = frame
titreBarre.Size = UDim2.new(1, 0, 0, 35)
titreBarre.BackgroundColor3 = Color3.fromHex("13DECD")
Instance.new("UICorner", titreBarre).CornerRadius = UDim.new(0, 10)

local texte_titre = Instance.new("TextLabel")
texte_titre.Parent = titreBarre
texte_titre.Text = "Simple Hub"
texte_titre.Size = UDim2.new(1, 0, 1, 0)
texte_titre.BackgroundTransparency = 1
texte_titre.TextColor3 = Color3.fromHex("FF0000")
texte_titre.Font = Enum.Font.SourceSansBold
texte_titre.TextSize = 20

-- BOUTON TOGGLE
local bouton = Instance.new("ImageButton")
bouton.Parent = UI
bouton.Size = UDim2.new(0, 45, 0, 45)
bouton.Position = UDim2.new(0.02, 0, 0.2, 0)
bouton.Image = "rbxassetid://7468883533"
Instance.new("UICorner", bouton).CornerRadius = UDim.new(0.3, 0)

bouton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    bouton.Image = frame.Visible and "rbxassetid://7468883533" or "rbxassetid://257125765"
end)

-- DRAG LOGIC (Sur la barre de titre ou la frame)
local dragging, dragInput, dragStart, startPos
local function updateDrag(input)
    local delta = input.Position - dragStart
    TweenService:Create(frame, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
end

titreBarre.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- TABS & PAGES
local tabsFrame = Instance.new("Frame", frame)
tabsFrame.Size = UDim2.new(0, 110, 0.8, 0)
tabsFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
tabsFrame.BackgroundColor3 = Color3.fromHex("1C2833")
Instance.new("UICorner", tabsFrame)
Instance.new("UIListLayout", tabsFrame).Padding = UDim.new(0, 5)

local pagesFolder = Instance.new("Frame", frame)
pagesFolder.Size = UDim2.new(0.72, 0, 0.8, 0)
pagesFolder.Position = UDim2.new(0.26, 0, 0.15, 0)
pagesFolder.BackgroundTransparency = 1

local allPages = {}
local function createPage(name)
    local p = Instance.new("ScrollingFrame", pagesFolder)
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.ScrollBarThickness = 2
    Instance.new("UIListLayout", p).Padding = UDim.new(0, 10)
    allPages[name] = p
    
    local b = Instance.new("TextButton", tabsFrame)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Text = name; b.BackgroundColor3 = Color3.fromHex("3920A2"); b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        for _, pg in pairs(allPages) do pg.Visible = false end
        p.Visible = true
    end)
end

createPage("Main"); createPage("Tweak"); createPage("Lock On"); createPage("Visual"); createPage("Credits")
allPages["Main"].Visible = true

-- FONCTION MODULE
local function addModule(page, title, defaultText, callback)
    local mod = Instance.new("Frame", page)
    mod.Size = UDim2.new(0.95, 0, 0, 70)
    mod.BackgroundColor3 = Color3.fromHex("F100E5")
    Instance.new("UICorner", mod)

    local tl = Instance.new("TextLabel", mod)
    tl.Size = UDim2.new(1, 0, 0.4, 0); tl.Text = "  " .. title
    tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.new(0,0,0); tl.Font = Enum.Font.SourceSansBold

    local statusLabel = Instance.new("TextLabel", mod)
    statusLabel.Size = UDim2.new(0.4, 0, 0.5, 0); statusLabel.Position = UDim2.new(0, 0, 0.4, 0)
    statusLabel.Text = "Actuel: --"; statusLabel.BackgroundTransparency = 1

    local tb = Instance.new("TextBox", mod)
    tb.Size = UDim2.new(0.2, 0, 0.4, 0); tb.Position = UDim2.new(0.45, 0, 0.45, 0)
    tb.PlaceholderText = defaultText; Instance.new("UICorner", tb)

    local btn = Instance.new("TextButton", mod)
    btn.Size = UDim2.new(0.25, 0, 0.4, 0); btn.Position = UDim2.new(0.7, 0, 0.45, 0)
    btn.Text = "Set"; btn.BackgroundColor3 = Color3.fromHex("009900"); Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function() callback(tonumber(tb.Text)) end)
    return statusLabel
end

local wsLabel = addModule(allPages["Main"], "Vitesse", "16", function(v) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = v or 16 end end)
local jpLabel = addModule(allPages["Main"], "Saut", "50", function(v) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.JumpPower = v or 50 end end)
local gLabel = addModule(allPages["Main"], "Gravité", "196.2", function(v) workspace.Gravity = v or 196.2 end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                wsLabel.Text = "Actuel: " .. math.floor(player.Character.Humanoid.WalkSpeed)
                jpLabel.Text = "Actuel: " .. math.floor(player.Character.Humanoid.JumpPower)
            end
            gLabel.Text = "Actuel: " .. math.floor(workspace.Gravity)
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftAlt then frame.Visible = not frame.Visible end
end)