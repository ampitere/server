-----------------------------------
-- Area: Open_sea_route_to_Mhaura
--  NPC: Sheadon
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 47
-----------------------------------
local ID = zones[xi.zone.OPEN_SEA_ROUTE_TO_MHAURA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.transport.messageTimeRemaining(player, ID.text.ON_WAY_TO_MHAURA, ID.text.ARRIVING_SOON_MHAURA, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
