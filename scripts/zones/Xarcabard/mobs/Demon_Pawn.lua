-----------------------------------
-- Area: Xarcabard
--  Mob: Demon Pawn
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 55, 1, xi.regime.type.FIELDS)
end

return entity
