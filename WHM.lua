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
    ['Fire'] = 'Karin Obi',
    --['Earth'] = 'Dorin Obi',
    ['Water'] = 'Suirin Obi',
    ['Wind'] = 'Furin Obi',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    ['Light'] = 'Korin Obi',
    ['Dark'] = 'Anrin Obi'
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
        Ammo = {'Tiphia Sting','Holy Ampulla'},
        Head = {'Optical Hat','Raven Beret','Emperor Hairpin'},
        Neck = {'Prudence Torque','Spike Necklace'},
        Ear1 = {'Brutal Earring','Beetle Earring +1'},
        Ear2 = {'Merman\'s Earring','Beetle Earring +1'},
        Body = {'Aristocrat\'s Coat','Holy Breastplate','Mrc.Cpt. Doublet'},
        Hands = {'Blessed Mitts','Battle Gloves'},
        Ring1 = {'Toreador\'s Ring','Woodsman Ring','Puissance Ring','Courage Ring'},
        Ring2 = {'Toreador\'s Ring','Woodsman Ring','Puissance Ring','Courage Ring'},
        Back = {'Bellicose Mantle','White Cape +1','Mist Silk Cape'},
        Waist = {'Life Belt','Tilt Belt','Mrc.Cpt. Belt'},
        Legs = 'Blessed Trousers',
        Feet = {'Blessed Pumps','Cmb.Cst. Shoes','Mountain Gaiters','Mrc.Cpt. Gaiters'},
    },
    ['weaponnin_Priority'] = {
		Main = {'Darksteel Maul','Blessed Hammer','Maul +1'},
		Sub = {'Prudence Rod'},
		Ammo = 'Virtue Stone',
    },
    ['weapon_Priority'] = {
		Main = {'Darksteel Maul','Blessed Hammer','Maul +1'},
		Sub = {'Genbu\'s Shield','Ryl.Sqr. Shield','Mahogany Shield'},
    },
    ['DebuffMND_Priority'] = {
        Main = {'Kirin\'s Pole','Rose Wand +1','Solid Wand','Yew Wand +1'},
		Ammo = 'Holy Ampulla',
		Head = {'Hlr. Cap +1','Republic Circlet'},
        Body = {'Errant Hpl.','Bishop\'s Robe','Baron\'s Saio'},
		Neck = {'Prudence Torque','Holy Phial','Justice Badge'},
        Ear1 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Ear2 = {'Geist Earring','Morion Earring','Energy Earring +1'},
        Hands = {'Devotee\'s Mitts','Zealot\'s Mitts'},
        Ring1 = 'Saintly Ring +1',
        Ring2 = 'Saintly Ring +1',
        Back = {'Prism Cape','White Cape +1','Mist Silk Cape'},
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt','Friar\'s Rope'},
		Legs = {'Errant Slops','Custom Pants'},
        Feet = {'Errant Pigaches','Seer\'s Pumps +1'},
    },
    ['DebuffINT_Priority'] = {
        Main = {'Kirin\'s Pole','Rose Wand +1','Solid Wand','Yew Wand +1'},
        Ammo = {'Phtm. Tathlum','Morion Tathlum'},
        Head = 'Seer\'s Crown +1',
        Ear1 = {'Abyssal Earring','Morion Earring'},
        Ear2 = 'Morion Earring',
        Body = {'Errant Hpl.','Baron\'s Saio'},
        Hands = {'Errant Cuffs','Seer\'s Mitts +1'},
        Ring1 = {'Snow Ring','Eremite\'s Ring +1'},
        Ring2 = {'Snow Ring','Eremite\'s Ring +1'},
        Back = {'Prism Cape','Black Cape +1'},
        Waist = {'Penitent\'s Rope','Reverend sash','Mrc.Cpt. Belt'},
		Legs = {'Errant Slops','Magic Slacks'},
        Feet = {'Custom F Boots','Seer\'s Pumps +1'},
    },
    ['Enmity_Priority'] = {
        Main = {'Rose Wand +1','Solid Wand','Yew Wand +1'},
		Ammo = 'Holy Ampulla',
		Head = {'Raven Beret','Republic Circlet'},
        Body = {'Raven Jupon','Bishop\'s Robe','Baron\'s Saio'},
		Neck = {'Prudence Torque','Holy Phial','Justice Badge'},
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
        Main = {'Pluto\'s Staff','Blessed Hammer','Pilgrim\'s Wand'},
		Head = 'Hlr. Cap +1',
        Body = {'Hlr. Bliaut +1','Seer\'s Tunic'},
        Legs = 'Baron\'s Slops',
		Back = 'Wizard\'s Mantle',
		Waist = {'Hierarch Belt','Reverend sash'},
		Neck = 'Checkered Scarf',
		Ear1 = 'Relaxing Earring',
		Ear2 = 'Magnetic Earring',
		Feet = 'Hlr. Duckbills +1',
    },
    ['idle_Priority'] = {
		Main = 'Terra\'s Staff',
        Ammo = {'Phtm. Tathlum','Morion Tathlum'}, --10
        Head = {'Raven Beret','Mrc.Cpt. Headgear'},
        Neck = {'Jeweled Collar','Spirit Torque','Justice Badge'},
        Ear1 = {'Merman\'s Earring','Relaxing Earring','Dodge Earring'},
        Ear2 = 'Merman\'s Earring',
        Body = {'Aristocrat\'s Coat','Raven Jupon','Holy Breastplate','Mrc.Cpt. Doublet'}, --18
        Hands = {'Merman\'s bangles','Raven Bracers','Mrc.Cpt. Gloves'},
        Ring1 = {'Sattva Ring','Stamina Ring +1'},
        Ring2 = {'Merman\'s Ring','Verve Ring +1','Stamina Ring +1'},
        Back = 'Hexerei Cape', --8
        Waist = 'Mrc.Cpt. Belt',
        Legs = {'Raven Hose','Mrc.Cpt. Hose'},
        Feet = {'Crow Gaiters','Light Soleas'},
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
		Sub = 'Genbu\'s Shield',
        Neck = 'Willpower Torque',
        Waist = 'Druid\'s Rope',
		Feet = {'Hlr. Duckbills +1','Mountain Gaiters'},
    },
    ['SIRDnoweap_Priority'] = {
        --Main = 'Hermit\'s Wand',
        Neck = 'Willpower Torque',
        Waist = 'Druid\'s Rope',
		Feet = {'Hlr. Duckbills +1','Mountain Gaiters'},
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
    ['fast_Priority'] = {
        --Back = 'Warlock\'s Mantle', #in code
		Ear1 = 'Loquac. Earring',
		Feet = 'Rostrum Pumps',
    },
    ['wsacc_Priority'] = {
        Ammo = {'Tiphia Sting','Holy Ampulla'},
        Head = 'Optical Hat',
        Neck = 'Prudence Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Blessed Bliaut',
        Hands = 'Hlr. Mitts +1',
        Ring1 = {'Toreador\'s Ring','Woodsman Ring'},
		Ring2 = {'Toreador\'s Ring','Woodsman Ring'},
        Back = 'Prism Cape',
        Waist = 'Penitent\'s Rope',
        Legs = 'Blessed Trousers',
        Feet = 'Cleric\'s Duckbills',
    },
    ['Enf'] = {
        Head = 'Elite Beret',
        Neck = 'Enfeebling Torque',
        Body = 'Hlr. Bliaut +1',
        Back = 'Altruistic Cape',
        Legs = 'Nashira Seraweels',
    },
    ['Enh'] = {
        Neck = 'Enhancing Torque',
        Body = 'Blessed Bliaut',
        Back = 'Merciful Cape',
        Legs = 'Cleric\'s Pantaln.',
        Feet = 'Cleric\'s Duckbills',
    },
    ['curepot'] = {
        Ammo = 'Hedgehog Bomb',
        Head = 'Raven Beret',
        Neck = 'Faith Torque',
        Ear1 = 'Geist Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Aristocrat\'s Coat',
        Hands = 'Custom F Gloves',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Medicine Ring',
        Back = 'Gigant Mantle',
        Waist = 'Korin Obi',
        Legs = 'Blessed Trousers',
        Feet = 'Crow Gaiters',
    },
    ['cureneghp'] = {
        Ammo = 'Phtm. Tathlum',
        Head = 'Faerie Hairpin',
        Neck = 'Checkered Scarf',
        Ear1 = 'Astral Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Flora Cotehardie',
        Hands = 'Merman\'s Bangles',
        Ring1 = 'Astral Ring',
        Ring2 = 'Ether Ring',
        Back = 'Blue Cape +1',
        Waist = 'Scouter\'s Rope',
        Legs = 'Raven Hose',
        Feet = 'Rostrum Pumps',
    },
};
profile.Sets = sets;

local Settings = {
    CurrentLevel = 0,
	MeleeVariant = 1,
	Enfeebleacc = true,
	Staticidle = false;
	Melee = false;
	MeleeLock = false;
};

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
	alias.OnLoad();
	AshitaCore:GetChatManager():QueueCommand(-1, '/alias /whm /lac fwd');
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F1 /lac fwd Staticidle');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F2 /lac fwd Melee');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F3 /lac fwd MeleeLock');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind ^F4 /lac fwd Enfeebleacc');
	AshitaCore:GetChatManager():QueueCommand(-1, '/bind o /item "Timeless Hrglass." <t>');
end

profile.OnUnload = function()
	alias.OnUnLoad();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /whm');
    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F1');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F2');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F3');
	AshitaCore:GetChatManager():QueueCommand(-1, '/unbind ^F4');
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
	if (args[1] == 'MeleeLock') then
        if (Settings.MeleeLock == true) then
            Settings.MeleeLock = false;
			gFunc.Message('Melee MP Gear');
        else
            Settings.MeleeLock = true;
			gFunc.Message('Melee NO MP Gear');
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
	if (args[1] == 'Staticidle') then
        if (Settings.Staticidle == true) then
            Settings.Staticidle = false;
			gFunc.Message('Dynamic Idle');
        else
            Settings.Staticidle = true;
			gFunc.Message('Static Idle Lock');
        end
	end
	if (args[1] == 'Enfeebleacc') then
        if (Settings.Enfeebleacc == true) then
            Settings.Enfeebleacc = false;
			gFunc.Message('Enfeeble Potency');
        else
            Settings.Enfeebleacc = true;
			gFunc.Message('Enfeeble MACC');
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
	if (player.SubJob == 'BLM') then	
		modmp = 0;
	elseif (player.SubJob == 'RDM') then
		modmp = 30;
	else
		modmp = 100;
	end
	local totalmp = 710 - modmp;
	
	if (player.Status == 'Engaged') then
		gFunc.EquipSet(sets.damage);
		if (player.SubJob == 'NIN') then
		gFunc.EquipSet(sets.weaponnin);
		else
		gFunc.EquipSet(sets.weapon);
		end
		if not string.contains(zone.Weather, "Dark") and (player.MainJobSync >= 65) then
			gFunc.Equip('Ear2','Diabolos\'s earring');
		end
		if (player.MainJobSync >= 59) and (player.MainJobSync <= 67) then
			gFunc.Equip('body', 'vermillion cloak');
			gFunc.Equip('head', '');
		end
			if (player.SubJob == 'NIN') and (Settings.Melee == true) and (Settings.MeleeLock == false) then --no ammo
					if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20	
					if (player.MP > (totalmp + 50)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
					if (player.MP > (totalmp + 98)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
					if (player.MP > (totalmp + 118)) then gFunc.Equip('Back','Blue Cape +1'); end --40
					if (player.MP > (totalmp + 150)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
					if (player.MP > (totalmp + 170)) then gFunc.Equip('Ring2','Ether Ring'); end --30
					if (player.MP > (totalmp + 200)) then gFunc.Equip('Legs','Custom Pants'); end --32
				if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
					if (player.MP > (totalmp + 232)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
					if (player.MP > (totalmp + 282)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
					if (player.MP > (totalmp + 302)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
					if (player.MP > (totalmp + 347)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
				else	
					if (player.MP > (totalmp + 232)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
					if (player.MP > (totalmp + 252)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
					if (player.MP > (totalmp + 272)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
					if (player.MP > (totalmp + 337)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
				end	
			else
				if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
				if (player.MP > (totalmp + 50)) then gFunc.Equip('Ammo','Hedgehog Bomb'); end --30
				if (player.MP > (totalmp + 70)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
				if (player.MP > (totalmp + 118)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
				if (player.MP > (totalmp + 138)) then gFunc.Equip('Back','Blue Cape +1'); end --40
				if (player.MP > (totalmp + 170)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
				if (player.MP > (totalmp + 190)) then gFunc.Equip('Ring2','Ether Ring'); end --30
				if (player.MP > (totalmp + 220)) then gFunc.Equip('Legs','Custom Pants'); end --32
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
				if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
				if (player.MP > (totalmp + 302)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 332)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 367)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			else	
				if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
				if (player.MP > (totalmp + 272)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 292)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 337)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			end	
			end
	end
	if (player.Status == 'Resting') then
		gFunc.EquipSet(sets.rest);
		if (player.MainJobSync >= 59) and (player.MainJobSync <= 67) then
			gFunc.Equip('body', 'vermillion cloak');
			gFunc.Equip('head', '');
		end
		if (Settings.MaxMP == true) then
		gFunc.EquipSet(sets.idlemp);
		end
		if (Settings.Melee == true) then
			if (player.SubJob == 'NIN') then
			gFunc.EquipSet(sets.weaponnin);
			else
			gFunc.EquipSet(sets.weapon);
			end
		end	
		if (Settings.Staticidle == false) then
				if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
				if (player.MP > (totalmp + 50 - 75)) then gFunc.Equip('Ammo','Hedgehog Bomb'); end --30
				if (player.MP > (totalmp + 70 - 75)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
				if (player.MP > (totalmp + 118 - 100)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
				if (player.MP > (totalmp + 138 - 125)) then gFunc.Equip('Back','Blue Cape +1'); end --40
				if (player.MP > (totalmp + 170 - 125)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
				if (player.MP > (totalmp + 190 - 150)) then gFunc.Equip('Ring2','Ether Ring'); end --30
				if (player.MP > (totalmp + 220 - 150)) then gFunc.Equip('Legs','Custom Pants'); end --32
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
				if (player.MP > (totalmp + 252 - 175)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
				if (player.MP > (totalmp + 302 - 200)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 332 - 200)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 367 - 250)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			else	
				if (player.MP > (totalmp + 252 - 160)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
				if (player.MP > (totalmp + 272 - 200)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 292 - 250)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 337 - 250)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			end	
		end
	end
	if (player.Status == 'Idle') then
		gFunc.EquipSet(sets.idle);
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', 'Terra\'s staff');
			end
			if (player.MainJobSync >= 59) and (player.MainJobSync <= 67) then
				gFunc.Equip('body', 'vermillion cloak');
				gFunc.Equip('head', '');
			end
		if (Settings.Melee == true) then
			if (player.SubJob == 'NIN') then
			gFunc.EquipSet(sets.weaponnin);
			else
			gFunc.EquipSet(sets.weapon);
			end
		end	
		if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) and (player.MainJobSync >= 67) then
			gFunc.Equip('head', 'President. Hairpin');
		end
		if (Settings.Staticidle == false) then
				if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
				if (player.MP > (totalmp + 50)) then gFunc.Equip('Ammo','Hedgehog Bomb'); end --30
				if (player.MP > (totalmp + 70)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
				if (player.MP > (totalmp + 118)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
				if (player.MP > (totalmp + 138)) then gFunc.Equip('Back','Blue Cape +1'); end --40
				if (player.MP > (totalmp + 170)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
				if (player.MP > (totalmp + 190)) then gFunc.Equip('Ring2','Ether Ring'); end --30
				if (player.MP > (totalmp + 220)) then gFunc.Equip('Legs','Custom Pants'); end --32
			if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
				if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
				if (player.MP > (totalmp + 302)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 332)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 367)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			else	
				if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
				if (player.MP > (totalmp + 272)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
				if (player.MP > (totalmp + 292)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
				if (player.MP > (totalmp + 337)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
			end	
		end
	end
	if string.contains(zone.Area, 'Dynamis') then
		elseif (town:contains(zone.Area)) then
			gFunc.Equip('Body','Federation Aketon');
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
	if (player.SubJob == 'BLM') then	
		modmp = 0;
	elseif (player.SubJob == 'RDM') then
		modmp = 30;
	else
		modmp = 100;
	end
	local totalmp = 710 - modmp;
	local action = gData.GetAction();
    local fastCastValue = 0.15;
    local minimumBuffer = 0.1;
    local packetDelay = 0.25;
    local castDelay = ((action.CastTime * (1 - fastCastValue)) / 1000) - minimumBuffer;
	if (castDelay >= packetDelay) then
        gFunc.SetMidDelay(castDelay)
    end
	gFunc.EquipSet(sets.fast);
	if (player.MainJobSync >= 30) and (player.SubJob == 'RDM') then
		gFunc.Equip('back','Warlock\'s Mantle');
	end
	if string.contains(action.Name, 'Cure') or string.contains(action.Name, 'Curaga') then
		if (player.MainJobSync >= 59) then
			gFunc.Equip('Feet','Cure Clogs');
			gFunc.Equip('Main','Rucke\'s Rung');
		end
	end
	if (player.MP > (totalmp + 148)) then gFunc.Equip('Back','Blue Cape +1'); end --40
	if (player.MP > (totalmp + 188)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
	if (Settings.Melee == true) then
			gFunc.Equip('Main','');
			gFunc.Equip('Sub','');
			--gFunc.Equip('Range','');
			--gFunc.Equip('Ammo','');
	end	
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
	local target = gData.GetActionTarget();
    local MndDebuffs = T{ 'Slow', 'Paralyze'};
	local IntDebuffs = T{ 'Blind',};
	local EnfIntDebuffs = T{ 'Sleep', 'Sleepga', 'Sleep II', 'Poison','Poison II','Bind','Gravity'};
	local EnfMndDebuffs = T{ 'Silence'};
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
	if (player.SubJob == 'BLM') then	
		modmp = 0;
	elseif (player.SubJob == 'RDM') then
		modmp = 30;
	else
		modmp = 100;
	end
	local totalmp = 710 - modmp;
	
	if (Settings.Melee == true) then
	gFunc.InterimEquipSet(sets.SIRDnoweap);
	elseif (string.contains(action.Name, 'Cure') or string.contains(action.Name, 'Curaga')) and (player.MP < (totalmp + 25)) then 
	gFunc.InterimEquipSet(sets.cureneghp);	
	else
	gFunc.InterimEquipSet(sets.SIRD);
		if (player.MP > (totalmp + 0)) then gFunc.InterimEquip('Hands','Zenith Mitts'); end --20
			if (player.MP > (totalmp + 0)) then gFunc.InterimEquip('Hands','Zenith Mitts'); end --20
			if (player.MP > (totalmp + 50)) then gFunc.InterimEquip('Ammo','Hedgehog Bomb'); end --30
			if (player.MP > (totalmp + 70)) then gFunc.InterimEquip('Waist','Hierarch Belt'); end --48
			if (player.MP > (totalmp + 118)) then gFunc.InterimEquip('Ear2','Magnetic Earring'); end --20
			if (player.MP > (totalmp + 138)) then gFunc.InterimEquip('Back','Blue Cape +1'); end --40
			if (player.MP > (totalmp + 170)) then gFunc.InterimEquip('Feet','Rostrum pumps'); end --30
			if (player.MP > (totalmp + 190)) then gFunc.InterimEquip('Ring2','Ether Ring'); end --30
			if (player.MP > (totalmp + 220)) then gFunc.InterimEquip('Legs','Custom Pants'); end --32
		if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
			if (player.MP > (totalmp + 252)) then gFunc.InterimEquip('Neck','Rep.Gold Medal'); end --50
			if (player.MP > (totalmp + 302)) then gFunc.InterimEquip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 332)) then gFunc.InterimEquip('Body','Blessed Bliaut'); end --73
			if (player.MP > (totalmp + 367)) then gFunc.InterimEquip('Head','Faerie Hairpin'); end --55
		else	
			if (player.MP > (totalmp + 252)) then gFunc.InterimEquip('Neck','Uggalepih Pendant'); end --20
			if (player.MP > (totalmp + 272)) then gFunc.InterimEquip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 292)) then gFunc.InterimEquip('Body','Blessed Bliaut'); end --73
			if (player.MP > (totalmp + 337)) then gFunc.InterimEquip('Head','Faerie Hairpin'); end --55
		end	
	end
	if (action.Skill == 'Enfeebling Magic') then
        if (MndDebuffs:contains(action.Name)) then
			gFunc.EquipSet(sets.Enf);
            gFunc.EquipSet(sets.DebuffMND);
			if (Settings.Enfeebleacc == true) then 
				gFunc.EquipSet(sets.Enf); 
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
					if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
					gFunc.Equip('waist', ObiTable[action.Element])
					end	
					if (conquest:GetOutsideControl()) and (player.MainJobSync >= 65) and (gData.GetBuffCount("signet") == 1) then
						gFunc.Equip('Hands','Mst.Cst. Bracelets');
					end	
					if string.contains(weatherzone.Weather, "Dark") and (player.MainJobSync >= 65) then
					gFunc.Equip('Ear1','Diabolos\'s earring');
					end
			end
        elseif (IntDebuffs:contains(action.Name)) then
			gFunc.EquipSet(sets.Enf);
            gFunc.EquipSet(sets.DebuffINT);
			if (Settings.Enfeebleacc == true) then 
				gFunc.EquipSet(sets.Enf); 
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
					if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
					gFunc.Equip('waist', ObiTable[action.Element])
					end	
					if (conquest:GetOutsideControl()) and (player.MainJobSync >= 65) and (gData.GetBuffCount("signet") == 1) then
						gFunc.Equip('Hands','Mst.Cst. Bracelets');
					end	
					if string.contains(weatherzone.Weather, "Dark") and (player.MainJobSync >= 65) then
					gFunc.Equip('Ear1','Diabolos\'s earring');
					end
			end
        elseif (EnfIntDebuffs:contains(action.Name)) then
            gFunc.EquipSet(sets.DebuffINT);
			gFunc.EquipSet(sets.Enf);
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
			if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
			gFunc.Equip('waist', ObiTable[action.Element])
			end	
			if (conquest:GetOutsideControl()) and (player.MainJobSync >= 65) and (gData.GetBuffCount("signet") == 1) then
				gFunc.Equip('Hands','Mst.Cst. Bracelets');
			end	
			if string.contains(weatherzone.Weather, "Dark") and (player.MainJobSync >= 65) then
			gFunc.Equip('Ear1','Diabolos\'s earring');
			end
        elseif (EnfMndDebuffs:contains(action.Name)) then
            gFunc.EquipSet(sets.DebuffMND);
			gFunc.EquipSet(sets.Enf);
			gFunc.EquipSet(sets.Enf);
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
			if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
			gFunc.Equip('waist', ObiTable[action.Element])
			end	
			if (conquest:GetOutsideControl()) and (player.MainJobSync >= 65) and (gData.GetBuffCount("signet") == 1) then
				gFunc.Equip('Hands','Mst.Cst. Bracelets');
			end
			if string.contains(weatherzone.Weather, "Dark") and (player.MainJobSync >= 65) then
			gFunc.Equip('Ear1','Diabolos\'s earring');
			end
		end
    elseif string.contains(action.Name, 'Cure') or string.contains(action.Name, 'Curaga') then
		--gFunc.SetMidDelay(0.3);
        gFunc.EquipSet(sets.Enmity);
		gFunc.Equip('ear2','Magnetic Earring');
			if (player.MainJobSync >= 51) then
				gFunc.Equip('main', ElementalStaffTable[action.Element]);
			end
			if (player.MainJobSync >= 68) then
				gFunc.Equip('Body','Aristocrat\'s Coat');
			end
			if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
			gFunc.Equip('waist', ObiTable[action.Element])
			end
		gFunc.EquipSet(sets.curepot);
    elseif string.match(action.Name, 'Stoneskin') then
        gFunc.EquipSet(sets.DebuffMND);
		elseif string.contains(action.Name, 'Regen') then
			--gFunc.Equip('Body','Cleric\'s Bliaut');
			gFunc.Equip('Main','Rucke\'s Rung');
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
	elseif (action.Skill == 'Divine Magic') then
	gFunc.EquipSet(sets.MND);
	if not (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then
	gFunc.Equip('Head','Republic Circlet')
	end
	gFunc.Equip('legs','Hlr. Pantaln. +1');
		if (player.MainJobSync >= 51) then
			gFunc.Equip('main', ElementalStaffTable[action.Element]);
		end
		if ObiCheck(action) >= 1 and (player.MainJobSync >= 71) then
			gFunc.Equip('waist', ObiTable[action.Element])
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
			if (player.MP > (totalmp + 50)) then gFunc.Equip('Ammo','Hedgehog Bomb'); end --30
			if (player.MP > (totalmp + 70)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
			if (player.MP > (totalmp + 118)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
			if (player.MP > (totalmp + 138)) then gFunc.Equip('Back','Blue Cape +1'); end --40
			if (player.MP > (totalmp + 170)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
			if (player.MP > (totalmp + 190)) then gFunc.Equip('Ring2','Ether Ring'); end --30
			if (player.MP > (totalmp + 220)) then gFunc.Equip('Legs','Custom Pants'); end --32
		if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
			if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
			if (player.MP > (totalmp + 302)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 332)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
			if (player.MP > (totalmp + 367)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
		else	
			if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
			if (player.MP > (totalmp + 272)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
			if (player.MP > (totalmp + 292)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
			if (player.MP > (totalmp + 337)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
		end	
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
local player = gData.GetPlayer();
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
	if (myLevel ~= Settings.CurrentLevel) then
	gFunc.EvaluateLevels(profile.Sets, myLevel);
	Settings.CurrentLevel = myLevel;
	end
	local modmp = 0;
	if (player.SubJob == 'BLM') then	
		modmp = 0;
	elseif (player.SubJob == 'RDM') then
		modmp = 30;
	else
		modmp = 100;
	end
	local totalmp = 710 - modmp;
	gFunc.EquipSet(sets.wsacc);
		if (player.MP > (totalmp + 0)) then gFunc.Equip('Hands','Zenith Mitts'); end --20
		if (player.MP > (totalmp + 50)) then gFunc.Equip('Ammo','Hedgehog Bomb'); end --30
		if (player.MP > (totalmp + 70)) then gFunc.Equip('Waist','Hierarch Belt'); end --48
		if (player.MP > (totalmp + 118)) then gFunc.Equip('Ear2','Magnetic Earring'); end --20
		if (player.MP > (totalmp + 138)) then gFunc.Equip('Back','Blue Cape +1'); end --40
		if (player.MP > (totalmp + 170)) then gFunc.Equip('Feet','Rostrum pumps'); end --30
		if (player.MP > (totalmp + 190)) then gFunc.Equip('Ring2','Ether Ring'); end --30
		if (player.MP > (totalmp + 220)) then gFunc.Equip('Legs','Custom Pants'); end --32
	if (conquest:GetOutsideControl()) and (gData.GetBuffCount("signet") == 1) then	
		if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Rep.Gold Medal'); end --50
		if (player.MP > (totalmp + 302)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
		if (player.MP > (totalmp + 332)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
		if (player.MP > (totalmp + 367)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
	else	
		if (player.MP > (totalmp + 252)) then gFunc.Equip('Neck','Uggalepih Pendant'); end --20
		if (player.MP > (totalmp + 272)) then gFunc.Equip('Ear1','Loquac. Earring'); end --20
		if (player.MP > (totalmp + 292)) then gFunc.Equip('Body','Blessed Bliaut'); end --73
		if (player.MP > (totalmp + 337)) then gFunc.Equip('Head','Faerie Hairpin'); end --55
	end		
end

return profile;