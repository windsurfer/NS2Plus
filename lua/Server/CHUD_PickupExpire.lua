local originalWeaponSetWorldState
originalWeaponSetWorldState = Class_ReplaceMethod( "Weapon", "SetWeaponWorldState",
	function(self, state, preventExpiration)
	
		if state ~= self.weaponWorldState then
		
			if state then
				self.expireTime = ConditionalValue(preventExpiration, 0, Shared.GetTime() + kItemStayTime)
			end
			
		end
		
		originalWeaponSetWorldState(self, state, preventExpiration)
	
	end)
	
local commDrops = { "ammopack", "medpack", "catpack" }
local originalDropPackOnInit
originalDropPackOnInit = Class_ReplaceMethod( "DropPack", "OnInitialized",
	function(self)
	
		originalDropPackOnInit(self)
		
		self.expireTime = Shared.GetTime() + kItemStayTime
		
		local mapName = self:GetMapName()
		
		if table.contains(commDrops, mapName) then
			CHUDCommStats[CHUDMarineComm][mapName].misses = CHUDCommStats[CHUDMarineComm][mapName].misses + 1
		end
	
	end)