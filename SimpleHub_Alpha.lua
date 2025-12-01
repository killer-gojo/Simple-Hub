local Players = game:GetService("Players")
local player = game.Players.LocalPlayer

-- ScreenGui --

local UI = Instance.new("ScreenGui")
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false

-- frame --

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
    ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")), -- 🔴 Rouge au centre (Clé 0)
    ColorSequenceKeypoint.new(1, Color3.fromHex("0000FF"))  -- 🔵 Bleu aux bords (Clé 1)
}
borderGradient.Parent = frame

-- toggle button --

local UserInputService = game:GetService("UserInputService")
local bouton = Instance.new("ImageButton")


bouton.Parent = UI
bouton.AnchorPoint = Vector2.new(0, 0.5)
bouton.Size = UDim2.new(0, 40, 0, 40)
bouton.Position = UDim2.new(0.05, 0, 0.5, 0)


local function onToggleClicked()
    frame.Visible = not frame.Visible
    if frame.Visible then
        bouton.Image = "7468883533" 
    else
        bouton.Image = "257125765" 
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
texte_titre.TextColor3 = Color3.fromHex("16DF6E")
texte_titre.BackgroundTransparency = 1
texte_titre.Parent = titre

-- category 1 --

local cat1 = Instance.new("Frame")
cat1.Parent = frame
cat1.Size = UDim2.new(0.8, 0, 0.15, 0)
cat1.AnchorPoint = Vector2.new(0, 0)
cat1.Position = UDim2.new(0.1, 0, 0.15, 5)
cat1.BackgroundColor3 = Color3.fromHex("F100E5")

local corn1 = Instance.new("UICorner")
corn1.Parent = cat1
corn1.CornerRadius = UDim.new(0, 12)

-- speed --

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Parent = cat1
SpeedDisplay.Size = UDim2.new(0.25, 0, 0.8, 0)
SpeedDisplay.AnchorPoint = Vector2.new(0, 0.5)
SpeedDisplay.Position = UDim2.new(0.01, 0, 0.5, 0)
SpeedDisplay.BackgroundTransparency = 1

local function setupSpeedDisplay(character)
    local Humanoid = character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    local function updateSpeed()
        SpeedDisplay.Text = "Vitesse: " .. tostring(Humanoid.WalkSpeed)
    end
    
    Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(updateSpeed)
    
    updateSpeed()
end

player.CharacterAdded:Connect(setupSpeedDisplay)

if player.Character then
    setupSpeedDisplay(player.Character)
end

local text1 = Instance.new("TextBox")
text1.Parent = cat1
text1.AnchorPoint = Vector2.new(0.5, 0.5)
text1.Size = UDim2.new(0.25, 0, 0.8, 0)
text1.Position = UDim2.new(0.3, 0, 0.5, 0)
text1.PlaceholderText = 32
text1.TextYAlignment = Enum.TextYAlignment.Center
local corn2 = Instance.new("UICorner")
corn2.Parent = text1
corn2.CornerRadius = UDim.new(0, 6)

local AB1 = Instance.new("TextButton")
AB1.Parent = cat1
AB1.AnchorPoint = Vector2.new(1, 0.5)
AB1.Size = UDim2.new(0.4, 0, 0.8, 0)
AB1.Position = UDim2.new(0.95, 0, 0.5, 0)
AB1.BackgroundColor3 = Color3.fromHex("009900")
AB1.Text = "Set"
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
        wait(1)
        AB1.Text = "Set"
        AB1.BackgroundColor3 = Color3.fromHex("009900")
        end
        end
AB1.MouseButton1Click:Connect(apply)
