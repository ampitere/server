-----------------------------------
-- func: delcontaineritems
-- desc: Deletes all items held by a player, if they have any.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!delcontaineritems (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    targ:delContainerItems(xi.inv.INVENTORY)
    player:printToPlayer(string.format('Deleted container items from %s.', targ:getName()))
end

return commandObj
