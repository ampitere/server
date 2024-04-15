-----------------------------------
-- Transport
-----------------------------------
require('scripts/globals/pathfind')
-----------------------------------
xi = xi or {}
xi.transport = xi.transport or {}

xi.transport.message =
{
    NEARING = 0,
    DOCKING = 1
}

xi.transport.epochOffset =
{
    NEARING = 265,
    DOCKING = 290
}

xi.transport.messageTime =
{
    SILVER_SEA = 480
}

xi.transport.trigger =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 0,
        FERRY_DEPARTING_TO_ALZAHBI  = 1,
        FERRY_ARRIVING_FROM_SELBINA = 2,
        FERRY_DEPARTING_TO_SELBINA  = 3
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 0,
        FERRY_DEPARTING_TO_MHAURA  = 1
    }
}

xi.transport.interval =
{
    mhaura =
    {
        FROM_TO_ALZAHBI = 480,
        FROM_TO_SELBINA = 480
    },
    selbina =
    {
        FROM_TO_MHAURA = 480
    }
}

xi.transport.offset =
{
    mhaura =
    {
        FERRY_ARRIVING_FROM_ALZAHBI = 159,
        FERRY_DEPARTING_TO_ALZAHBI  = 239,
        FERRY_ARRIVING_FROM_SELBINA = 399,
        FERRY_DEPARTING_TO_SELBINA  = 479
    },
    selbina =
    {
        FERRY_ARRIVING_FROM_MHAURA = 399,
        FERRY_DEPARTING_TO_MHAURA = 479
    }
}

xi.transport.pos =
{
    mhaura =
    {
        ARRIVING  =
        {
            { x = 7.06, y = -1.36, z = 2.20, rotation = 211 }
        },
        DEPARTING =
        {
            { x = 8.26, y = -1.36, z = 2.20, rotation = 193 }
        },
    },
    selbina =
    {
        ARRIVING  =
        {
            { x = 16.768, y = -1.38, z = -58.843, rotation = 209 }
        },
        DEPARTING =
        {
            { x = 17.979, y = -1.389, z = -58.800, rotation = 191 }
        },
    }
}

-----------------------------------
-- public functions
-----------------------------------

xi.transport.captainMessage = function(npc, triggerID, messages)
    local playersInZone = npc:getZone():getPlayers()
    for _, player in pairs(playersInZone) do
        player:showText(player, messages[triggerID])
    end
end

xi.transport.dockMessage = function(npc, triggerID, messages, dock)
    npc:showText(npc, messages[triggerID])
    if (triggerID % 2) == 0 then
        npc:pathThrough(xi.transport.pos[dock].ARRIVING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    else
        npc:pathThrough(xi.transport.pos[dock].DEPARTING, bit.bor(xi.path.flag.PATROL, xi.path.flag.WALLHACK))
    end
end

xi.transport.messageTimeRemaining = function(player, travellingMessage, arrivingMessage, offset)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 8
    end
    
    vHour = vHour - (vHour - 3) * 2

    if vHour == 8 and vMin <= offset then
        vHour = 0
    end

    local vMinutes = (vHour * 60) + offset - vMin

    vHour = math.floor(vMinutes / 60 + 0.5)

    local message = travellingMessage

    if vMinutes <= 30 then
        message = arrivingMessage
    elseif vMinutes < 60 then
        vHour = 0
    end

    if vHour > 7 then -- Normal players can't be on the boat longer than 7 Vanadiel hours. This is for GMs.
        vHour = 7
    end

    player:messageSpecial(message, math.abs(math.floor((2.4 * ((vHour * 60) + offset - vMin)) / 60)), vHour)
end
