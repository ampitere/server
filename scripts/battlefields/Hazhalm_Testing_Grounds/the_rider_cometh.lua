-----------------------------------
-- Area: Hazhalm Testing Grounds
-- BCNM: The Rider Cometh
-----------------------------------
local hazhalmTestingGroundsID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.HAZHALM_TESTING_GROUNDS,
    battlefieldId    = xi.battlefield.id.THE_RIDER_COMETH,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(15),
    index            = 0,
    entryNpc         = 'Entry_Gate',
    requiredKeyItems = { xi.ki.TALISMAN_KEY },

    questArea = xi.questLog.AHT_URHGAN,
    quest     = xi.quest.id.ahtUrhgan.THE_RIDER_COMETH,
    requiredVar      = 'Quest[6][76]Prog',
    requiredValue    = 4,
})

content.groups =
{
    {
        mobIds =
        {
            { hazhalmTestingGroundsID.mob.ODIN_PRIME },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {  
            { hazhalmTestingGroundsID.mob.ODIN_IMAGE_1 },
            { hazhalmTestingGroundsID.mob.ODIN_IMAGE_2 },
            { hazhalmTestingGroundsID.mob.ODIN_IMAGE_3 },
        },

        spawned = false,
    }
}

return content:register()
