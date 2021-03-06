--[[
    These are the Stuff i use to make my Interfaces and Scripts
    Made this to make my scripts more clean and faster to make
    You can use this if you want but don't claim it as yours although this is easy
    I recently just made this more organized into catergorys so its easier to find what you need
    Also i don't like elseif statements so you might see alot of if statements
    --derek38#0038--
]]

--Services--
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local PlayerService = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathFindingService = game:GetService("PathfindingService")
local VirtualInputManager = game:GetService("VirtualInputManager")

--Starting--
local Utilities = {}

--Tweening--
function Utilities:Tween(obj,properties,duration,complete,...) --Basic Tweening Function--
    local obj = obj or PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Tween = TweenService:Create(obj,TweenInfo.new(duration,...),properties)

    if obj and properties and duration then
        Tween:Play()
    end

    if complete then
        Tween.Completed:Wait()
    end

end

function Utilities:TweenDistance(obj,speed,complete,...) --Distance Tweening or so. Gets the Distance Between the Object and Player and Divides it by the speed. With "Normal" Tweening it will slowdown once the obj/player is close to the desired destination. but not with this cause Magntiude is cool (Don't Know How to Explain It) --
    local Information = TweenInfo.new((obj.Position - PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude / speed,...)
    local Tween = TweenService:Create(PlayerService.LocalPlayer.Character.HumanoidRootPart,Information,{CFrame = obj})
    
    if obj and speed then
        Tween:Play()
    end

    if complete then
        Tween.Completed:Wait()
        return true
    end

end

--Instancing--
function Utilities:Create(obj,properties,children) --Creating a Instance. From Venyx gg. Makes writing a new ui Library Clean and Easy--
    local obj = Instance.new(obj)
    local properties = properties or {}
    local children = children or {}
    
    for i,v in pairs(properties) do
        obj[i] = v
    end

    for i,v in pairs(children) do
        v.Parent = obj
    end

    pcall(function()
        obj.BorderSizePixel = 0 --I Don't Like Borders--
    end)

    return obj
end

function Utilities:Draw(obj,properties) --Creates a Drawing Object--
    if not Drawing then
        return warn"Your Exploit Doesn't Support the Drawing Library"
    end

    local obj = Drawing.new(obj)
    local properties = properties or {}

    for i,v in pairs(properties) do
        obj[i] = v
    end

    return obj
end

--Player(s) Info--
function Utilities:Gamepass(gamepass,player) --Checks if a player owns the desired gamepassed. Returns true or false--
    local player = player or PlayerService.LocalPlayer.UserId
    return MarketService:UserOwnsGamePassAsync(player,gamepass)
end

function Utilities:Profile(userid,type,size)
    --defaults--
    local userid = userid or PlayerService.LocalPlayer.UserId
    local type = type or Enum.ThumbnailType.AvatarBust
    local size = size or Enum.ThumbnailSize.Size420x420

    return PlayerService:GetUserThumbnailAsync(userid,type,size)
end

--Exploit Support--
function Utilities:ExploitSupports(c,callback) --Checks if your exploti supports a function. Ngl kinda useless since you can just do if functionname then end but this is fancy so why not--
    local callback = callback or function() end

    if c then
        callback(true)
        return true
    end

    callback(false)
    return false
end

function Utilities:GetRequest() --Getting the request function from a exploit. I don't know all of them so some might not be here--
    local c = request or http_request or syn.request or Request or httprequest or http
    return c
end

--web stuff--
function Utilities:Load(url) --loadstring but simple i guess--
    return loadstring(game:HttpGet(url))()
end

function Utilities:jsonrequest(url,body)
    Utilities:GetRequest()({
        Url = url;
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(body)
    })
end

--self--
function Utilities:SetHumanoid(type,v) --Should be obv but for the dumbies its like game.players.locaplayerwalkspeed = 38 but easier--
    PlayerService.LocalPlayer.Character:FindFirstChild("Humanoid")[type] = v
end

function Utilities:Anchor(c) --Anchores the HumanoidRootPart depending if you put true or false--
    PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = c
end

function Utilities:Magnitude(obj) --Returns the Magntiude/Distance of the Object from you--
    return (obj.Position - PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
end

function Utilities:Teleport(pos) --Teleporting to the desired Position--
    PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = pos
end

function Utilities:TP(plr) --Teleporting to a Player--
    PlayerService.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = PlayerService[plr].Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,2)
end

function Utilities:Equip(tool,path) --Equiping a Tool--
    local path = path or PlayerService.LocalPlayer.Backpack 

    for i,v in pairs(path:GetChildren()) do
        if v:IsA("Tool") and v.Name == tool and v.Parent ~= nil then -- Some checks to prevent errors like when you die and Backpack is not a instance yet--
            PlayerService.LocalPlayer.Character.Humanoid:EquipTool(tool)
            return true
        end
    end
end

function Utilities:char()
    return PlayerService.LocalPlayer.Character
end

--Remotes--
function Utilities:Remote(name,args,type,path) --Firing a remote but cleaner--
    --defaults--
    local name = name or ""
    local args = args or {}
    local type = type or "FireServer"
    local path = path or ReplicatedStorage

    if name ~= "" then
        if type == "FireServer" then
            path[name]:FireServer(unpack(args))
        end

        if type == "InvokeServer" then
            path[name]:InvokeServer(unpack(args))
        end
    end
	
    --You might be confused on why there are 2 of these so let me explain. Sometimes you already put the name of the remote along with the path like game.ReplicatedStorage.Remote.Event.Yep. Yep would be the name but you don't feel like putting it back to where name is so uh?--
    if name == "" or name == nil then
        if type == "FireServer" then
            path:FireServer(unpack(args))
        end

        if type == "InvokeServer" then
            path:InvokeServer(unpack(args))
        end
    end

end

--Time--
function Utilities:Time() --Returns the current hour/minute/second
    return os.date("*t")["hour"]..":"..os.date("*t")["min"]..":"..os.date("*t")["sec"]
end

function Utilities:Date() -- Returns the current month/day/year
    return os.date("*t")["month"].."/"..os.date("*t")["day"].."/"..os.date("*t")["year"]
end

--Interface Tools--
function Utilities:Dragify(obj,speed)
    local dragToggle = nil
    local dragSpeed = speed or 1
    local dragInput = nil
    local dragStart = nil
    local dragPos = nil
    
    local function updateInput(input)
        local Delta = input.Position - dragStart
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(obj, TweenInfo.new(dragSpeed), {Position = Position}):Play()
    end
    
    obj.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = obj.Position

            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    dragToggle = false
                end
            end)
            
        end
    end)
    
    obj.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
            updateInput(input)
        end
    end)
    
end

--Tables--
function Utilities:Index(table,value) --Usefull (atleast for me) for removing stuff from a table like a player from a dropdown. Example : table.remove(List,Utilities:Index(List,game.Players.LocalPlayer.Name))
    for i,v in pairs(table) do
        if v == value then
            return i
        end
    end
end

function Utilities:Key(table,num) --returns the value of the index given--
    for i,v in pairs(table) do
        if i == num then
            return v
        end
    end 
end

function Utilities:Insert(Path,Table,Check,Sort) --Inserting children/values into a table--
    if typeof(Path) ~= "Instance" then
        return Utilities:Noti({Title = "Utilities",Text = tostring(Path).." Is not a Instance"})
    end

    for i,v in pairs(Path:GetChildren()) do
        if Check then
            if not table.find(Table,v.Name) then
                table.insert(Table,v.Name)
            end
        end

        if Check ~= true then
            table.insert(Table,v.Name)
        end
    end

    if Sort then
        table.sort(Table)
    end
    
end

function Utilities:Add(name,value) --Creating Your Own Functions Inside the Library. Useless but i was bored--
    local value = value or function () end
    table.insert(Utilities,value)
end

--Bot--
function Utilities:Path(obj,check,Type) --PathFinding Function--
    local Type = Type or "Walking"

    local Path = PathFindingService:CreatePath()
    Path:ComputeAsync(PlayerService.LocalPlayer.Character.HumanoidRootPart.Position,obj.Position)
    local Waypoints = Path:GetWaypoints()

    for i,v in pairs(Waypoints) do
        if check and Type == "Walking" then
            PlayerService.LocalPlayer.Character.Humanoid:MoveTo(v.Position)
        end

        if check and Type == "Tweening" then
            Utilities:TweenDistance(CFrame.new(v.Position),getgenv().Tweening_Speed or 100,true)
        end

        if v.Action == Enum.PathWaypointAction.Jump and check and Type == "Walking" then
            PlayerService.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        if check and Type == "Walking" then
            PlayerService.LocalPlayer.Character.Humanoid.MoveToFinished:Wait(.2)
        end
    end

    warn("[Utilities] Completed Path")
    return true
end

function Utilities:Find(path,obj)
    if typeof(path) ~= "Instance" then
        return Utilities:Noti({Title = "Utilities",Text = tostring(Path).." Is not a Instance"})
    end

    for i,v in pairs(path:GetChildren()) do
        if v:FindFirstChild(obj) then
            return v
        end
    end

    return false
end

--Misc--
function Utilities:Noti(properties)
    StarterGui:SetCore("SendNotification",properties)
end

function Utilities:KeyEvent(c) --Better Thsn VirtualUser Cause You Don't Need Your Roblox Window Focused--
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[string.upper(c)],false,game)
end

function Utilities:Kick(reason,player) --Ignore The player Part--
    local player = player or PlayerService.LocalPlayer.Name
    PlayerService[player]:Kick("\n"..reason)
end

print("derek38 was here")

--()
return Utilities
