local instancia:Part = script.Parent
local spawnLocation = workspace.Area_Inicial.SpawnLocation
local deboucing = {}
local confetes:Folder = script.Parent.confetes

-- Services
local Players = game:GetService("Players")

--local function playerWin(hit)
--	local humano = hit.Parent:FindFirstChild("Humanoid")
--	if humano then
--		humano.Health = 0
--	end
--end

local function playerWin(hit)
	local playerName = hit.Parent.Name
	if deboucing[playerName] then
		return
	end
	
	-- Inicia o deboucing
	deboucing[playerName] = true
	
	local character:Model = hit.Parent
	
	-- Checa se um player tocou na chegada	
	local player = Players:GetPlayerFromCharacter(character)
	if  not player then
		return
	end
	local primaryPart = character.PrimaryPart
	
	-- Incrementa o score do jogador
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local score:IntValue = leaderstats:FindFirstChild("Score")
		score.Value += 1		
	end
	
	-- Cria animação para comemorar o Player Win
	for _,confete in confetes:GetChildren() do
		-- Cria um novo particleemitter
		local particleEmitter = Instance.new("ParticleEmitter")
		
		-- Define cores para as particulas
		local colorKeypoints = {
			-- API: ColorSequenceKeypoint.new(time, color)
			ColorSequenceKeypoint.new( 0, Color3.new(1, 1, 1)),  -- At t=0, White
			ColorSequenceKeypoint.new(.5, Color3.new(1, .5, 0)), -- At t=.5, Orange
			ColorSequenceKeypoint.new( 1, Color3.new(1, 0, 0))   -- At t=1, Red
		}
		-- Associa particleemiiter com a part correspondente
		particleEmitter.Parent = confete
		particleEmitter.Lifetime = NumberRange.new(1,1)
		particleEmitter.Rate = 400
		particleEmitter.Speed = NumberRange.new(10,10)
		particleEmitter.SpreadAngle = Vector2.new(0,45)
		particleEmitter.Color = ColorSequence.new(colorKeypoints)
		
		-- Animação para a duração da emissão das particulas - ativado, desativado, ativado, desativado
		delay(0.5,function()
			particleEmitter.Enabled = false
			wait(0.5)
			particleEmitter.Enabled = true
			wait(0.5)
			particleEmitter.Enabled = false
		end)
		
		-- Destrói os particleemitters 
		delay(4,function()
			particleEmitter:Destroy()
		end)
		
	end
	delay(2,function()
		-- Telporta player para o início novamente
		primaryPart.CFrame = spawnLocation.CFrame * CFrame.new(0,15,0)
	end)
	
	delay(3,function()
		deboucing[playerName] = false
	end)
end

instancia.Touched:Connect(playerWin)
