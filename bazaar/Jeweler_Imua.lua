task_ids = require('task_ids')
function event_say(e)
  if e.message:findi('hail') then
    e.other:Message(MT.NPCQuestSay, "Jeweler Imua says 'Greetings, " .. e.other:GetCleanName() ..".  I've had some time to practice my enchanting and have learned how to create [" .. eq.say_link('enchanted platinum bars') .. "].  If you would like for me to create one for you, just let me know.'")
  end
  if e.message:findi('enchanted platinum bar') then
    e.other:AssignTask(task_ids.enchanted_platinum_bar)
  end
end

function event_trade(e)
  local item_lib = require("items")


  if e.other:IsTaskActive(task_ids.enchanted_platinum_bar) then
    if item_lib.check_turn_in(e.trade, {item1 = 16503, platinum = 5000}) then
      e.other:UpdateTaskActivity(task_ids.enchanted_platinum_bar, 1, 1)
    end
  end
  item_lib.return_items(e.self, e.other, e.trade)
end
