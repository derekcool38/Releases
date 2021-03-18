-- Useful stuff i use for my UIs and Scripts
local Utilities = {}
local PS = game:GetService("Players")

function Utilities:Tween(obj,properties,duration,complete,...)
    local Tween = game:GetService("TweenService"):Create(obj,TweenInfo.new(duration,...),properties)
    
    if obj and properties and duration then
        Tween:Play()
    end

    if complete then 
        Tween.Completed:Wait()
    end
end

function Utilities:TweenDistance(obj,speed,complete,...)
    local Info = TweenInfo.new((obj.Position - PS.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / speed,...)
    local Tween = game:GetService("TweenService"):Create(PS.LocalPlayer.Character.HumanoidRootPart,Info,{CFrame = obj})

    if obj and speed then
        Tween:Play()
    end

    if complete then
        Tween.Completed:Wait()
    end
end

-- venyx kek
function Utilities:Create(obj,properties,children)
    local obj = Instance.new(obj)
    local properties = properties or {}
    local children = children or {}

    -- I don't like borders and having to put BorderSizePixel = 0 each time i so ok
    if obj:IsA("Frame") or obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("ScrollingFrame") or obj:IsA("ImageLabel") then
        obj.BorderSizePixel = 0
    end

    for i,v in pairs(properties) do
        obj[i] = v
    end

    for i,v in pairs(children) do
        v.Parent = obj
    end

    return obj
end

function Utilities:Dragify(onj,Speed)
    dragToggle = nil
    dragSpeed = Speed or 1
    dragInput = nil
    dragStart = nil
    dragPos = nil
    
    function updateInput(input)
    Delta = input.Position - dragStart
    Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    game:GetService("TweenService"):Create(onj, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end
    
    onj.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
    dragToggle = true
    dragStart = input.Position
    startPos = onj.Position
    input.Changed:Connect(function()
    if (input.UserInputState == Enum.UserInputState.End) then
    dragToggle = false
    end
    end)
    end
    end)
    
    onj.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    dragInput = input
    end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
    if (input == dragInput and dragToggle) then
    updateInput(input)
    end
    end)
end

function Utilities:Time()
    local Date = os.date("*t")
    return ("%02d:%02d"):format(((Date.hour % 24) - 1) % 12 + 1, Date.min)
end

function Utilities:Load(url)
    loadstring(game:HttpGet(url))()
end

function Utilities:SetHumanoid(type,value)
    PS.LocalPlayer.Character.Humanoid[type] = value
end

function Utilities:TP(plr)
    PS.LocalPlayer.Character.HumanoidRootPart.CFrame = PS[plr].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
end

function Utilities:Teleport(x,y,z)
    PS.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
end

function Utilities:Noti(title,text,duration)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = title;
        Text = text;
        Duration = duration;
    })
end

return Utilities
