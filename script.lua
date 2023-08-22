local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "🔓 Anarchy v1.0", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "https://media.discordapp.net/attachments/1141033469636530196/1143228253197307904/Screenshot_2023-06-30_185332.png?width=273&height=431",
    PremiumOnly = false
   })
   
   local Section = PlayerTab:AddSection({
    Name = "👤 Movement"
   })
   
   PlayerTab:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "WS",
    Callback = function(Value)
     game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
   })

   PlayerTab:AddButton({
    Name = "Noclip (Z)",
    Callback = function ()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        local function enableNoclip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        local function disableNoclip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        
        local noclipEnabled = false
        
        local function toggleNoclip()
            noclipEnabled = not noclipEnabled
            if noclipEnabled then
                enableNoclip()
            else
                disableNoclip()
            end
        end
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Z then
                toggleNoclip()
            end
        end)
        
    end
   })

local OtherTab = Window:MakeTab({
    Name = "Others",
    Icon = "https://media.discordapp.net/attachments/1141033469636530196/1143228253197307904/Screenshot_2023-06-30_185332.png?width=273&height=431",
    PremiumOnly = false
   })
   
   local Section = OtherTab:AddSection({
    Name = "🔫 Others"
   })
   
   
   OtherTab:AddButton({
    Name = "ESP (P)",
    Callback = function()
        local FillColor = Color3.fromRGB(175, 25, 255)
        local DepthMode = "AlwaysOnTop"
        local FillTransparency = 0.5
        local OutlineColor = Color3.fromRGB(255, 255, 255)
        local OutlineTransparency = 0
        
        local CoreGui = game:GetService("CoreGui")
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local LocalPlayer = Players.LocalPlayer
        local connections = {}
        local highlightingEnabled = true
        
        local Storage = Instance.new("Folder")
        Storage.Parent = CoreGui
        Storage.Name = "Highlight_Storage"
        
        local function Highlight(plr)
            if not highlightingEnabled or plr == LocalPlayer then
                return
            end
        
            local Highlight = Instance.new("Highlight")
            Highlight.Name = plr.Name
            Highlight.FillColor = FillColor
            Highlight.DepthMode = DepthMode
            Highlight.FillTransparency = FillTransparency
            Highlight.OutlineColor = OutlineColor
            Highlight.OutlineTransparency = OutlineTransparency
            Highlight.Parent = Storage
            
            local plrchar = plr.Character
            if plrchar then
                Highlight.Adornee = plrchar
            end
        
            connections[plr] = plr.CharacterAdded:Connect(function(char)
                Highlight.Adornee = char
            end)
        end
        
        local function Unhighlight(plr)
            local highlight = Storage:FindFirstChild(plr.Name)
            if highlight then
                highlight:Destroy()
            end
        end
        
        Players.PlayerAdded:Connect(Highlight)
        for _, player in ipairs(Players:GetPlayers()) do
            Highlight(player)
        end
        
        Players.PlayerRemoving:Connect(function(plr)
            Unhighlight(plr)
            if connections[plr] then
                connections[plr]:Disconnect()
                connections[plr] = nil
            end
        end)
        
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.P then
                highlightingEnabled = not highlightingEnabled
                if not highlightingEnabled then
                    for _, player in ipairs(Players:GetPlayers()) do
                        Unhighlight(player)
                    end
                else
                    for _, player in ipairs(Players:GetPlayers()) do
                        Highlight(player)
                    end
                end
            end
        end)
      end    
   })

   OtherTab:AddButton({
    Name = "Silent Aim (C)",
    Callback = function()
        getgenv().Prediction =  (  0.01  )

        getgenv().FOV =  (  300  ) 

        getgenv().AimKey =  (  "c"  )

        local placeholdval = false


        local SilentAim = true
        local NeckOffSet = Vector3.new(0,-.5,0)
        local Players = game:GetService("Players")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local Mouse = LocalPlayer:GetMouse()
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Camera = game:GetService("Workspace").CurrentCamera
        local connections = getconnections(game:GetService("LogService").MessageOut)
        for _, v in ipairs(connections) do
        	v:Disable()
        end
        getgenv = getgenv
        Drawing = Drawing
        getrawmetatable = getrawmetatable
        getconnections = getconnections
        hookmetamethod = hookmetamethod
        
        local FOV_CIRCLE = Drawing.new("Circle")
        FOV_CIRCLE.Visible = true
        FOV_CIRCLE.Filled = false
        FOV_CIRCLE.Thickness = 1
        FOV_CIRCLE.Transparency = .4
        FOV_CIRCLE.Color = Color3.new(0, 1, 0)
        FOV_CIRCLE.Radius = getgenv().FOV
        FOV_CIRCLE.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        local Options = {
            Torso = "HumanoidRootPart";
            Head = "Head";
        }
        
        local function MoveFovCircle()
            pcall(function()
                local DoIt = true
                spawn(function()
                    while DoIt do task.wait()
                        FOV_CIRCLE.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    end
                end)
            end)
        end coroutine.wrap(MoveFovCircle)()
        
        Mouse.KeyDown:Connect(function(KeyPressed)
            if KeyPressed == (getgenv().AimKey:lower()) then
                if SilentAim == false then
                    FOV_CIRCLE.Color = Color3.new(0, 1, 0)
                    SilentAim = true
                elseif SilentAim == true then
                    FOV_CIRCLE.Color = Color3.new(1, 0, 0)
                    SilentAim = false
                end
            end
        end)
        Mouse.KeyDown:Connect(function(Rejoin)
            if Rejoin == "=" then
                local LocalPlayer = game:GetService("Players").LocalPlayer
                game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
            end
        end)
        
        getgenv().FORCE_REPEAT = {
          "FORIINDEXRETURNADMININGAME";
            "AimLockPsycho";
            "proboy32007";
            "autofarmaccountgrind";
        }
        
        local function InRadius()
            local Target = nil
            local Distance = 9e9
            local Players = game:GetService("Players")
            local LocalPlayer = game:GetService("Players").LocalPlayer
            local Camera = game:GetService("Workspace").CurrentCamera
            for _, v in pairs(Players:GetPlayers()) do 
                if not table.find(getgenv().FORCE_REPEAT, v.Name) then
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 then
                        local Enemy = v.Character	
                        local CastingFrom = CFrame.new(Camera.CFrame.Position, Enemy[Options.Torso].CFrame.Position) * CFrame.new(0, 0, -4)
                        local RayCast = Ray.new(CastingFrom.Position, CastingFrom.LookVector * 9000)
                        local World, ToSpace = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(RayCast, {LocalPlayer.Character:FindFirstChild("Head")})
                        local RootWorld = (Enemy[Options.Torso].CFrame.Position - ToSpace).magnitude
                        if RootWorld < 4 then		
                            local RootPartPosition, Visible = Camera:WorldToViewportPoint(Enemy[Options.Torso].Position)
                            if Visible then
                                local Real_Magnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(RootPartPosition.X, RootPartPosition.Y)).Magnitude
                                if Real_Magnitude < Distance and Real_Magnitude < FOV_CIRCLE.Radius then
                                    Distance = Real_Magnitude
                                    Target = Enemy
                                end
                            end
                        end
                    end
                end
            end
            return Target
        end
        
        local oldIndex = nil
        oldIndex = hookmetamethod(game, "__index", function(self, Index, Screw)
            local Screw = oldIndex(self, Index)
            local CALC = Mouse
            local GG = "hit"
            local MONCLER = GG
            if SilentAim then
            if self == CALC and (Index:lower() == MONCLER) then	
                local Enemy = InRadius()
                local Camera = game:GetService("Workspace").CurrentCamera
                if Enemy ~= nil and Enemy[Options.Head] and Enemy:FindFirstChild("Humanoid") and Enemy:FindFirstChild("Humanoid").Health > 0 then
                    local Madox = Enemy[Options.Head]
                    local Formulate = Madox.CFrame + (Madox.AssemblyLinearVelocity * getgenv().Prediction + NeckOffSet)	
                    return (Index:lower() == MONCLER and Formulate)
                end
                return Screw
            end
            end
            return oldIndex(self, Index, Screw)
        end)
    end    
})
   OrionLib:Init()

OrionLib:MakeNotification({
	Name = "Loading",
	Content = "Anarchy v.1.0 😈",
	Image = "rbxassetid://4483345998",
	Time = 10
})
