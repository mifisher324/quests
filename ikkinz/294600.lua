function event_death_complete(e)
	eq.zone_emote(MT.Yellow,"The sentinel's rubble drops to the ground. It has been defeated.");
	eq.signal(294597,1,0); -- NPC: #Trigger_Ikkinz_3
end

function event_timer(e)
if(e.timer=="OOBcheck") then
eq.stop_timer("OOBcheck");
	if (e.self:GetX() < 500 or e.self:GetX() > 700 or e.self:GetY() > -120 or e.self:GetY() < -300) then
		e.self:CastSpell(3791,e.self:GetID()); -- Spell: Ocean's Cleansing
		e.self:GotoBind();
		e.self:WipeHateList();
		e.self:SetHP(e.self:GetMaxHP());
	else
		eq.set_timer("OOBcheck", 3 * 1000);
	end
end
end

function event_combat(e)
	if e.joined then
		eq.set_timer("OOBcheck", 3 * 1000);	
	else
		eq.stop_timer("OOBcheck");
	end
end
