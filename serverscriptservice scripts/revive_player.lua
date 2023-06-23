game.Players.PlayerAdded:Connect(function(p)
	
	p.CharacterAdded:Connect(function(c)
		
		c:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
			
			if health <= 1 and not c:FindFirstChild("Revived") then 
				
				local revived = Instance.new("BoolValue", c)
				revived.Name = "Revived"
				
				
				c.Humanoid.MaxHealth = math.huge
				c.Humanoid.Health = math.huge
				
				c.HumanoidRootPart.Anchored = true
				
				
				local proximityPrompt = Instance.new("ProximityPrompt")
				proximityPrompt.HoldDuration = 5
				proximityPrompt.ActionText = "Hold E to Revive"
				proximityPrompt.ObjectText = c.Name .. "'s corpse"
				proximityPrompt.RequiresLineOfSight = false
				proximityPrompt.Parent = c.HumanoidRootPart
				
				game.ReplicatedStorage:WaitForChild("ReviveRE"):FireClient(p, proximityPrompt)
				
				
				proximityPrompt.Triggered:Connect(function(plr)
					
					proximityPrompt.Enabled = false
					proximityPrompt:Destroy()
					
					c.Humanoid.MaxHealth = 100
					c.Humanoid.Health = c.Humanoid.MaxHealth
					c.HumanoidRootPart.Anchored = false
					
					game.ReplicatedStorage:WaitForChild("ReviveRE"):FireClient(p)
				end)
				
				
				wait(20)
				
				if not c:FindFirstChild("Revived") then
					
					c.Humanoid.Health = 0
				end
			end
		end)
	end)
end)
