local Linoria = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/Library.lua"))()
local Window = Linoria:CreateWindow({
	Title = "Linoria - Lookin' Hackable - SubCargo",
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = true,
	UnlockMouseWhileOpen = true,
	NotifySide = "Right"
})

local Options = Linoria.Options
local Toggles = Linoria.Toggles

local Main = Window:AddTab("Main")
local PreMatchGroup = Main:AddLeftGroupbox("Pre-Match")
local SubmarineGroup = Main:AddLeftGroupbox("Submarine")
local PlayersGroup = Main:AddRightGroupbox("Players")
local MatchGroup = Main:AddRightGroupbox("Match")
local MiscGroup = Main:AddRightGroupbox("Misc")

local function plr(name)
	return game.Players:FindFirstChild(name)
end

local PlayerCount = PreMatchGroup:AddInput("PlayerCount", {
	Default = 4,
	Numeric = true,
	Text = "Player Count",
	Placeholder = 1
})

local FriendlyFire = PreMatchGroup:AddToggle("FriendlyFire", {
	Default = true,
	Text = "Friendly Fire",
})
local FriendsOnly = PreMatchGroup:AddToggle("FriendsOnly", {
	Default = false,
	Text = "Friends Only",
})
local ShipName = PreMatchGroup:AddInput("ShipName", {
	Default = "Lookin' Hackable",
	Text = "Submarine Name (Requires Ownership)",
	Placeholder = "Hello World!"
})
local SkipLoading = PreMatchGroup:AddToggle("SkipLoading", {
	Default = false,
	Text = "Skip Loading",
})
local MatchReward = PreMatchGroup:AddInput("MatchReward", {
	Default = 200,
	Numeric = true,
	Text = "Match Reward",
	Placeholder = 100
})
PreMatchGroup:AddButton("Set Match Settings", function()
	game:GetService("ReplicatedStorage"):WaitForChild("create"):FireServer(
		1,
		tonumber(PlayerCount.Value),
		"easy",
		FriendlyFire.Value,
		FriendsOnly.Value,
		20,
		ShipName.Value,
		"STEEL_PLATES",
		SkipLoading.Value,
		tonumber(MatchReward.Value)
	)
end)
PreMatchGroup:AddButton("Start Match", function()
	game:GetService("ReplicatedStorage"):WaitForChild("create"):FireServer(5)

end)
PreMatchGroup:AddLabel("NOTE: ALL OTHER EXPLOITS ONLY")
PreMatchGroup:AddLabel("WORK IN-GAME, RESET/LOSE")
PreMatchGroup:AddLabel("OR WIN TO SAVE DATA CORRECTLY")

MiscGroup:AddLabel("Suggest more features")
MiscGroup:AddLabel("in the Discord Server")
MiscGroup:AddButton("Unload Exploit", function()
	Linoria:Unload()
end)

local SelectedPlayers = PlayersGroup:AddDropdown("SelectedPlayers", {
	Text = "Selected Players",
	Multi = true,
	Default = game.Players.LocalPlayer.Name,
	SpecialType = "Player",
})
local function plrAct(func)
	for player, selected in SelectedPlayers.Value do
		if not selected then continue end
		local _plr = plr(player)
		if not _plr then continue end
		func(_plr)
	end
end
PlayersGroup:AddLabel("CAN CAUSE NETWORK LAG")
PlayersGroup:AddLabel("NON-REVERTABLE")
local GenerateXP = PlayersGroup:AddToggle("GenerateXP", {
	Text = "Generate XP - All Roles",
	Default = false
})
local GenerateCredits = PlayersGroup:AddToggle("GenerateCredits", {
	Text = "Generate Credits",
	Default = false
})
local GenerateDataChips = PlayersGroup:AddToggle("GenerateDataChips", {
	Text = "Generate Data Chips",
	Default = false
})
local GenerateDeliveries = PlayersGroup:AddToggle("GenerateDeliveries", {
	Text = "Generate Deliveries [RISKY]",
	Default = false
})
local GenerateActionSpeed = PlayersGroup:AddToggle("GenerateActionSpeed", {
	Text = "Generate Action Speed",
	Default = false
})
local GenerateReloadSpeed = PlayersGroup:AddToggle("GenerateReloadSpeed", {
	Text = "Generate Reload Speed",
	Default = false
})
local GenerateRepairSpeed = PlayersGroup:AddToggle("GenerateRepairSpeed", {
	Text = "Generate Repair Speed",
	Default = false
})
PlayersGroup:AddButton("Disable All", function()
	GenerateXP:SetValue(false)
	GenerateCredits:SetValue(false)
	GenerateDataChips:SetValue(false)
	GenerateDeliveries:SetValue(false)
	GenerateActionSpeed:SetValue(false)
	GenerateReloadSpeed:SetValue(false)
	GenerateRepairSpeed:SetValue(false)
end)
local DropNum = PlayersGroup:AddInput("DropNum", {
	Default = 100,
	Numeric = true,
	Text = "Negative Drop Amount",
	Placeholder = 100
})
PlayersGroup:AddButton("Drop Negative Cash", function()
	game:GetService("ReplicatedStorage"):WaitForChild("DropMoney"):FireServer(-tonumber(DropNum.Value))
end)

SubmarineGroup:AddLabel("CAN CAUSE NETWORK LAG")
SubmarineGroup:AddLabel("NON-REVERTABLE")
local GenerateReactorFuel = SubmarineGroup:AddToggle("GenerateReactorFuel", {
	Text = "Generate Reactor Fuel",
	Default = false
})
local GenerateMotarAmmo = SubmarineGroup:AddToggle("GenerateMotarAmmo", {
	Text = "Generate Motar Ammo",
	Default = false
})
local GenerateMachineGunAmmo = SubmarineGroup:AddToggle("GenerateMachineGunAmmo", {
	Text = "Generate Gatling Ammo",
	Default = false
})
local GenerateSuitOxygen = SubmarineGroup:AddToggle("GenerateSuitOxygen", {
	Text = "Generate Suit Oxygen",
	Default = false
})
SubmarineGroup:AddButton("Disable All", function()
	GenerateReactorFuel:SetValue(false)
	GenerateMotarAmmo:SetValue(false)
	GenerateMachineGunAmmo:SetValue(false)
	GenerateSuitOxygen:SetValue(false)
end)

MatchGroup:AddLabel("idk yet")

local genRemote = game:GetService("ReplicatedStorage").ExpEvent
task.spawn(function()
	while task.wait() do
		if GenerateReactorFuel.Value then
			genRemote:FireServer(workspace.THE_SUBMARINE.Reactor_Room.Reactor.LeftRodFuel, 10)
			genRemote:FireServer(workspace.THE_SUBMARINE.Reactor_Room.Reactor.RightRodFuel, 10)
		end
		if GenerateMotarAmmo.Value then
			genRemote:FireServer(workspace.THE_SUBMARINE.Control_Room.GunnerSeatSetup.AmmoLeft, 10)
		end
		if GenerateMachineGunAmmo.Value then
			genRemote:FireServer(workspace.THE_SUBMARINE.Control_Room.MachineGunSeatSetup1.AmmoLeft, 10)
			genRemote:FireServer(workspace.THE_SUBMARINE.Control_Room.MachineGunSeatSetup2.AmmoLeft, 10)
		end
		if GenerateSuitOxygen.Value then
			for _, suit in workspace.THE_SUBMARINE.Suit_Room:GetChildren() do
				if suit.Name ~= "SuitLocker" then continue end
				genRemote:FireServer(suit.LeftOxygen, 10)
			end
		end
		if GenerateXP.Value then
			plrAct(function(player)
				local captain = player.Roles.Experience.Captain
				local engineer = player.Roles.Experience.Engineer
				local security = player.Roles.Experience.Security
				genRemote:FireServer(captain, 10)
				genRemote:FireServer(engineer, 10)
				genRemote:FireServer(security, 10)
			end)
		end
		if GenerateCredits.Value then
			plrAct(function(player)
				genRemote:FireServer(player.leaderstats.Credits, 10)
			end)
		end
		if GenerateDataChips.Value then
			plrAct(function(player)
				genRemote:FireServer(player.DataStoreValues.Tokens, 10)
			end)
		end
		if GenerateDeliveries.Value then
			plrAct(function(player)
				genRemote:FireServer(player.DataStoreValues.Deliveries, 10)
			end)
		end
		if GenerateActionSpeed.Value then
			plrAct(function(player)
				genRemote:FireServer(player.Buffs.CrewActionSpeed, 10)
			end)
		end
		if GenerateReloadSpeed.Value then
			plrAct(function(player)
				genRemote:FireServer(player.Buffs.ReloadSpeed, 10)
			end)
		end
		if GenerateRepairSpeed.Value then
			plrAct(function(player)
				genRemote:FireServer(player.Buffs.RepairSpeed, 10)
			end)
		end
	end
end)
