local instancia = script.Parent

local function killPlayer(part)
	local humano = part.Parent:FindFirstChild("Humanoid")
	if humano then
		humano.Health = 0
	end
end

instancia.Touched:Connect(killPlayer)

