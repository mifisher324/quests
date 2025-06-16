require("bit")

function has_class(e, class_id)
  local char_bm = e:GetClassBitmask()
  return bit.band(char_bm, 2^class_id) == 2^class_id
end

function event_item_click_cast_client(e)
  if tonumber(e.spell_id) == 36936 then
    local class_tasks = {}
    if has_class(e.self, Class.RANGER - 1) then
      if not e.self:HasSpellScribed(4884) then
        table.insert(class_tasks, 74)
      end
    end
    if has_class(e.self, Class.SHADOWKNIGHT - 1) then
      if not e.self:HasSpellScribed(4904) then
        table.insert(class_tasks, 75)
      end
    end
    if has_class(e.self, Class.SHAMAN - 1) then
      if not e.self:HasSpellScribed(4901) then
        table.insert(class_tasks, 76)
      end
    end
    if #class_tasks == 0 then
      e.self:Message(MT.Yellow, "You have already learned everything you can from this particular geomancy stone.")
      e.self:SummonItem(59975)
    else
      e.self:TaskSelector(class_tasks)
    end
  end
end

function event_task_accepted(e)
  if e.task_id == 74 then
    e.self:UpdateTaskActivity(74, 0, 1)
  elseif e.task_id == 75 then
    e.self:UpdateTaskActivity(75, 0, 1)
  elseif e.task_id == 76 then
    e.self:UpdateTaskActivity(76, 0, 1)
  end
end
