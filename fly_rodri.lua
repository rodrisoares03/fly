local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local noclip = false
local speed = 5
local bodyGyro, bodyVelocity

-- Criar GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FlyMenu"
screenGui.ResetOnSpawn = false

-- Frame Principal Bonito
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 180)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local shadow = Instance.new("ImageLabel", frame)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0

-- Label Principal
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "☁️ Rodri Menu"
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.ZIndex = 2

local labelCorner = Instance.new("UICorner", label)
labelCorner.CornerRadius = UDim.new(0, 12)

-- Aba Fly
local flyTabButton = Instance.new("TextButton", frame)
flyTabButton.Size = UDim2.new(0.5, 0, 0, 30)
flyTabButton.Position = UDim2.new(0, 0, 0, 30)
flyTabButton.Text = "Fly"
flyTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyTabButton.TextScaled = true
flyTabButton.Font = Enum.Font.GothamBold
flyTabButton.ZIndex = 2

local flyTabButtonCorner = Instance.new("UICorner", flyTabButton)
flyTabButtonCorner.CornerRadius = UDim.new(0, 8)

-- Aba Noclip
local noclipTabButton = Instance.new("TextButton", frame)
noclipTabButton.Size = UDim2.new(0.5, 0, 0, 30)
noclipTabButton.Position = UDim2.new(0.5, 0, 0, 30)
noclipTabButton.Text = "Noclip"
noclipTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipTabButton.TextScaled = true
noclipTabButton.Font = Enum.Font.GothamBold
noclipTabButton.ZIndex = 2

local noclipTabButtonCorner = Instance.new("UICorner", noclipTabButton)
noclipTabButtonCorner.CornerRadius = UDim.new(0, 8)

-- Fly Settings (Dentro da Aba Fly)
local flyFrame = Instance.new("Frame", frame)
flyFrame.Size = UDim2.new(1, 0, 0, 120)
flyFrame.Position = UDim2.new(0, 0, 0, 60)
flyFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyFrame.Visible = false
flyFrame.ZIndex = 2

local flyCorner = Instance.new("UICorner", flyFrame)
flyCorner.CornerRadius = UDim.new(0, 12)

-- Caixa de Texto para Velocidade
local speedBox = Instance.new("TextBox", flyFrame)
speedBox.Size = UDim2.new(0.8, 0, 0, 40)
speedBox.Position = UDim2.new(0.1, 0, 0, 20)
speedBox.Text = "5"
speedBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextScaled = true
speedBox.Font = Enum.Font.GothamBold
speedBox.ZIndex = 2

local speedBoxCorner = Instance.new("UICorner", speedBox)
speedBoxCorner.CornerRadius = UDim.new(0, 8)

local function updateSpeed()
    local inputSpeed = tonumber(speedBox.Text)
    if inputSpeed and inputSpeed >= 1 then
        speed = inputSpeed
    end
end

speedBox.FocusLost:Connect(updateSpeed)

-- Fly Button
local flyButton = Instance.new("TextButton", flyFrame)
flyButton.Size = UDim2.new(0.8, 0, 0, 40)
flyButton.Position = UDim2.new(0.1, 0, 0, 70)
flyButton.Text = "Toggle Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true
flyButton.Font = Enum.Font.GothamBold
flyButton.ZIndex = 2

local flyButtonCorner = Instance.new("UICorner", flyButton)
flyButtonCorner.CornerRadius = UDim.new(0, 8)

-- Noclip Button (Dentro da Aba Noclip)
local noclipFrame = Instance.new("Frame", frame)
noclipFrame.Size = UDim2.new(1, 0, 0, 120)
noclipFrame.Position = UDim2.new(0, 0, 0, 60)
noclipFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipFrame.Visible = false
noclipFrame.ZIndex = 2

local noclipCorner = Instance.new("UICorner", noclipFrame)
noclipCorner.CornerRadius = UDim.new(0, 12)

local noclipButton = Instance.new("TextButton", noclipFrame)
noclipButton.Size = UDim2.new(0.8, 0, 0, 40)
noclipButton.Position = UDim2.new(0.1, 0, 0, 20)
noclipButton.Text = "Toggle Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.TextScaled = true
noclipButton.Font = Enum.Font.GothamBold
noclipButton.ZIndex = 2

local noclipButtonCorner = Instance.new("UICorner", noclipButton)
noclipButtonCorner.CornerRadius = UDim.new(0, 8)

-- Função para restaurar colisão quando o noclip for desativado
local function restoreCollision()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Função de controle Fly
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    flyButton.Text = flying and "Stop Fly" or "Toggle Fly"
    flyButton.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(70, 70, 70)
    
    -- Criar e remover o BodyGyro e BodyVelocity para manter o personagem no ar
    if flying then
        bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.D = 1000
        bodyGyro.CFrame = humanoidRootPart.CFrame

        bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- Garante que ele não cai

    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end)

noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipButton.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    noclipButton.BackgroundColor3 = noclip and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(70, 70, 70)

    if noclip then
        -- Quando o noclip for ativado, desativar colisão das partes
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        -- Quando o noclip for desativado, restaurar colisão
        restoreCollision()
    end
end)

-- Troca entre Abas
flyTabButton.MouseButton1Click:Connect(function()
    flyFrame.Visible = true
    noclipFrame.Visible = false
end)

noclipTabButton.MouseButton1Click:Connect(function()
    flyFrame.Visible = false
    noclipFrame.Visible = true
end)

-- Controles de movimento
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local control = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then control.F = 1 end
    if input.KeyCode == Enum.KeyCode.S then control.B = 1 end
    if input.KeyCode == Enum.KeyCode.A then control.L = 1 end
    if input.KeyCode == Enum.KeyCode.D then control.R = 1 end
    if input.KeyCode == Enum.KeyCode.Space then control.U = 1 end
    if input.KeyCode == Enum.KeyCode.LeftControl then control.D = 1 end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then control.F = 0 end
    if input.KeyCode == Enum.KeyCode.S then control.B = 0 end
    if input.KeyCode == Enum.KeyCode.A then control.L = 0 end
    if input.KeyCode == Enum.KeyCode.D then control.R = 0 end
    if input.KeyCode == Enum.KeyCode.Space then control.U = 0 end
    if input.KeyCode == Enum.KeyCode.LeftControl then control.D = 0 end
end)

RunService.RenderStepped:Connect(function()
    -- Noclip
    if noclip then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end

    -- Fly
    if flying then
        local cam = workspace.CurrentCamera
        local moveVec = Vector3.zero

        local forward = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        local up = Vector3.new(0, 1, 0)

        moveVec = moveVec 
            + forward * (control.F - control.B)
            + right * (control.R - control.L)
            + up * (control.U - control.D)

        if moveVec.Magnitude > 0 then
            moveVec = moveVec.Unit * speed
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveVec
        end
    end
end)
