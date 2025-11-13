local profile = {};
local sets = {
    ['racc'] = {
        Head = 'Ryl.Ftm. Bandana',
        Neck = 'Wing Pendant',
        Ring1 = 'Reflex Ring',
        Ring2 = 'Reflex Ring',
        Feet = 'Leaping Boots',
    },
    ['charm'] = {
        Head = 'Noble\'s Ribbon',
        Neck = 'Bird Whistle',
        Ring1 = 'Hope Ring',
        Ring2 = 'Hope Ring',
    },
    ['melee'] = {
        Head = 'Erd. Headband',
        Neck = 'Wing Pendant',
        Ear1 = 'Energy Earring +1',
        Ear2 = 'Energy Earring +1',
        Body = 'Power Gi',
        Hands = 'Kingdom Gloves',
        Ring1 = 'Stamina Ring +1',
        Ring2 = 'Stamina Ring +1',
        Back = 'Traveler\'s Mantle',
        Waist = 'Warrior\'s Belt +1',
        Legs = 'Angler\'s Hose',
        Feet = 'Leaping Boots',
    },
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    CurrentLevel = 0,
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	local zone = gData.GetEnvironment()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.melee);
	end
end

profile.HandleAbility = function()
	local action = gData.GetAction();	
	local player = gData.GetPlayer();
	if (player.action == 'Charm') then
        gFunc.EquipSet(sets.charm);
	end		
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
	gFunc.EquipSet(sets.racc);
end

profile.HandleWeaponskill = function()
	gFunc.EquipSet(sets.ws);
end

return profile;