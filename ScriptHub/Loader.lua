local Utilities = loadstring(game:HttpGet("https://raw.githubusercontent.com/derekcool38/Releases/main/Functions/Utilities.lua"))()
if game.PlaceId == 2512643572 then -- Bubble Gum Simulator
    Utilities:Load("https://raw.githubusercontent.com/derekcool38/Releases/main/Scripts/BubbleGumSimulator.lua")
elseif game.PlaceId == 6186867282 then -- Project XL
    Utilities:Load("https://raw.githubusercontent.com/derekcool38/Releases/main/Scripts/ProjectXL.lua")
elseif game.PlaceId == 3311165597 then -- Dragon blox ultimate 
    Utilities:Load("https://raw.githubusercontent.com/derekcool38/Releases/main/Scripts/Dragon-Blox-Ultimate.lua")
else
    game:GetService("Players").LocalPlayer:Kick("[YerPeq Hub] Game not Supported")
end
