local instancia = script.Parent

local function CeifaMata(part)
	local humano = part.Parent:FindFirstChild("Humanoid")
	if humano then
		humano.Health = 0
	end
end

instancia.Touched:Connect(CeifaMata)

