local profile = {};
alias = gFunc.LoadFile('alias.lua');
local sets = {
    ['charm_Priority'] = {
        Head = 'Noble\'s Ribbon',
        Neck = 'Bird Whistle',
		Body = 'Custom Vest',
        Ring1 = 'Hope Ring',
        Ring2 = 'Hope Ring',
		Legs = 'Custom Pants',
        Waist = {'Corsette +1','Mrc.Cpt. Belt'},
		Back = 'Lucent Cape',
    },
    ['damage_Priority'] = {
        Ammo = 'Morion Tathlum',
        Head = 'Emperor Hairpin',
        Neck = 'Spike Necklace',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Mrc.Cpt. Doublet',
        Hands = 'Battle Gloves',
        Ring1 = {'Woodsman Ring','Puissance Ring','Courage Ring'},
        Ring2 = {'Woodsman Ring','Puissance Ring','Courage Ring'},
        Back = {'White Cape +1','Mist Silk Cape'},
        Waist = {'Tilt Belt','Mrc.Cpt. Belt'},
        Legs = 'Mrc.Cpt. Hose',
        Feet = {'Mountain Gaiters','Mrc.Cpt. Gaiters'},
    },
    ['weapon_Priority'] = {
		Main = {'Blessed Hammer','Maul +1'},
		Sub = {'Ryl.Sqr. Shield','Mahogany Shield'},
    },
    ['MND_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		Ammo = 'Holy Ampulla',
		Head = 'Republic Circlet',
        Body = {'Bishop\'s Robe','Baron\'s Saio'},
		Neck = {'Holy Phial','Justice Badge'},
        Ear1 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Ear2 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Hands = {'Devotee\'s Mitts','Zealot\'s Mitts'},
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
        Back = {'White Cape +1','Mist Silk Cape'},
        Waist = {'Reverend sash','Mrc.Cpt. Belt','Friar\'s Rope'},
		Legs = {'Custom Pants'},
        Feet = 'Seer\'s Pumps +1',
    },
    ['INT_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
        Ammo = 'Morion Tathlum',
        Head = 'Seer\'s Crown +1',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = 'Baron\'s Saio',
        Hands = 'Seer\'s Mitts +1',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = 'Black Cape +1',
        Waist = {'Reverend sash','Mrc.Cpt. Belt'},
		Legs = 'Magic Slacks',
        Feet = {'Custom F Boots','Seer\'s Pumps +1'},
    },
    ['rest_Priority'] = {
        Main = {'Blessed Hammer','Pilgrim\'s Wand'},
        Body = 'Seer\'s Tunic',
        Legs = 'Baron\'s Slops',
		Back = 'Wizard\'s Mantle',
		Waist = 'Reverend sash',
    },
    ['idle_Priority'] = {
        Ammo = 'Morion Tathlum',
        Head = 'Mrc.Cpt. Headgear',
        Neck = {'Spirit Torque','Justice Badge'},
        Ear1 = 'Dodge Earring',
        Ear2 = 'Dodge Earring',
        Body = 'Mrc.Cpt. Doublet',
        Hands = 'Mrc.Cpt. Gloves',
        Ring1 = {'Verve Ring +1','Stamina Ring +1'},
        Ring2 = {'Verve Ring +1','Stamina Ring +1'},
        Back = 'White Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Mrc.Cpt. Hose',
        Feet = 'Light Soleas',
    },
    ['idlemp_Priority'] = {
        Ammo = 'Holy Ampulla', --5
		Head = 'Electrum Hairpin', --25
		Neck = 'Holy Phial', --9
        Ear1 = {'Geist Earring','Morion Earring','Energy Earring +1'}, --5
        Ear2 = {'Geist Earring','Morion Earring','Energy Earring +1'}, --5
        Body = 'Seer\'s Tunic', --8
        Hands = {'Devotee\'s Mitts','Zealot\'s Mitts'}, --8
        Ring1 = 'Astral Ring', --25
        Ring2 = 'Astral Ring', --25
        Waist = 'Friar\'s Rope', --4
		Legs = {'Custom Pants'}, --32
        Feet = 'Seer\'s Pumps +1', --5
									--92 mp
    },
    ['SIRD_Priority'] = {
        Main = 'Hermit\'s Wand',
        Neck = 'Willpower Torque',
        Waist = 'Heko Obi +1',
		Feet = 'Mountain Gaiters',
    },
    ['ws'] = {
        Head = 'Mrc.Cpt. Headgear',
		Ammo = 'Holy Ampulla',
        Neck = 'Holy Phial',
        Ear1 = 'Beetle Earring +1',
        Ear2 = 'Beetle Earring +1',
        Body = 'Bishop\'s Robe',
        Hands = 'Custom F Gloves',
        Ring1 = 'Puissance Ring',
        Ring2 = 'Puissance Ring',
        Back = 'White Cape +1',
        Waist = 'Mrc.Cpt. Belt',
        Legs = 'Custom Pants',
        Feet = 'Seer\'s Pumps +1',
    },
};
profile.Sets = sets;

local Settings = {
    CurrentLevel = 0,
	MeleeVariant = 1,
	MaxMP = false;
	Melee = false;
};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	alias.OnLoad();
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /whm /lac fwd');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd MaxMP');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F2 /lac fwd Melee');
end

profile.OnUnload = function()
	alias.OnUnLoad();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /whm');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F2');
end

profile.HandleCommand = function(args)
	if (args[1] == 'Melee') then
        if (Settings.Melee == true) then
            Settings.Melee = false;
			gFunc.Message('Regular');
        else
            Settings.Melee = true;
			gFunc.Message('Melee Lock');
        end
	end
	if (args[1] == 'MaxMP') then
        if (Settings.MaxMP == true) then
            Settings.MaxMP = false;
			gFunc.Message('Regular Idle');
        else
            Settings.MaxMP = true;
			gFunc.Message('MaxMP Idle Lock');
        end
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
		gFunc.EquipSet(sets.damage);
		gFunc.EquipSet(sets.weapon);
	end
	if (player.Status == 'Resting') then
		gFunc.EquipSet(sets.rest);
		if (Settings.MaxMP == true) then
		gFunc.EquipSet(sets.idlemp);
		end
		if (Settings.Melee == true) then
		gFunc.EquipSet(sets.weapon);
		end	
	end
	if (player.Status == 'Idle') then
		gFunc.EquipSet(sets.idle);
		if (Settings.MaxMP == true) then
		gFunc.EquipSet(sets.idlemp);
		end
		if (Settings.Melee == true) then
		gFunc.EquipSet(sets.weapon);
		end	
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
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()

end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
	local target = gData.GetActionTarget();
    local MndDebuffs = T{ 'Slow', 'Paralyze', 'Silence'};
    local ElementalDebuffs = T{ 'Burn', 'Rasp', 'Drown', 'Choke', 'Frost', 'Shock' };
    local action = gData.GetAction();
	local sig = gData.GetBuffCount(matchBuff);
	local weatherzone = gData.GetEnvironment()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
    
	local fastCastValue = 0.05;
    local minimumBuffer = 0.1;
    local packetDelay = 0.25;
    local castDelay = ((action.CastTime * (1 - fastCastValue)) / 1000) - minimumBuffer;
	if (castDelay >= packetDelay) then
        gFunc.SetMidDelay(castDelay)
    end
	
	if (Settings.Melee == true) then

	else
	gFunc.InterimEquipSet(sets.SIRD);
	end
	
	if (action.Skill == 'Enfeebling Magic') then
		if (MndDebuffs:contains(action.Name)) then
			gFunc.EquipSet(sets.MND);
		else
			gFunc.EquipSet(sets.INT);
		end
    elseif string.contains(action.Name, 'Cure') or string.contains(action.Name, 'Curaga') then
        gFunc.EquipSet(sets.MND);
    elseif string.match(action.Name, 'Stoneskin') then
        gFunc.EquipSet(sets.MND);	
	end
	--Gear Lock Max MP	
	if (Settings.MaxMP == true) then
	gFunc.EquipSet(sets.idlemp);
	end	
	
	--Gear Lock
	if (Settings.Melee == true) then
			gFunc.Equip('Main','');
			gFunc.Equip('Sub','');
			--gFunc.Equip('Range','');
			--gFunc.Equip('Ammo','');
	end	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
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