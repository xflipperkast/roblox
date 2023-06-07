-- Services
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- DataStore
local myDataStore = DataStoreService:GetDataStore("MyDataStore")

-- Functions
local function onPlayerJoin(player)
	-- Set up leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	-- Set up coins stat
	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Parent = leaderstats

	-- Set up gems stat
	local gems = Instance.new("IntValue")
	gems.Name = "Gems"
	gems.Parent = leaderstats

	-- Fetch and load data from the datastore
	local userId = tostring(player.UserId)
	local savedData = myDataStore:GetAsync(userId)

	if savedData then
		coins.Value = savedData.coins
		gems.Value = savedData.gems
	else
		coins.Value = 100
		gems.Value = 10
	end
end


local function onPlayerLeave(player)
	local userId = tostring(player.UserId)

	local dataToSave = {
		coins = player.leaderstats.Coins.Value,
		gems = player.leaderstats.Gems.Value
	}

	local success, err = pcall(function()
		myDataStore:SetAsync(userId, dataToSave)
	end)

	if success then
		print("Data saved successfully")
	else
		warn("Failed to save data with error: ", err)
	end
end


-- Events
Players.PlayerAdded:Connect(onPlayerJoin)
Players.PlayerRemoving:Connect(onPlayerLeave)
