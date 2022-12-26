-- Services
local DataStore = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Carrega banco de dados
local leaderboardDB = DataStore:GetDataStore("Leaderstats")

local function onPlayerRemoving(player: Player)
	local score:IntValue = 0
	-- Localiza pontuação atual no leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		score = leaderstats:FindFirstChild("Score")		
	end
	-- Salva a pontuação atual
	local success, message = pcall(function()
		leaderboardDB:SetAsync(player.UserId,score.Value)
	end)
	if success then
		print("Dados salvos com sucesso!")
	else
		print("Erro ao salvar os dados!")
		print(message)
	end
end

-- listeners
Players.PlayerRemoving:Connect(onPlayerRemoving)
