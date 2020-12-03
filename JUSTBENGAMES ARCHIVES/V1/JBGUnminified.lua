local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local Gamepasses = {10763094, 11123359, 11413776, 11413650, 11414794}
local achievemen = {
	{
		["ID"] = 1,
		["Name"] = "Welcome to TT Meetings",
		["Desc"] = "Join for the first time - EASY",
		["LogoID"] = "0",
		["IsMyst"] = false,
	},
	{
		["ID"] = 2,
		["Name"] = "Hi there Architect!",
		["Desc"] = "Meet the creator - EASY",
		["LogoID"] = "0",
		["IsMyst"] = false,
	},
	{
		["ID"] = 3,
		["Name"] = "Can you Sign my face too?",
		["Desc"] = "[insert desc here] - EASY",
		["LogoID"] = "0",
		["IsMyst"] = false,
	},
	{
		["ID"] = 4,
		["Name"] = "History Nerd",
		["Desc"] = "Played the older version. - RARE",
		["LogoID"] = "0",
		["IsMyst"] = false,
		["VerifbadgeID"] = 2124586679,
	},
}
local gamename = "TT Meetings"
local groupid = 5234214
local rules = {"1. You Must Wear Clothing while in-game","2. Exploiting is not allowed.","detection Will lead to a ban.","3. You must be nice to everyone in this server!"}
local JBGCover = "rbxassetid://5959590099"
local IsDevMode = false -- DO NOT SEND OUT TO PRODUCTION VERSIONS
local GameVersionNumber = "1.0 Revision 8"
local JustBenGameVerNum = "1.0 Revesion 3"

-- Prevent Script From Contiuning if softshutdown
if script.Parent.Parent:FindFirstChild("SoftShutdownGui") ~= nil then
	print(achievemen[88888998999894994994].Name) -- it won't return anything. 
end

-- DevMode

if IsDevMode then
	script.Parent.devmode.Visible = true
	script.Parent.dialog.Visible = true
	script.Parent.dialog.Frame.TitleText.Text = "You are Currently in Dev Mode"
	script.Parent.dialog.Frame.DescText.Text = "You are currently in development mode. Do not take pictures or videos. Click OK to continue."
end

-- AutoOpen

script.Parent.TabMenuOn:GetPropertyChangedSignal("Value"):Connect(function()
	if script.Parent.TabMenuOn.Value == true then 
		local tab = script.Parent.TabMenuTab.Value
		local tabmenu = script.Parent.TabMenu
		for i,v in pairs(tabmenu:GetChildren())do
			v.Visible = false
		end
		tabmenu.XBtn.Visible = true
		
	    if tab ~= "Main" then
		    tabmenu.Main.Visible = false
	    end
	    tabmenu[tab].Visible = true
		tabmenu:TweenPosition(UDim2.new(1,-400,0,0),nil,nil,1)
		script.Parent.TabToClose.Visible = true
	else
		local tab = script.Parent.TabMenuTab.Value
		local tabmenu = script.Parent.TabMenu
		tabmenu:TweenPosition(UDim2.new(1,00,0,0),nil,nil,1)
		script.Parent.TabToClose.Visible = false
	end	
end)
-- gamepass shop 100px
local Player = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")

local SampleFrame = script.Gamepass
local GamepassFrame = script.Parent.TabMenu.Store.MidArea.ScrollingFrame
local amountofpasses = 0

GamepassFrame.Parent.Background.Image = JBGCover

for i = 1, #Gamepasses do
	amountofpasses = amountofpasses + 1
	local GamepassId = Gamepasses[i]
	local GamepassData = MarketplaceService:GetProductInfo(GamepassId, Enum.InfoType.GamePass)
	local GamepassPrice = GamepassData.PriceInRobux
	local GamepassIcon = GamepassData.IconImageAssetId

	local GamepassSlot = SampleFrame:Clone()
	local GamepassImage = GamepassSlot.ImageLabel
	local PurchaseButton = GamepassSlot.Buy
	local Price = GamepassSlot.AchievementDesc
	
	GamepassSlot.Parent = GamepassFrame
	GamepassSlot.Name = GamepassId

	Price.Text = GamepassPrice .."R$"
	GamepassSlot.AchievementTitle.Text = GamepassData.Name
	GamepassImage.Image = "rbxassetid://" .. GamepassIcon
	player = game.Players.LocalPlayer
	
	if MarketplaceService:UserOwnsGamePassAsync(player.UserId,GamepassId) then
		PurchaseButton.Visible = false
	else
		GamepassSlot.AchievementStatus.Visible = false
	end
	PurchaseButton.MouseButton1Click:Connect(function()
		script.Parent.TabMenuOn.Value = false
		MarketplaceService:PromptGamePassPurchase(Player, GamepassId)
	end)
end
calc = amountofpasses * 100
script.Parent.TabMenu.Store.MidArea.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,calc)
script.Parent.TabMenu.Store.MidArea.Background.GameName.Text = gamename
-- Achievements
function giveoutAchievement(ID)
	achievement = achievemen[ID]
	local achivementtab = script.Parent.Achievement
	achivementtab.AchievementName.Text = achievement.Name
	achivementtab.ImageLabel.Image = achievement.LogoID
	achivementtab.Visible = false
	achivementtab.Position = UDim2.new(0.5,-175,0,-100)
	achivementtab.Visible = true
	achivementtab:TweenPosition(UDim2.new(0.5,-175,0,50),nil,nil,1)
	wait(6)
	achivementtab:TweenPosition(UDim2.new(0.5,-175,0,-100),nil,nil,1)
end
repeat until game.Workspace[game.Players.LocalPlayer.Name] ~= nil
wait(1)
unlockedachivement = 0
achivementnumberss = 0

script.Parent.TabMenu.Achievements.MidArea.Background.Image = JBGCover
for i = 1, #achievemen do
	local achievement = achievemen[i]
	if achievement.VerifbadgeID ~= nil then
		if game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, achievement.VerifbadgeID) then
			giveoutAchievement(achievement.ID)
		end
	end
	
	local achivementsa = script.Parent.TabMenu.Achievements.MidArea.ScrollingFrame
	temp = script.Achievement:Clone()
	temp.Name = achievement.ID
	temp.Parent = achivementsa
	
	temp.ImageLabel.Image = achievement.LogoID
	temp.AchievementTitle.Text = achievement.Name
	temp.AchievementDesc.Text = achievement.Desc
	
	--if unlocked then
	--	unlockedachivement = unlockedachivement + 1
	--end
	achivementnumberss = achivementnumberss + 1
	script.Parent.TabMenu.Achievements.MidArea.Background.GameName.Text = gamename
end

-- Game Rules

-- Startup info



local rulesscreen = script.Parent.TabMenu.TermsAndCon.MidArea.ScrollingFrame
temp = script.TextBold:Clone()
temp.Parent = rulesscreen
temp.Text = " "
temp = script.TextBold:Clone()
temp.Parent = rulesscreen
temp.Text = gamename
temp = script.TextBold:Clone()
temp.Parent = rulesscreen
temp.Text = "Terms And Conditions"
temp = script.TextBold:Clone()
temp.Parent = rulesscreen
temp.Text = " "

for i = 1, #rules do
	local rule = rules[i]
	temp = script.TextLight:Clone()
	temp.Parent = rulesscreen
	temp.Text = rule
end

local achivementtab = script.Parent.Message
achivementtab.Visible = false
achivementtab.Position = UDim2.new(0.5,-175,0,-100)
achivementtab.Visible = true
achivementtab:TweenPosition(UDim2.new(0.5,-175,0,50),nil,nil,1)
wait(6)
achivementtab:TweenPosition(UDim2.new(0.5,-175,0,-100),nil,nil,1)

-- trasition to main
for i,v in pairs(script.Parent.TabMenu:GetChildren()) do
	if v:isA("Frame") and v.Name ~= "Main" then
		v.TopArea.XBtn.MouseButton1Click:Connect(function()
			v:TweenPosition(UDim2.new(-1,0,0,0),nil,nil,1)
			script.Parent.TabMenu.Main.Visible = true
			script.Parent.TabMenu.Main.Position = UDim2.new(1,0,0,0)
			script.Parent.TabMenu.Main:TweenPosition(UDim2.new(0,0,0,0),nil,nil,1)
			wait(1)
			v.Position = UDim2.new(0,0,0,0)
			v.Visible = false
			script.Parent.TabMenuTab.Value = "Main"
		end)
	end
end
-- Main
script.Parent.TabMenu.Main.TopArea.UserName.Text = game.Players.LocalPlayer.Name
script.Parent.TabMenu.Main.TopArea.UserStatus.Text = "Playing ".. gamename
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
	if inputObject.KeyCode == Enum.KeyCode.Tab and workspace[game.Players.LocalPlayer.Name].Humanoid.WalkSpeed ~= 0 then
		if script.Parent.TabMenuOn.Value == false then
		    script.Parent.TabMenuTab.Value = "Main"
			script.Parent.TabMenuOn.Value = true
		else
			script.Parent.TabMenuTab.Value = ""
			script.Parent.TabMenuOn.Value = false
		end	
	end 
end)
-- transition from main p1
-- Achievements
local main = script.Parent.TabMenu.Main
main.MidArea.A.Achievements.MouseButton1Click:Connect(function()
	main:TweenPosition(UDim2.new(-1,0,0,0),nil,nil,1)
	script.Parent.TabMenu.Achievements.Visible = true
	script.Parent.TabMenu.Achievements.Position = UDim2.new(1,0,0,0)
	script.Parent.TabMenu.Achievements:TweenPosition(UDim2.new(0,0,0,0),nil,nil,1)
	wait(1)
	main.Position = UDim2.new(0,0,0,0)
	main.Visible = false
	script.Parent.TabMenuTab.Value = "Achievements"
end)
--Players
main.MidArea.A.Players.MouseButton1Click:Connect(function()
	main:TweenPosition(UDim2.new(-1,0,0,0),nil,nil,1)
	script.Parent.TabMenu.Players.Visible = true
	script.Parent.TabMenu.Players.Position = UDim2.new(1,0,0,0)
	script.Parent.TabMenu.Players:TweenPosition(UDim2.new(0,0,0,0),nil,nil,1)
	wait(1)
	main.Position = UDim2.new(0,0,0,0)
	main.Visible = false
	script.Parent.TabMenuTab.Value = "Players"
end)
-- Settings
main.MidArea.A.Settings.MouseButton1Click:Connect(function()
	main:TweenPosition(UDim2.new(-1,0,0,0),nil,nil,1)
	script.Parent.TabMenu.Settings.Visible = true
	script.Parent.TabMenu.Settings.Position = UDim2.new(1,0,0,0)
	script.Parent.TabMenu.Settings:TweenPosition(UDim2.new(0,0,0,0),nil,nil,1)
	wait(1)
	main.Position = UDim2.new(0,0,0,0)
	main.Visible = false
	script.Parent.TabMenuTab.Value = "Settings"
end)
-- transition from main p2
-- Store
main.MidArea.B.Store.MouseButton1Click:Connect(function()
	main:TweenPosition(UDim2.new(-1,0,0,0),nil,nil,1)
	script.Parent.TabMenu.Store.Visible = true
	script.Parent.TabMenu.Store.Position = UDim2.new(1,0,0,0)
	script.Parent.TabMenu.Store:TweenPosition(UDim2.new(0,0,0,0),nil,nil,1)
	wait(1)
	main.Position = UDim2.new(0,0,0,0)
	main.Visible = false
	script.Parent.TabMenuTab.Value = "Store"
end)

-- Players
local amountofplayers
local amountoffriends
function refreshplayers()
	amountofplayers = 0
	amountoffriends = 0
	-- remove leftovers
	for i,v in pairs(script.Parent.TabMenu.Players.MidArea.ScrollingFrame:GetChildren()) do
		if v:isA("Frame") then
			v:Destroy()
		end
	end
	for i,v in pairs(script.Parent.TabMenu.Main.ActiveFriends.ScrollingFrame:GetChildren()) do
		if v:isA("Frame") then
			v:Destroy()
		end
	end
	-- get players
	for i,v in pairs(game.Players:GetChildren()) do
		amountofplayers = amountofplayers + 1
		temp = script.Player:Clone()
		temp.Name = v.UserId
		temp.Parent = script.Parent.TabMenu.Players.MidArea.ScrollingFrame
		temp.UserName.Text = v.Name
		temp.Rank.Text = v:GetRoleInGroup(groupid)
		if v ~= game.Players.LocalPlayer and v:IsFriendsWith(game.Players.LocalPlayer.UserId) then
			amountoffriends = amountoffriends + 1
			temp = script.FriendInServer:Clone()
			temp.Name = v.UserId
			temp.Parent = script.Parent.TabMenu.Main.ActiveFriends.ScrollingFrame
			temp.PlayerName.Text = v.Name
			temp.Status.Text = "Playing ".. gamename
			temp.JOIN.Visible = false
			temp.MESSAGE.Visible = false
		end
	end
	rat2 = amountoffriends * 90
	rat = amountofplayers * 90
	script.Parent.TabMenu.Players.MidArea.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,rat)
	script.Parent.TabMenu.Main.ActiveFriends.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,rat2)
	script.Parent.TabMenu.Main.ActiveFriends.Title.Amount.Text = "(".. amountoffriends ..")"
end
refreshplayers()
game.Players.PlayerAdded:Connect(function()
	refreshplayers()
end)
game.Players.PlayerRemoving:Connect(function()
	refreshplayers()
end)
-- Settings Tab
-- Link to TermsOfService
script.Parent.TabMenu.Settings.MidArea.ScrollingFrame.TermsAndCon.MouseButton1Click:Connect(function()
	script.Parent.TabMenu.Settings.Visible = false
	script.Parent.TabMenu.TermsAndCon.Visible = true
end)
-- Link to OpenSourceLis
script.Parent.TabMenu.Settings.MidArea.ScrollingFrame.OpenSourceLis.MouseButton1Click:Connect(function()
	script.Parent.TabMenu.Settings.Visible = false
	script.Parent.TabMenu.OpenSourceLis.Visible = true
end)
