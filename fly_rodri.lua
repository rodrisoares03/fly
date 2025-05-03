local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local noclip = false
local speed = 5

local control = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

local function resetFly()
    flying = false
    if humanoidRootPart:FindFirstChild("BodyGyro") then
        humanoidRootPart.BodyGyro:Destroy()
    end
    if humanoidRootPart:FindFirstChild("BodyVelocity") then
        humanoidRootPart.BodyVelocity:Destroy()
    end
end

local function resetNoclip()
    noclip = false
    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = true
        end
    end
end

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FlyMenu"
screenGui.ResetOnSpawn = false

local function forceWhiteText(instance)
    instance.TextColor3 = Color3.fromRGB(255, 255, 255)
    instance:GetPropertyChangedSignal("TextColor3"):Connect(function()
        instance.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 180)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local shadow = Instance.new("ImageLabel", frame)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "☁️ Rodri Menu"
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.ZIndex = 2
Instance.new("UICorner", label).CornerRadius = UDim.new(0, 12)
forceWhiteText(label)

local flyTabButton = Instance.new("TextButton", frame)
flyTabButton.Size = UDim2.new(0.5, 0, 0, 30)
flyTabButton.Position = UDim2.new(0, 0, 0, 30)
flyTabButton.Text = "Fly"
flyTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyTabButton.TextScaled = true
flyTabButton.Font = Enum.Font.GothamBold
flyTabButton.ZIndex = 2
Instance.new("UICorner", flyTabButton).CornerRadius = UDim.new(0, 8)
forceWhiteText(flyTabButton)

local noclipTabButton = Instance.new("TextButton", frame)
noclipTabButton.Size = UDim2.new(0.5, 0, 0, 30)
noclipTabButton.Position = UDim2.new(0.5, 0, 0, 30)
noclipTabButton.Text = "Noclip"
noclipTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipTabButton.TextScaled = true
noclipTabButton.Font = Enum.Font.GothamBold
noclipTabButton.ZIndex = 2
Instance.new("UICorner", noclipTabButton).CornerRadius = UDim.new(0, 8)
forceWhiteText(noclipTabButton)

local flyFrame = Instance.new("Frame", frame)
flyFrame.Size = UDim2.new(1, 0, 0, 120)
flyFrame.Position = UDim2.new(0, 0, 0, 60)
flyFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyFrame.Visible = true
flyFrame.ZIndex = 2
Instance.new("UICorner", flyFrame).CornerRadius = UDim.new(0, 12)

local speedBox = Instance.new("TextBox", flyFrame)
speedBox.Size = UDim2.new(0.8, 0, 0, 40)
speedBox.Position = UDim2.new(0.1, 0, 0, 20)
speedBox.Text = "5"
speedBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
speedBox.TextScaled = true
speedBox.Font = Enum.Font.GothamBold
speedBox.ZIndex = 2
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 8)
forceWhiteText(speedBox)

local function updateSpeed()
    local inputSpeed = tonumber(speedBox.Text)
    if inputSpeed and inputSpeed >= 1 then
        speed = inputSpeed
    end
end
speedBox.FocusLost:Connect(updateSpeed)

local flyButton = Instance.new("TextButton", flyFrame)
flyButton.Size = UDim2.new(0.8, 0, 0, 40)
flyButton.Position = UDim2.new(0.1, 0, 0, 70)
flyButton.Text = "Toggle Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyButton.TextScaled = true
flyButton.Font = Enum.Font.GothamBold
flyButton.ZIndex = 2
Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0, 8)
forceWhiteText(flyButton)

local noclipFrame = Instance.new("Frame", frame)
noclipFrame.Size = UDim2.new(1, 0, 0, 120)
noclipFrame.Position = UDim2.new(0, 0, 0, 60)
noclipFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipFrame.Visible = false
noclipFrame.ZIndex = 2
Instance.new("UICorner", noclipFrame).CornerRadius = UDim.new(0, 12)

local noclipButton = Instance.new("TextButton", noclipFrame)
noclipButton.Size = UDim2.new(0.8, 0, 0, 40)
noclipButton.Position = UDim2.new(0.1, 0, 0, 20)
noclipButton.Text = "Toggle Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipButton.TextScaled = true
noclipButton.Font = Enum.Font.GothamBold
noclipButton.ZIndex = 2
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 8)
forceWhiteText(noclipButton)

-- Função Fly Toggle
flyButton.MouseButton1Click:Connect(function()
    if flying then
        resetFly()
        flyButton.Text = "Toggle Fly"
        flyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    else
        resetFly()
        flying = true
        flyButton.Text = "Stop Fly"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)

        local bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.D = 1000
        bodyGyro.CFrame = humanoidRootPart.CFrame

        local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Função Noclip Toggle
noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        noclipButton.Text = "Noclip: ON"
        noclipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
    else
        resetNoclip()
        noclipButton.Text = "Toggle Noclip"
        noclipButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

flyTabButton.MouseButton1Click:Connect(function()
    flyFrame.Visible = true
    noclipFrame.Visible = false
end)

noclipTabButton.MouseButton1Click:Connect(function()
    flyFrame.Visible = false
    noclipFrame.Visible = true
end)

-- Movimento
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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

-- Noclip Infinito Real
RunService.Stepped:Connect(function()
    if noclip then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)
