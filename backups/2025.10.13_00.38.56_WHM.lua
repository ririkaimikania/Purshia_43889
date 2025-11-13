local profile = {};
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
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
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