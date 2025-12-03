local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

-- ANTI MULTI GUI
if player.PlayerGui:FindFirstChild("SimpleHub") then
    player.PlayerGui.SimpleHub:Destroy()
end
local UI = Instance.new("ScreenGui")
UI.Name = "SimpleHub"
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false

-- main frame --

local frame = Instance.new("Frame")
frame.Parent = UI
frame.Size = UDim2.new(0.7, 0, 0.7, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromHex("6150A8")
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromHex("3920A2")
frame.ClipsDescendants = true
frame.Visible = true
local cornframe = Instance.new("UICorner")
cornframe.Parent = frame
cornframe.CornerRadius = UDim.new(0.1, 0)

local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")), 
    ColorSequenceKeypoint.new(1, Color3.fromHex("0000FF"))  
}
borderGradient.Parent = frame

-- toggle button --

local bouton = Instance.new("ImageButton")
bouton.Parent = UI
bouton.AnchorPoint = Vector2.new(0, 0.5)
bouton.Size = UDim2.new(0, 40, 0, 40)
bouton.Position = UDim2.new(0.05, 0, 0.5, 0)
local cornbutton = Instance.new("UICorner")
cornbutton.Parent = bouton
cornbutton.CornerRadius = UDim.new(0.2, 0) -- Correction de la frappe

local function onToggleClicked()
    frame.Visible = not frame.Visible
    if frame.Visible then
        bouton.Image = "rbxassetid://7468883533" 
    else
        bouton.Image = "rbxassetid://257125765" 
    end
end

bouton.MouseButton1Click:Connect(onToggleClicked)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end 
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        onToggleClicked()
    end
end)

-- title bar --

local titre = Instance.new("Frame")
titre.Parent = frame
titre.Size = UDim2.new(1, 0, 0.1, 0)
titre.AnchorPoint = Vector2.new(0, 0)
titre.BackgroundColor3 = Color3.fromHex("13DECD")

local texte_titre = Instance.new("TextLabel")
texte_titre.Text = "Simple Hub"
texte_titre.Size = UDim2.new(0.4, 0, 0.9, 0)
texte_titre.AnchorPoint = Vector2.new (0.5, 0.5)
texte_titre.Position = UDim2.new(0.5, 0, 0.5, 0)
texte_titre.TextColor3 = Color3.fromHex("FF0000")
texte_titre.BackgroundTransparency = 1
texte_titre.Parent = titre
texte_titre.Active = false -- Assure que les clics passent à 'titre' pour le glissement

local logo = Instance.new("ImageLabel")
logo.Parent = titre
logo.Size = UDim2.new(0.1, 0, 0.9, 0)
logo.AnchorPoint = Vector2.new(1, 0)
logo.Position = UDim2.new(0.89, 0, 0.05, 0)
logo.Image = "rbxassetid://345081304"
local logoRatio = Instance.new("UIAspectRatioConstraint")
logoRatio.Parent = logo
logoRatio.AspectRatio = 1.0 -- Force Largeur / Hauteur = 1 (X = Y)
logoRatio.AspectType = Enum.AspectType.ScaleWithParentSize

-- DRAG LOGIC (Glissement de la fenêtre via la barre de titre)

local dragging = false
local dragStart = Vector2.new(0, 0)
local frameStart = UDim2.new(0, 0, 0, 0)

titre.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = frame.Position
        input.Handled = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local currentAbsoluteSize = frame.Parent.AbsoluteSize
        
        -- Conversion de l'UDim2 en pixels, application du delta, et reconversion en Scale.
        local framePosPixelsX = frameStart.X.Scale * currentAbsoluteSize.X + frameStart.X.Offset
        local framePosPixelsY = frameStart.Y.Scale * currentAbsoluteSize.Y + frameStart.Y.Offset
        
        local newScaleX = (framePosPixelsX + delta.X) / currentAbsoluteSize.X
        local newScaleY = (framePosPixelsY + delta.Y) / currentAbsoluteSize.Y
        
        frame.Position = UDim2.new(newScaleX, 0, newScaleY, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- tabsFrame --

local tabsFrame = Instance.new("Frame")
tabsFrame.Parent = frame
tabsFrame.Size = UDim2.new(0.15, 0, 0.9, 0)
tabsFrame.AnchorPoint = Vector2.new(0, 0)
tabsFrame.Position = UDim2.new(0.05, 0, 0.1, 15)
tabsFrame.BackgroundColor3 = Color3.fromHex("1C2833") -- Couleur sombre
local corn4 = Instance.new("UICorner")
corn4.Parent = tabsFrame
corn4.CornerRadius = UDim.new(0.1, 0)

-- category --

local cat1 = Instance.new("Frame")
cat1.Parent = frame
cat1.Size = UDim2.new(0.7, 0, 0.15, 0)
cat1.AnchorPoint = Vector2.new(0, 0)
cat1.Position = UDim2.new(0.3, 0, 0.15, 0)
cat1.BackgroundColor3 = Color3.fromHex("F100E5")
local corn1 = Instance.new("UICorner")
corn1.Parent = cat1
corn1.CornerRadius = UDim.new(0, 12)

local cat2 = Instance.new("Frame")
cat2.Parent = frame
cat2.Size = UDim2.new(0.7, 0, 0.15, 0)
cat2.AnchorPoint = Vector2.new(0, 0)
cat2.Position = UDim2.new(0.3, 0, 0.45, 0)
cat2.BackgroundColor3 = Color3.fromHex("F100E5")
local corn2 = Instance.new("UICorner")
corn2.Parent = cat2
corn2.CornerRadius = UDim.new(0, 12)

local cat3 = Instance.new("Frame")
cat3.Parent = frame
cat3.Size = UDim2.new(0.7, 0, 0.15, 0)
cat3.AnchorPoint = Vector2.new(0, 0)
cat3.Position = UDim2.new(0.3, 0, 0.75, 0) -- Ajusté pour mieux utiliser l'espace
cat3.BackgroundColor3 = Color3.fromHex("F100E5")
local corn3 = Instance.new("UICorner")
corn3.Parent = cat3
corn3.CornerRadius = UDim.new(0, 12)

---
## ⚡ Modules de Triche

-- speed module --

local speedConnection = nil 

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Parent = cat1
SpeedDisplay.Size = UDim2.new(0.25, 0, 0.8, 0)
SpeedDisplay.AnchorPoint = Vector2.new(0, 0.5)
SpeedDisplay.Position = UDim2.new(0.01, 0, 0.5, 0)
SpeedDisplay.BackgroundTransparency = 1
SpeedDisplay.TextColor3 = Color3.fromHex("000000") 
SpeedDisplay.TextYAlignment = Enum.TextYAlignment.Center

local function updateSpeedText(humanoid)
    SpeedDisplay.Text = "Vitesse: " .. tostring(humanoid.WalkSpeed)
end

local function setupSpeedDisplay(character)
    local Humanoid = character:WaitForChild("Humanoid") 
    
    if not Humanoid then 
        SpeedDisplay.Text = "Vitesse: --"
        return 
    end

    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    speedConnection = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        updateSpeedText(Humanoid)
    end)
    
    Humanoid.Died:Connect(function()
        SpeedDisplay.Text = "Vitesse: --"
    end)

    updateSpeedText(Humanoid)
end

player.CharacterAdded:Connect(setupSpeedDisplay)

local text1 = Instance.new("TextBox")
text1.Parent = cat1
text1.AnchorPoint = Vector2.new(0.5, 0.5)
text1.Size = UDim2.new(0.25, 0, 0.8, 0)
text1.Position = UDim2.new(0.5, 0, 0.5, 0)
text1.PlaceholderText = "32"
text1.TextYAlignment = Enum.TextYAlignment.Center
text1.TextColor3 = Color3.fromHex("000000")
local corn = Instance.new("UICorner")
corn.Parent = text1
corn.CornerRadius = UDim.new(0, 6)

local AB1 = Instance.new("TextButton")
AB1.Parent = cat1
AB1.AnchorPoint = Vector2.new(1, 0.5)
AB1.Size = UDim2.new(0.25, 0, 0.8, 0)
AB1.Position = UDim2.new(0.99, 0, 0.5, 0)
AB1.BackgroundColor3 = Color3.fromHex("009900")
AB1.Text = "Set"
AB1.TextColor3 = Color3.fromHex("000000") 
local corn3 = Instance.new("UICorner")
corn3.Parent = AB1
corn3.CornerRadius = UDim.new(0.2, 0)

local function apply()
    local character = player.Character
    if not character then return end 
    local Humanoid = character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    local newSpeed = tonumber(text1.Text)

    if newSpeed and newSpeed >= 0 then
        Humanoid.WalkSpeed = newSpeed

        AB1.Text = "Applied !"
        AB1.BackgroundColor3 = Color3.fromHex("00FF00") 
        task.wait(1) 
        AB1.Text = "Set"
        AB1.BackgroundColor3 = Color3.fromHex("009900")
    else
        AB1.Text = "FAILED !!"
        AB1.BackgroundColor3 = Color3.fromHex("FF0000") 
        task.wait(1) 
        AB1.Text = "Set"
        AB1.BackgroundColor3 = Color3.fromHex("009900")
    end
end

AB1.MouseButton1Click:Connect(apply)

-- jump power module --

local jumpConnection = nil 

local JumpDisplay = Instance.new("TextLabel")
JumpDisplay.Parent = cat2
JumpDisplay.Size = UDim2.new(0.25, 0, 0.8, 0)
JumpDisplay.AnchorPoint = Vector2.new(0, 0.5)
JumpDisplay.Position = UDim2.new(0.01, 0, 0.5, 0)
JumpDisplay.BackgroundTransparency = 1
JumpDisplay.TextColor3 = Color3.fromHex("000000")
JumpDisplay.TextYAlignment = Enum.TextYAlignment.Center

local function updateJumpText(humanoid)
    JumpDisplay.Text = "Jump Power: " .. tostring(humanoid.JumpPower)
end

local function setupJumpDisplay(character)
    local Humanoid = character:WaitForChild("Humanoid") 
    
    if not Humanoid then 
        JumpDisplay.Text = "Jump Power: --"
        return 
    end

    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    
    jumpConnection = Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        updateJumpText(Humanoid)
    end)
    
    Humanoid.Died:Connect(function()
        JumpDisplay.Text = "Jump Power: --" 
    end)

    updateJumpText(Humanoid)
end

player.CharacterAdded:Connect(setupJumpDisplay)

local text2 = Instance.new("TextBox")
text2.Parent = cat2
text2.AnchorPoint = Vector2.new(0.5, 0.5)
text2.Size = UDim2.new(0.25, 0, 0.8, 0)
text2.Position = UDim2.new(0.5, 0, 0.5, 0)
text2.PlaceholderText = "100" 
text2.TextYAlignment = Enum.TextYAlignment.Center
text2.TextColor3 = Color3.fromHex("000000")
local corn2_2 = Instance.new("UICorner")
corn2_2.Parent = text2
corn2_2.CornerRadius = UDim.new(0, 6)

local AB2 = Instance.new("TextButton")
AB2.Parent = cat2
AB2.AnchorPoint = Vector2.new(1, 0.5)
AB2.Size = UDim2.new(0.25, 0, 0.8, 0)
AB2.Position = UDim2.new(0.99, 0, 0.5, 0)
AB2.BackgroundColor3 = Color3.fromHex("009900")
AB2.Text = "Set Jump"
AB2.TextColor3 = Color3.fromHex("000000") 
local corn2_3 = Instance.new("UICorner")
corn2_3.Parent = AB2
corn2_3.CornerRadius = UDim.new(0.2, 0)

local function applyJump()
    local character = player.Character
    if not character then return end 
    local Humanoid = character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    local newJump = tonumber(text2.Text)

    if newJump and newJump >= 0 then
        Humanoid.JumpPower = newJump

        AB2.Text = "Applied !"
        AB2.BackgroundColor3 = Color3.fromHex("00FF00") 
        task.wait(1) 
        AB2.Text = "Set Jump"
        AB2.BackgroundColor3 = Color3.fromHex("009900")
    else
        AB2.Text = "FAILED !!"
        AB2.BackgroundColor3 = Color3.fromHex("FF0000") 
        task.wait(1) 
        AB2.Text = "Set Jump"
        AB2.BackgroundColor3 = Color3.fromHex("009900")
    end
end

AB2.MouseButton1Click:Connect(applyJump)

-- gravity module --

local gravityConnection = nil

local GravityDisplay = Instance.new("TextLabel")
GravityDisplay.Parent = cat3
GravityDisplay.Size = UDim2.new(0.25, 0, 0.8, 0)
GravityDisplay.AnchorPoint = Vector2.new(0, 0.5)
GravityDisplay.Position = UDim2.new(0.01, 0, 0.5, 0)
GravityDisplay.BackgroundTransparency = 1
GravityDisplay.TextColor3 = Color3.fromHex("000000")
GravityDisplay.TextYAlignment = Enum.TextYAlignment.Center

local function updateGravityText()
    GravityDisplay.Text = "Gravité: " .. tostring(workspace.Gravity)
end

local function setupGravityDisplay()
    if gravityConnection then
        gravityConnection:Disconnect()
        gravityConnection = nil
    end
    gravityConnection = workspace:GetPropertyChangedSignal("Gravity"):Connect(function()
        updateGravityText()
    end)
    updateGravityText()
end
setupGravityDisplay()

local text3 = Instance.new("TextBox")
text3.Parent = cat3
text3.AnchorPoint = Vector2.new(0.5, 0.5)
text3.Size = UDim2.new(0.25, 0, 0.8, 0)
text3.Position = UDim2.new(0.5, 0, 0.5, 0)
text3.PlaceholderText = "196.2" -- Valeur par défaut
text3.TextYAlignment = Enum.TextYAlignment.Center
text3.TextColor3 = Color3.fromHex("000000")
local corn3_2 = Instance.new("UICorner")
corn3_2.Parent = text3
corn3_2.CornerRadius = UDim.new(0, 6)

local AB3 = Instance.new("TextButton")
AB3.Parent = cat3
AB3.AnchorPoint = Vector2.new(1, 0.5)
AB3.Size = UDim2.new(0.25, 0, 0.8, 0)
AB3.Position = UDim2.new(0.99, 0, 0.5, 0)
AB3.BackgroundColor3 = Color3.fromHex("009900")
AB3.Text = "Set Gravity"
AB3.TextColor3 = Color3.fromHex("000000")
local corn3_3 = Instance.new("UICorner")
corn3_3.Parent = AB3
corn3_3.CornerRadius = UDim.new(0.2, 0)

local function applyGravity()
    local newGravity = tonumber(text3.Text)

    if newGravity and newGravity >= 0 then
        workspace.Gravity = newGravity

        AB3.Text = "Applied !"
        AB3.BackgroundColor3 = Color3.fromHex("00FF00")
        task.wait(1)
        AB3.Text = "Set Gravity"
        AB3.BackgroundColor3 = Color3.fromHex("009900")
    else
        AB3.Text = "FAILED !!"
        AB3.BackgroundColor3 = Color3.fromHex("FF0000")
        task.wait(1)
        AB3.Text = "Set Gravity"
        AB3.BackgroundColor3 = Color3.fromHex("009900")
    end
end

AB3.MouseButton1Click:Connect(applyGravity)

-- Initial Setup (Fix for player loaded before script) --

if player.Character then
    setupSpeedDisplay(player.Character)
    setupJumpDisplay(player.Character)
end
