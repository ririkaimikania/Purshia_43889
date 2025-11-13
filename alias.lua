local alias = T{};

function alias.OnLoad()
    local player = gData.GetPlayer();
    AshitaCore:GetChatManager():QueueCommand(-1, '/bind del /exec forceblink.txt');
    if (player.MainJob == "WHM") then
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /c5 //cure5');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cg3 //curaga3');
    end
    if (player.MainJob == "WHM") or (player.SubJob == 'WHM') then
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bars //barstonra');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barw //barwatera');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bara //baraera');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barf //barfira');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barb //barblizzara');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bart //barthundra');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cg //curaga');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cg2 //curaga2');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /c4 //cure4');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /c3 //cure3');
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind @0 /ma sneak <t>');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind @9 /ma invisible <t>');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind #1 /cg');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind #2 /cg2');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind #3 /cg3');
    elseif (player.MainJob == "RDM") or (player.SubJob == 'RDM') then
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bars //barstone');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barw //barwater');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bara //baraero');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barf //barfire');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /barb //barblizzard');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /bart //barthunder');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /c4 //cure4');
        AshitaCore:GetChatManager():QueueCommand(-1, '/alias /c3 //cure3');
        AshitaCore:GetChatManager():QueueCommand(-1, '/bind @0 /ma sneak <t>');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind @9 /ma invisible <t>');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind #1 /cg');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/bind #2 /cg2');
	end
    if (player.MainJob == "BRD") then
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /care //earthcarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /carw //watercarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cara //windcarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /carf //firecarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cari //icecarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /cart //thundercarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /carl //lightcarol');
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /card //darkcarol');
	end
end

function alias.OnUnLoad()
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias clear');
		AshitaCore:GetChatManager():QueueCommand(-1, '/unbind del');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @9');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind @0');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind #1');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind #2');
	    AshitaCore:GetChatManager():QueueCommand(-1, '/unbind #3');
end

return alias