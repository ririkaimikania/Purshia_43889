local profile = {};
alias = gFunc.LoadFile('alias.lua');
conquest = gFunc.LoadFile('lua_conquest_v2.lua');
--Table for Elemental Staves
local ElementalStaffTable = {
	['Fire'] = 'Vulcan\'s Staff',
	['Ice'] = 'Aquilo\'s Staff',
	['Wind'] = 'Auster\'s Staff',
	['Earth'] = 'Terra\'s Staff',
	['Thunder'] = 'Jupiter\'s Staff',
	--['Water'] = 'Neptune\'s Staff',
	['Light'] = 'Apollo\'s Staff',
	['Dark'] = 'Pluto\'s Staff'
};
--
--Table to check Day Element
local DayElementTable = {
    ['Firesday'] = 'Fire',
    ['Earthsday'] = 'Earth',
    ['Watersday'] = 'Water',
    ['Windsday'] = 'Wind',
    ['Iceday'] = 'Ice',
    ['Lightningday'] = 'Thunder',
    ['Lightsday'] = 'Light',
    ['Darksday'] = 'Dark'
};

--Table for Elemental Obi, remove comment if Obi is obtained
local ObiTable = {
    --['Fire'] = 'Karin Obi',
    --['Earth'] = 'Dorin Obi',
    --['Water'] = 'Suirin Obi',
    --['Wind'] = 'Furin Obi',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    --['Light'] = 'Korin Obi',
    --['Dark'] = 'Anrin Obi'
};

--Check for Obi that exist and swap if element and day/weather matches
function ObiCheck(spell)
    local element = spell.Element
    local zone = gData.GetEnvironment()
    
    local badEle = {
        ['Fire'] = 'Water',
        ['Earth'] = 'Wind',
        ['Water'] = 'Thunder',
        ['Wind'] = 'Ice',
        ['Ice'] = 'Fire',
        ['Thunder'] = 'Earth',
        ['Light'] = 'Dark',
        ['Dark'] = 'Light'
    };
    
    local weight = 0
    
    --Day comparison
    if (DayElementTable[zone.Day] == element) then
        weight = weight + 1
    elseif (DayElementTable[zone.Day] == badEle[element]) then
        weight = weight - 1
    end
    
    --Weather comparison
    if string.find(zone.Weather, element) then
        if string.find(zone.Weather, 'x2') then
            weight = weight + 2
        else
            weight = weight + 1
        end
    elseif string.find(zone.Weather, badEle[element]) then
        if string.find(zone.Weather, 'x2') then
            weight = weight - 2
        else
            weight = weight - 1
        end
    end    
    
    return weight
end

local sets = {
    ['MND_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		--Ammo = 'Holy Ampulla',
		Head = 'Republic Circlet',
        Body = {'Errant Hpl.','Wizard\'s Coat','Bishop\'s Robe','Baron\'s Saio'},
		Neck = {'Promise Badge','Holy Phial','Justice Badge'},
        Ear1 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Ear2 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Hands = {'Devotee\'s Mitts','Zealot\'s Mitts'},
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
        Back = {'White Cape +1','Mist Silk Cape'},
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt','Friar\'s Rope'},
		Legs = {'Errant Slops','Custom Pants'},
        Feet = {'Errant Pigaches','Seer\'s Pumps +1'},
    },
    ['INT_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		Sub = {'Yew Wand +1'},
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        Head = {'Wizard\'s Petasos','Baron\'s Chapeau','Seer\'s Crown +1'},
		Neck = 'Checkered Scarf',
        Ear1 = 'Morion Earring',
        Ear2 = 'Morion Earring',
        Body = {'Wizard\'s Coat','Baron\'s Saio'},
        Hands = {'Wizard\'s Gloves','Seer\'s Mitts +1','Angler\'s Gloves'},
        Ring1 = {'Snow Ring','Eremite\'s Ring +1'},
        Ring2 = {'Snow Ring','Eremite\'s Ring +1'},
        Back = 'Black Cape +1',
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt'},
		Legs = {'Errant Slops'},
        Feet = {'Custom F Boots','Seer\'s Pumps +1'},
    },
    ['Nuke_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		--Sub = {'Yew Wand +1'},
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        Head = {'Wizard\'s Petasos','Baron\'s Chapeau','Seer\'s Crown +1'},
		Neck = 'Elemental Torque',
        Ear2 = {'Abyssal Earring','Morion Earring'},
        Ear1 = 'Novio Earring',
        Body = {'Igqira Weskit','Baron\'s Saio'},
        Hands = {'Zenith Mitts','Igqira manillas','Wizard\'s Gloves','Seer\'s Mitts +1','Angler\'s Gloves'},
        Ring1 = {'Snow Ring','Eremite\'s Ring +1'},
        Ring2 = {'Snow Ring','Eremite\'s Ring +1'},
        Back = {'Prism Cape','Black Cape +1'},
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt'},
		Legs = {'Errant Slops'},
        Feet = {'Custom F Boots','Seer\'s Pumps +1'},
    },
    ['SorcRing_Priority'] = {
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        Head = 'Wizard\'s Petasos',
		Neck = 'Elemental Torque',
        Ear1 = 'Abyssal Earring',
        Ear2 = 'Novio Earring',
        Body = 'Igqira Weskit',
        Hands = {'Zenith Mitts','Igqira manillas'},
        Ring1 = 'Sorcerer\'s Ring',
        Ring2 = 'Snow Ring',
        Back = 'Prism Cape',
        Waist = 'Penitent\'s Rope',
		Legs = 'Errant Slops',
        Feet = 'Custom F Boots',
    },
    ['Enf_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		Sub = {'Yew Wand +1'},
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        Head = {'Genie Tiara','Wizard\'s Petasos','Baron\'s Chapeau','Seer\'s Crown +1'},
		Neck = {'Enfeebling Torque','Black Neckerchief'},
        Ear1 = {'Abyssal Earring','Morion Earring'},
        Ear2 = 'Morion Earring',
        Body = {'Wizard\'s Coat','Baron\'s Saio'},
        Hands = {'Errant Cuffs','Seer\'s Mitts +1','Angler\'s Gloves'},
        Ring1 = {'Snow Ring','Eremite\'s Ring +1'},
        Ring2 = {'Snow Ring','Eremite\'s Ring +1'},
        Back = {'Prism Cape','Black Cape +1'},
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt'},
		Legs = 'Igqira Lappas',
        Feet = {'Custom F Boots','Seer\'s Pumps +1'},
    },
    ['Enmity_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		Ammo = 'Holy Ampulla',
		Head = {'Raven Beret','Republic Circlet'},
        Body = {'Wizard\'s Coat','Bishop\'s Robe','Baron\'s Saio'},
		Neck = {'Promise Badge','Holy Phial','Justice Badge'},
        Ear1 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Ear2 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Hands = {'Raven Bracers','Devotee\'s Mitts','Zealot\'s Mitts'},
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
        Back = {'White Cape +1','Mist Silk Cape'},
        Waist = {'Reverend sash','Mrc.Cpt. Belt','Friar\'s Rope'},
		Legs = {'Raven Hose','Custom Pants'},
        Feet = {'Crow Gaiters','Seer\'s Pumps +1'},
    },
    ['rest_Priority'] = {
        Main = {'Pluto\'s Staff','Pilgrim\'s Wand'},
        Body = {'Errant Hpl.','Vermillion Cloak','Seer\'s Tunic'},
        Legs = 'Baron\'s Slops',
		Waist = {'Hierarch Belt','Reverend sash'},
		Neck = 'Checkered Scarf',
		Ear1 = 'Relaxing Earring',
		Ear2 = 'Magnetic Earring',
		Head = 'Genie Tiara',
    },
    ['idle_Priority'] = {
		Main = 'Terra\'s Staff',
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        --Head = {'Emperor Hairpin'},
        Neck = {'Jeweled Collar','Justice Badge'},
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = {'Vermillion cloak'},
        Hands = {'Merman\'s bangles','Seer\'s Mitts +1'},
        Ring1 = {'Sattva Ring'},
        Ring2 = {'Merman\'s Ring'},
        Back = 'Hexerei Cape',
        Waist = 'Mrc.Cpt. Belt',
        Legs = {'Custom Pants'},
        Feet = {'Custom F Boots'},
    },
    ['SIRD_Priority'] = {
        Main = 'Hermit\'s Wand',
		Sub = {'Genbu\'s Shield','Hermit\'s Wand'},
        Neck = 'Willpower Torque',
        Waist = 'Heko Obi +1',
		Feet = {'Wizard\'s Sabots','Mountain Gaiters'},
		Ear2 = 'Magnetic Earring',
        Ear1 = 'Merman\'s Earring',
        Body = {'Vermillion cloak'},
        Hands = {'Merman\'s bangles','Seer\'s Mitts +1'},
        Ring1 = {'Sattva Ring'},
        Ring2 = {'Merman\'s Ring'},
        Back = 'Hexerei Cape',
        Legs = {'Igqira Lappas'},
    },
    ['SIRDnoweap_Priority'] = {
        --Main = 'Hermit\'s Wand',
        Neck = 'Willpower Torque',
        Waist = 'Heko Obi +1',
		Feet = {'Wizard\'s Sabots','Mountain Gaiters'},
		Ear2 = 'Magnetic Earring',
    },
    ['ws_Priority'] = {
        Head = 'Mrc.Cpt. Headgear',
		Ammo = 'Holy Ampulla',
        Neck = {'Promise Badge','Holy Phial'},
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
    ['maxhp'] = {
        Neck = 'Bird Whistle',
        Body = 'Custom Vest',
        Hands = 'Custom F Gloves',
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
    },
    ['reward_Priority'] = {
		Ammo = {'Pet Food Delta','Pet Fd. Gamma'},
    },
    ['Dark_Priority'] = {
        Legs = 'Wizard\'s Tonban',
		Neck = 'Dark Torque',
		Ear2 = 'Abyssal Earring',
		Ear1 = 'Loquac. Earring',
		Legs = 'Nashira Seraweels',
		Feet = 'Igqira Huaraches',
		Hands = 'Sorcerer\'s Gloves',
    },	
    ['Enh_Priority'] = {
		Neck = 'Enhancing Torque',
		Feet = 'Igqira Huaraches',
    },
    ['Fast_Priority'] = {
        --Back = 'Warlock\'s Mantle', #in code
		Ear1 = 'Loquac. Earring',
    },	
};
profile.Sets = sets;

local Settings = {
    CurrentLevel = 0,
	MeleeVariant = 1,
	Staticidle = false;
	Melee = false;
};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	alias.OnLoad();
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /blm /lac fwd');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd Staticidle');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F2 /lac fwd Melee');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @1 /ma "sleepga II" <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @2 /ma "sleepga" <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @3 /ma "sleep II" <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind @4 /ma "sleep" <t>');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind o /item "Timeless Hrglass." <t>');
end

profile.OnUnload = function()
	alias.OnUnLoad();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /blm');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F2');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @1');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @2');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @3');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @4');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind o');
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
	if (args[1] == 'Staticidle') then
        if (Settings.Staticidle == true) then
            Settings.Staticidle = false;
			gFunc.Message('Dynamic Idle');
        else
            Settings.Staticidle = true;
			gFunc.Message('Static Idle Lock');
        end
	end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer();
	local zone = gData.GetEnvironment()
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	--local town = T{'Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods', 'Heavens Tower', 'Bastok Markets', 'Bastok Mines', 'Port Bastok', 'Metalworks', 'Port Jeuno', 'Lower Jeuno', 'Upper Jeuno', 'Ru\'Lude Gardens', 'Port San d\'Oria', 'Northern San d\'Oria','Southern San d\'Oria','Chateau d\'Oraguille'};
	local town = T{'Port Windurst','Windurst Walls','Windurst Waters','Windurst Woods', 'Heavens Tower'};
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	local modmp = 0;
	if (player.SubJob == 'RDM') then	
		modmp = 0;
	elseif (player.SubJob == 'WHM') then
		modmp = 20;
	else
		modmp = 100;
	end
	local totalmp = 758 - modmp;
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.damage);
		gFunc.EquipSet(sets.weapon);
	end
	if (player.Status == 'Resting') then
		gFunc.EquipSet(sets.rest);
		if (Settings.Melee == true) then
		gFunc.EquipSet(sets.weapon);
		end
		if (Settings.Staticidle == false) then
			if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
			if (player.MP > (totalmp + 50 - 75)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
			if (player.MP > (totalmp + 98 - 75)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
			if (player.MP > (totalmp + 118 - 75)) then gFunc.Equip('Back','Blue Cape +1'); end --40
			if (player.MP > (totalmp + 158 - 75)) then gFunc.Equip('Feet','Wizard\'s Sabots'); end --20
			if (player.MP > (totalmp + 178 - 100)) then gFunc.Equip('Ring2','Ether Ring'); end --30
			if (player.MP > (totalmp + 208 - 100)) then gFunc.Equip('Ammo','Phtm. Tathlum'); end --10
			if (player.MP > (totalmp + 218 - 125)) then gFunc.Equip('Legs','Custom Pants'); end --32
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
				if (player.MP > (totalmp + 250 - 125)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
			else
				if (player.MP > (totalmp + 250 - 125)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
			end
			if (player.MP > (totalmp + 270 - 125)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 290 - 125)) then gFunc.Equip('Body','Flora Cotehardie'); end --30
			if (player.MP > (totalmp + 290 - 150)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
		end
	end
	if (player.Status == 'Idle') then
		gFunc.EquipSet(sets.idle);
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', 'Terra\'s staff');
			end
		if (Settings.Melee == true) then
		gFunc.EquipSet(sets.weapon);
		end	
		if (Settings.Staticidle == false) then
			if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
			if (player.MP > (totalmp + 50)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
			if (player.MP > (totalmp + 98)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
			if (player.MP > (totalmp + 118)) then gFunc.Equip('Back','Blue Cape +1'); end --40
			if (player.MP > (totalmp + 158)) then gFunc.Equip('Feet','Wizard\'s Sabots'); end --20
			if (player.MP > (totalmp + 178)) then gFunc.Equip('Ring2','Ether Ring'); end --30
			if (player.MP > (totalmp + 208)) then gFunc.Equip('Ammo','Phtm. Tathlum'); end --10
			if (player.MP > (totalmp + 218)) then gFunc.Equip('Legs','Custom Pants'); end --32
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
				if (player.MP > (totalmp + 250 - 75)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
			else
				if (player.MP > (totalmp + 250 - 75)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
			end
			if (player.MP > (totalmp + 270)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 290)) then gFunc.Equip('Body','Flora Cotehardie'); end --30
			if (player.MP > (totalmp + 290)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
		end
	end
	if string.contains(zone.Area, 'Dynamis') then
		elseif (town:contains(zone.Area)) then
			gFunc.Equip('Body','Federation Aketon');
	end
	gFunc.LockStyle(sets.idle)
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
		if (player.MainJobSync >= 51) then
			gFunc.Equip('main', 'Apollo\'s Staff');
		end
	elseif (action.Name == 'Reward') then
        gFunc.EquipSet(sets.MND);
		gFunc.EquipSet(sets.reward);
	end
	--Gear Lock
	if (Settings.Melee == true) then
			gFunc.Equip('Main','');
			gFunc.Equip('Sub','');
			--gFunc.Equip('Range','');
			--gFunc.Equip('Ammo','');
	end	
	
end

profile.HandleItem = function()
 local action = gData.GetAction();
	if (action.Name == 'Silent Oil') then
		gFunc.Equip('back','Skulker\'s Cape');
		gFunc.Equip('feet','Dream Boots +1');
	elseif (action.Name == 'Prism Powder') then
		gFunc.Equip('back','Skulker\'s Cape');
		gFunc.Equip('hands','Dream mittens +1');
	end	
end

profile.HandlePrecast = function()
	local player = gData.GetPlayer();
	local modmp = 0;
	if (player.SubJob == 'RDM') then	
		modmp = 0;
	elseif (player.SubJob == 'WHM') then
		modmp = 0;
	else
		modmp = 100;
	end
	local totalmp = 758 - modmp;
	gFunc.EquipSet(sets.Fast);
	if (player.MainJobSync >= 30) and (player.SubJob == 'RDM') then
		gFunc.Equip('back','Warlock\'s Mantle');
	end
	local action = gData.GetAction();
    local fastCastValue = 0.22;
    local minimumBuffer = 0.1;
    local packetDelay = 0.25;
    local castDelay = ((action.CastTime * (1 - fastCastValue)) / 1000) - minimumBuffer;
	if (castDelay >= packetDelay) then
        gFunc.SetMidDelay(castDelay)
    end
	if (player.MP > (totalmp + 118)) then gFunc.InterimEquip('Back','Blue Cape +1'); end --40
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
	local modmp = 0;
	if (player.SubJob == 'RDM') then	
		modmp = 0;
	elseif (player.SubJob == 'WHM') then
		modmp = 0;
	else
		modmp = 100;
	end
	local totalmp = 758 - modmp;
	if (Settings.MaxMP == true) then
	gFunc.EquipSet(sets.idlemp);
	else
	gFunc.InterimEquipSet(sets.SIRD);
		if (player.MP > (totalmp + 0)) then gFunc.InterimEquip('Hands','Zenith Mitts'); end --20
		if (player.MP > (totalmp + 50)) then gFunc.InterimEquip('Waist','Hierarch Belt'); end --48
		if (player.MP > (totalmp + 98)) then gFunc.InterimEquip('Ear2','Magnetic Earring'); end --20
		if (player.MP > (totalmp + 118)) then gFunc.InterimEquip('Back','Blue Cape +1'); end --40
		if (player.MP > (totalmp + 158)) then gFunc.InterimEquip('Feet','Wizard\'s Sabots'); end --20
		if (player.MP > (totalmp + 178)) then gFunc.InterimEquip('Ring2','Ether Ring'); end --30
		if (player.MP > (totalmp + 208)) then gFunc.InterimEquip('Ammo','Phtm. Tathlum'); end --10
		if (player.MP > (totalmp + 218)) then gFunc.InterimEquip('Legs','Custom Pants'); end --32
		if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
			if (player.MP > (totalmp + 250 - 75)) then gFunc.InterimEquip('Neck','Rep.Gold Medal'); end --50
		else
			if (player.MP > (totalmp + 250 - 75)) then gFunc.InterimEquip('Neck','Uggalepih Pendant'); end --20
		end
		if (player.MP > (totalmp + 270)) then gFunc.InterimEquip('Ear1','Loquac. Earring'); end --20
		if (player.MP > (totalmp + 290)) then gFunc.InterimEquip('Body','Flora Cotehardie'); end --30
		if (player.MP > (totalmp + 290)) then gFunc.InterimEquip('Head','Faerie Hairpin'); end --55
	end
	
	if (action.Skill == 'Enfeebling Magic') then
		if (MndDebuffs:contains(action.Name)) then
			gFunc.EquipSet(sets.MND);
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
			end
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) and (player.MainJobSync >= 65)then
			gFunc.Equip('Hands','Mst.Cst. Bracelets');
			end
		else
			gFunc.EquipSet(sets.Enf);
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
			end
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) and (player.MainJobSync >= 65)then
			gFunc.Equip('Hands','Mst.Cst. Bracelets');
			end
		end
    elseif string.contains(action.Name, 'Cure') or string.contains(action.Name, 'Curaga') then
        gFunc.EquipSet(sets.Enmity);
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
			end
	elseif (action.Skill == 'Elemental Magic') then
		if (player.HP <= 730 ) then
		gFunc.EquipSet(sets.SorcRing);
		else
		gFunc.EquipSet(sets.Nuke);
		end
		if not (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
			gFunc.Equip('Head','Republic Circlet')
		end
		if (action.MppAftercast <= 50 ) and (player.MainJobSync >= 70) then
		gFunc.Equip('Neck','Uggalepih Pendant')
		end
		if (player.MainJobSync >= 51) then
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
		end
		if (player.MainJobSync >= 71) and (ObiCheck(action) >= 1) then
			gFunc.Equip('waist', ObiTable[action.Element])
		end
    elseif string.match(action.Name, 'Stoneskin') then
        gFunc.EquipSet(sets.MND);
		gFunc.Equip('Main','Rose Wand +1');
	elseif (action.Skill == 'Enhancing Magic') then
			gFunc.EquipSet(sets.Enh);
			if (action.Name == 'Sneak') and (target.Name == 'Purshia') then
				--gFunc.EquipSet(sets.Haste);
				gFunc.Equip('back','Skulker\'s Cape');
				gFunc.Equip('feet','Dream Boots +1');
			elseif (action.Name == 'Invisible') and (target.Name == 'Purshia') then
				--gFunc.EquipSet(sets.Haste);
				gFunc.Equip('back','Skulker\'s Cape');
				gFunc.Equip('hands','Dream mittens +1');
			end		
	elseif (action.Skill == 'Dark Magic') then
	gFunc.EquipSet(sets.Dark);
	--if not (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
	--gFunc.Equip('Head','Republic Circlet')
	--end
		if string.contains(weatherzone.Weather, "Dark") and (player.MainJobSync >= 75) and (string.match(action.Name, 'Aspir') or string.match(action.Name, 'Drain')) then
			gFunc.Equip('Main','Diabolos\'s pole');
		elseif (player.MainJobSync >= 51) then
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
		end
	else
        --gFunc.EquipSet(sets.Haste);
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
		if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
		if (ObiCheck(action) < 0 ) then
			if (player.MP > (totalmp + 50)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
		end
		if (player.MP > (totalmp + 98)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
		if (player.MP > (totalmp + 118)) then gFunc.Equip('Back','Blue Cape +1'); end --40
		if (player.MP > (totalmp + 158)) then gFunc.Equip('Feet','Wizard\'s Sabots'); end --20
		if (player.HP > 737 ) and not (action.Skill == 'Elemental Magic') then
			if (player.MP > (totalmp + 178)) then gFunc.Equip('Ring2','Ether Ring'); end --30
		end
		if (player.MP > (totalmp + 208)) then gFunc.Equip('Ammo','Phtm. Tathlum'); end --10
		if (player.MP > (totalmp + 218)) then gFunc.Equip('Legs','Custom Pants'); end --32
		if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
			if (player.MP > (totalmp + 250 - 75)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
		else
			if (player.MP > (totalmp + 250 - 75)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
		end
		if (player.MP > (totalmp + 270)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
		if (player.MP > (totalmp + 290)) then gFunc.Equip('Body','Flora Cotehardie'); end --30
		if (player.MP > (totalmp + 290)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
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