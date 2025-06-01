-- Ikkinz Raid #1: Chambers of Righteousness   

-- he should change into the race of whomever is on top aggro
--local spell_setone = false; --hybrid
--local spell_settwo = false; --priest
--local spell_setthree = false; --int
--local spell_setfour = false; --pure melee

spell_set = 0;
     
function event_death_complete(e)
   eq.spawn2(294579,0,0,-126,-919,-3,508); -- NPC: a_pile_of_bones
   eq.spawn2(294579,0,0,-124,-855,-3,260); -- NPC: a_pile_of_bones
   eq.spawn2(294579,0,0,-187,-853,-3,254); -- NPC: a_pile_of_bones
   eq.spawn2(294579,0,0,-182,-922,-3,496); -- NPC: a_pile_of_bones
end

function event_combat(e)
   if(e.joined) then
		eq.set_timer("random", 5 * 1000);
		eq.set_timer("memwipe", 60 * 1000);
	else
		eq.stop_timer("random");
		eq.stop_timer("memwipe");
	end
end

function event_timer(e)
  if (e.timer == "random") then
  	local check_type = e.self:GetHateTop()
    local spell_set_1 = false
    local spell_set_2 = false
    local spell_set_3 = false
    local spell_set_4 = false

	  if (check_type.valid and check_type:IsClient() and not check_type:IsPet()) then
		  local check_type_v = check_type:GetRace();
      local check_type_g = check_type:GetGender();
		  e.self:SetRace(check_type_v);
      e.self:SetGender(check_type_g);
      if check_type:GetClass() == Class.BEASTLORD or check_type:GetClass() == Class.BARD  or check_type:GetClass() == Class.SHADOWKNIGHT  or check_type:GetClass() == Class.RANGER  or check_type:GetClass() == Class.PALADIN then
        spell_set_1 = true; --hybrid
      elseif check_type:GetClass() == Class.CLERIC  or check_type:GetClass() == Class.DRUID  or check_type:GetClass() == Class.SHAMAN then
        spell_set_2 = true; --priest
      elseif check_type:GetClass() == Class.NECROMANCER  or check_type:GetClass() == Class.WIZARD  or check_type:GetClass() == Class.MAGICIAN  or check_type:GetClass() == Class.ENCHANTER then
        spell_set_3 = true; --int
      elseif check_type:GetClass() == Class.WARRIOR  or check_type:GetClass() == Class.MONK  or check_type:GetClass() == Class.ROGUE  or check_type:GetClass() == Class.BERSERKER then
        spell_set_4 = true; --pure melee
      end
	  end
    local rand = math.random(1, 100);
    local spell_list = {}
    if rand >= 85 then --50% chance to cast something
      if spell_set_1 then
        table.insert(spell_list, 36930) -- Tunik's Deadly Lifetap
        table.insert(spell_list, 5005) -- Tamuik's Ghastly Presence
      end
      if spell_set_2 then
        table.insert(spell_list, 5009) -- Unholy Barrage
        table.insert(spell_list, 5007) -- Curse of Tunik Tamuik
      end
      if spell_set_3 then
        table.insert(spell_list, 5003) -- Impoverished Lifeblood
        table.insert(spell_list, 5002) -- Manablast
      end
      if spell_set_4 then
        table.insert(spell_list, 5008) -- Bane of Tunik Tamuik
        table.insert(spell_list, 5006) -- Tamuik's Spectral Step
      end
      local spell_cast = spell_list[math.random(1, #spell_list)]
      e.self:CastedSpellFinished(spell_cast, e.self:GetHateRandom())
      if spell_cast == 36930 then
        e.self:Say("Your life force is mine!")
      elseif spell_cast == 5005 then
        e.self:Emote("instills fright in his foe with his ghastly presence.")
      elseif spell_cast == 5009 then
        e.self:Emote("unleashes an unholy harrage upon his opponent!")
      elseif spell_cast == 5007 then
        e.self:Say("Now you will suffer the baleful existence I know!")
      elseif spell_cast == 5003 then
        e.self:Emote("assaults his foe with a blood-reaping blast of magic!")
      elseif spell_cast == 5002 then
        e.self:Emote("assaults his foe with a blast of tainted mana!")
      elseif spell_cast == 5008 then
        e.self:Say("Now you will suffer the baleful existence I know!")
      elseif spell_cast == 5006 then
        e.self:Say("Time has no meaning when you live as a ghost does!")
      end
    end
  elseif (e.timer == "memwipe") then
		local rand_hate = e.self:GetHateTop()

		if (rand_hate.valid and rand_hate:IsClient() and not rand_hate:IsPet()) then
				
			local rand_hate_v = rand_hate:CastToClient()
			if (rand_hate_v.valid) then
				e.self:SetHate(rand_hate_v, 1, 1)		
			end
		end
   end
end
