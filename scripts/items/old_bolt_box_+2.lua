-----------------------------------
-- ID: 5280
-- Old Bolt Box +2
-- When used, you will obtain one partial stack of Dogbolt +2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DOGBOLT_P2, math.random(10, 20) } })
end

return itemObject
