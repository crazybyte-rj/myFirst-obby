local objeto = script.Parent

while(true) do
	for i=0,48,1 do
		objeto.Position = objeto.Position + Vector3.new(1,0,0)
		wait(0.05)
	end
	for i=0,48,1 do
		objeto.Position = objeto.Position - Vector3.new(1,0,0)
		wait(0.05)
	end	
end
