-- Services
local DataStore = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Carrega banco de dados
local leaderboardDB = DataStore:GetDataStore("Leaderstats")


local function onPlayerAdded(player: Player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	-- Carrega dados do jogador
	local success, playerData = pcall(function()
		return leaderboardDB:GetAsync(player.UserId)
	end)
	
	if success then
		local score = Instance.new("IntValue")
		score.Name = "Score"
		score.Value = playerData and playerData or 0
		score.Parent = leaderstats
	else
		print("Deu Merda!")
	end
	

end

Players.PlayerAdded:Connect(onPlayerAdded)