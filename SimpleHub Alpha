local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService") -- ✅ Ajout du service d'entrée

-- ScreenGui --

local UI = Instance.new("ScreenGui")
UI.Parent = player.PlayerGui
UI.ResetOnSpawn = false -- ✅ Empêche l'interface de disparaître à la mort

-- frame --

local frame = Instance.new("Frame")
frame.Parent = UI
frame.Size = UDim2.new(0.7, 0, 0.7, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(97, 80, 168)
frame.Visible = true

-- Bouton de Toggle (Ouvrir/Fermer) --

local bouton = Instance.new("ImageButton")
bouton.Parent = UI
bouton.AnchorPoint = Vector2.new(0, 0.5)
bouton.Size = UDim2.new(0, 40, 0, 40) -- Taille fixe 40x40 pixels
bouton.Position = UDim2.new(0.05, 0, 0.5, 0)


local function onToggleClicked()
    frame.Visible = not frame.Visible
    if frame.Visible then
        bouton.Image = "7468883533" 
    else
        bouton.Image = "257125765" 
    end
end

bouton.MouseButton1Click:Connect(onToggleClicked) -- Connexion du clic souris

-- Connexion du raccourci clavier (Alt)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end -- Ignore si l'utilisateur est en train de taper

    -- Utilise LeftAlt ou RightAlt pour plus de compatibilité
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        onToggleClicked()
    end
end)

---

-- title bar --

local titre = Instance.new("Frame")
titre.Parent = frame
titre.Size = UDim2.new(1, 0, 0.1, 0) -- 10% de hauteur
titre.AnchorPoint = Vector2.new(0, 0)
titre.BackgroundColor3 = Color3.fromHex("13DECD")

local texte_titre = Instance.new("TextLabel")
texte_titre.Text = "Simple Hub"
texte_titre.Size = UDim2.new(0.4, 0, 0.9, 0)
texte_titre.AnchorPoint = Vector2.new(0.5, 0.5) -- ✅ Centrage parfait
texte_titre.Position = UDim2.new(0.5, 0, 0.5, 0)
texte_titre.BackgroundColor3 = Color3.fromHex("16DF6E")
texte_titre.BackgroundTransparency = 1 -- ✅ Le texte est maintenant transparent
texte_titre.Parent = titre

---

-- speed (Affichage en temps réel) --

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Parent = frame
SpeedDisplay.Size = UDim2.new(0.2, 0, 0.1, 0)
SpeedDisplay.AnchorPoint = Vector2.new(0, 0)
SpeedDisplay.Position = UDim2.new(0, 3, 0.2, 5)
SpeedDisplay.BackgroundTransparency = 1 -- ✅ Fond transparent
SpeedDisplay.TextColor3 = Color3.fromHex("FFFFFF") -- Texte blanc pour le contraste

local function setupSpeedDisplay(character)
    -- Fonction pour configurer le Humanoid après chaque respawn
    local Humanoid = character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    local function updateSpeed()
        -- Mise à jour du texte avec la valeur actuelle (conversion en chaîne)
        SpeedDisplay.Text = "Vitesse: " .. tostring(Humanoid.WalkSpeed)
    end
    
    -- Connexion de l'événement (uniquement quand la propriété WalkSpeed change)
    Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(updateSpeed)
    
    updateSpeed() -- Affichage immédiat de la vitesse de départ
end

-- Connexions de stabilité
player.CharacterAdded:Connect(setupSpeedDisplay) -- Relance le setup après chaque mort

if player.Character then
    setupSpeedDisplay(player.Character) -- Lance le setup au démarrage si le joueur est déjà là
end
