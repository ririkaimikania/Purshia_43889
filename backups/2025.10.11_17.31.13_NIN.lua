local profile = {};
alias = gFunc.LoadFile('alias.lua');
local sets = {
    ['racc_Priority'] = {
        Head = {'Emperor Hairpin','Ryl.Ftm. Bandana'},
        Neck = 'Wing Pendant',
        Ring1 = {'Beetle Ring +1','Bone Ring +1','Reflex Ring'},
        Ring2 = {'Bowyer Ring','Beetle Ring +1','Bone Ring +1','Reflex Ring'},
		Hands = 'Federation Tekko',
        Feet = 'Leaping Boots',
		Back = 'Nomad\'s Mantle +1',
    },
    ['charm_Priority'] = {
        Head = 'Noble\'s Ribbon',
        Neck = 'Bird Whistle',
        Ring1 = 'Hope Ring',
        Ring2 = 'Hope Ring',
    },
    ['melee_Damage_Priority'] = {
        Head = {'Emperor Hairpin','Erd. Headband'},
        Neck = {'Spike Necklace','Wing Pendant'},
        Ear1 = {'Beetle Earring +1','Bone Earring +1'},
        Ear2 = {'Beetle Earring +1','Bone Earring +1'},
        Body = {'Nanban Kariginu','Power Gi'},
        Hands = 'Kingdom Gloves',
        Ring1 = {'Archer\'s Ring','Courage Ring'},
        Ring2 = {'Archer\'s Ring','Courage Ring'},
        Back = {'Nomad\'s Mantle +1','Traveler\'s Mantle'},
        Waist = {'Warrior\'s Belt +1'},
        Legs = {'Republic Subligar','Angler\'s Hose'},
        Feet = 'Leaping Boots',
    },
    ['melee_Evasion_Priority'] = {
        Head = {'Emperor Hairpin','Republic Cap'},
        Neck = {'Spike Necklace','Wing Pendant'},
        Ear1 = {'Dodge Earring','Silver Earring +1'},
        Ear2 = {'Dodge Earring','Silver Earring +1'},
        Body = {'Federation Gi','Beetle Harness +1','Angler\'s Tunica'},
        Hands = 'Kingdom Gloves',
        Ring1 = 'Reflex Ring',
        Ring2 = 'Reflex Ring',
        Back = {'Nomad\'s Mantle +1','Traveler\'s Mantle'},
        Waist = 'Warrior\'s Belt +1',
        Legs = {'Kingdom Trousers','Beetle Subligar +1','Angler\'s Hose'},
        Feet = 'Leaping Boots',
    },
    ['idle_Priority'] = {
        Head = {'Emperor Hairpin','Republic Cap'},
        Neck = {'Wing Pendant'},
        Ear1 = {'Dodge Earring','Silver Earring +1'},
        Ear2 = {'Dodge Earring','Silver Earring +1'},
        Body = {'Federation Gi','Beetle Harness +1','Angler\'s Tunica'},
        Hands = 'Beetle Mittens +1',
        Ring1 = 'Reflex Ring',
        Ring2 = 'Reflex Ring',
        Back = {'Nomad\'s Mantle +1','Traveler\'s Mantle'},
        Waist = 'Warrior\'s Belt +1',
        Legs = {'Kingdom Trousers','Beetle Subligar +1','Angler\'s Hose'},
        Feet = 'Leaping Boots',
    },
    ['DT_Priority'] = {
        Head = {'Beetle Mask +1','Emperor Hairpin','Republic Cap'},
        Neck = 'Justice Badge',
        Ear1 = {'Dodge Earring','Silver Earring +1'},
        Ear2 = {'Dodge Earring','Silver Earring +1'},
        Body = {'Federation Gi','Beetle Harness +1','Angler\'s Tunica'},
        Hands = {'Beetle Mittens +1','Kingdom Gloves'},
        Ring1 = {'Verve Ring +1','Stamina Ring +1'},
        Ring2 = {'Verve Ring +1','Stamina Ring +1'},
        Back = {'Nomad\'s Mantle +1','Traveler\'s Mantle'},
        Waist = 'Warrior\'s Belt +1',
        Legs = {'Kingdom Trousers','Beetle Subligar +1','Angler\'s Hose'},
        Feet = {'Btl. Leggings +1','Leaping Boots'},
    },
    ['ws_Priority'] = {
		Head = {'Emperor Hairpin'},
		Body = {'Nanban Kariginu','Power Gi'},
		Neck = {'Spike Necklace','Wing Pendant'},
        Hands = 'Kingdom Gloves',
        Ring1 = {'Puissance Ring','Courage Ring'},
        Ring2 = {'Puissance Ring','Courage Ring'},
		Legs = {'Republic Subligar','Angler\'s Hose'},
        Feet = 'Leaping Boots',
    },
    ['enmity_Priority'] = {
		Head = 'Cache-nez',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local MeleeVariantTable = {
    [1] = 'Damage',
    [2] = 'Evasion',
};

local Settings = {
    CurrentLevel = 0,
	MeleeVariant = 1,
};

local utsuBuffs = T{
    [66] = 1,
    [444] = 2,
    [445] = 3,
    [446] = 4,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	alias.OnLoad();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /nin /lac fwd');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd DPS');
end


profile.OnUnload = function()
	alias.OnUnLoad();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /nin');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
end

profile.HandleCommand = function(args)
	if (args[1] == 'DPS') then
    Settings.MeleeVariant = Settings.MeleeVariant + 1;
		if (Settings.MeleeVariant > #MeleeVariantTable) then
        Settings.MeleeVariant = 1;
		end
		gFunc.Message('Melee Set: ' .. MeleeVariantTable[Settings.MeleeVariant]);
	end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	local zone = gData.GetEnvironment()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	local town = T{'Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods', 'Heavens Tower', 'Bastok Markets', 'Bastok Mines', 'Port Bastok', 'Metalworks', 'Port Jeuno', 'Lower Jeuno', 'Upper Jeuno', 'Ru\'Lude Gardens', 'Port San d\'Oria', 'Northern San d\'Oria','Southern San d\'Oria','Chateau d\'Oraguille'};
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	if (player.Status == 'Engaged') then
		if (player.MainJob == 'PLD' or player.MainJob == 'NIN' or player.SubJob == 'NIN' or player.MainJob == 'NIN') then
			local function GetShadowCount()
					for buffId, shadowCount in pairs(utsuBuffs) do
						if (gData.GetBuffCount(buffId) > 0) then
							return shadowCount
						end
					end

					return 0
				end

				if (GetShadowCount() == 0) then
					gFunc.EquipSet(sets.DT);
				else
					gFunc.EquipSet('Melee_' .. MeleeVariantTable[Settings.MeleeVariant]);
				end
		end
	        
	end
	if (player.Status == 'Idle') then
		gFunc.EquipSet(sets.idle);
	end
	if string.contains(zone.Area, 'Dynamis') then
		elseif (town:contains(zone.Area)) then
			gFunc.Equip('Body','Republic Aketon');
	end
end

profile.HandleAbility = function()
	local action = gData.GetAction();	
	local player = gData.GetPlayer();
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	if (action.Name == 'Charm') then
        gFunc.EquipSet(sets.charm);
	end
	if (action.Name == 'Provoke') then
        gFunc.EquipSet(sets.enmity);
	end			
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
	local action = gData.GetAction();	
	local player = gData.GetPlayer();
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	if string.match(action.Name, 'Utsusemi') then
		gFunc.EquipSet(sets.melee_Evasion);
        gFunc.Equip('Neck','Willpower Torque');
	end	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	gFunc.EquipSet(sets.racc);
end

profile.HandleWeaponskill = function()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	gFunc.EquipSet(sets.ws);
end

return profile;