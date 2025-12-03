local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- anti multi Gui --

if player.PlayerGui:FindFirstChild("SimpleHub") then
    player.PlayerGui.SimpleHub:Destroy()
end
local UI = Instance.new("ScreenGui")
UI.Name = "SimpleHub" -- Important !
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false

-- ScreenGui --

local UI = Instance.new("ScreenGui")
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

-- tabsFrame (Barre Latérale) --

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
cat3.Position = UDim2.new(0.3, 0, 0.65, 0)
cat3.BackgroundColor3 = Color3.fromHex("F100E5")
local corn3 = Instance.new("UICorner")
corn3.Parent = cat3
corn3.CornerRadius = UDim.new(0, 12)

-- speed --

local speedConnection = nil 

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Parent = cat1
SpeedDisplay.Size = UDim2.new(0.25, 0, 0.8, 0) -- Taille corrigée à 0.25
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
text1.Size = UDim2.new(0.25, 0, 0.8, 0) -- Taille corrigée à 0.25
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
AB1.Size = UDim2.new(0.25, 0, 0.8, 0) -- Taille corrigée à 0.25
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

    if newSpeed and newSpeed > 0 then
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

-- jump power --

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

-- Initial Setup (Fix for player loaded before script) --

if player.Character then
    setupSpeedDisplay(player.Character)
    setupJumpDisplay(player.Character)
end
