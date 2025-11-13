local profile = {};
alias = gFunc.LoadFile('alias.lua');
local sets = {
    ['charm'] = {
        Head = 'Noble\'s Ribbon',
        Neck = 'Bird Whistle',
        Ring1 = 'Hope Ring',
        Ring2 = 'Hope Ring',
        Waist = 'Mrc.Cpt. Belt',
    },
    ['damage'] = {
        Ammo = 'Morion Tathlum',
        Head = 'Emperor Hairpin',
        Neck = 'Spike Necklace',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Mrc.Cpt. Doublet',
        Hands = 'Battle Gloves',
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = 'Mist Silk Cape',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Mrc.Cpt. Hose',
        Feet = 'Mrc.Cpt. Gaiters',
    },
    ['mnd'] = {
        Main = 'Solid Wand',
        Body = 'Baron\'s Saio',
        Hands = 'Zealot\'s Mitts',
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
        Back = 'White Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Feet = 'Seer\'s Pumps +1',
    },
    ['int'] = {
        Main = 'Solid Wand',
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Baron\'s Saio',
        Hands = 'Seer\'s Mitts +1',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = 'Black Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Feet = 'Seer\'s Pumps +1',
    },
    ['rest'] = {
        Main = 'Pilgrim\'s Wand',
        Body = 'Seer\'s Tunic',
        Legs = 'Baron\'s Slops',
		Back = 'Wizard\'s Mantle',
    },
    ['idle'] = {
        Ammo = 'Morion Tathlum',
        Head = 'Mrc.Cpt. Headgear',
        Neck = 'Justice Badge',
        Ear1 = 'Dodge Earring',
        Ear2 = 'Dodge Earring',
        Body = 'Mrc.Cpt. Doublet',
        Hands = 'Mrc.Cpt. Gloves',
        Ring1 = 'Stamina Ring +1',
        Ring2 = 'Stamina Ring +1',
        Back = 'White Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Mrc.Cpt. Hose',
        Feet = 'Light Soleas',
    },
    ['idlemp'] = {
        Ammo = 'Morion Tathlum',
        Ear1 = 'Energy Earring +1',
        Ear2 = 'Energy Earring +1',
        Body = 'Seer\'s Tunic',
        Hands = 'Zealot\'s Mitts',
        Ring1 = 'Astral Ring',
        Ring2 = 'Astral Ring',
        Waist = 'Friar\'s Rope',
        Feet = 'Seer\'s Pumps +1',
    },
};
profile.Sets = sets;

local Settings = {
    CurrentLevel = 0,
	MeleeVariant = 1,
};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	alias.OnLoad();
end

profile.OnUnload = function()
	alias.OnUnLoad();
end

profile.HandleCommand = function(args)
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
		gFunc.EquipSet(sets.damage);
	end
	if (player.Status == 'Resting') then
		gFunc.EquipSet(sets.rest);
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
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;