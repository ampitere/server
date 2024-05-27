-----------------------------------
-- Divine Interference
-----------------------------------
-- Log ID: 6, Quest ID: 76
-- Walahra Temple, !pos 80 0 22 50
-- Yoyoroon, !pos -17 -6 69 53
-- Walahra Temple, !pos 80 0 22 50
-- Entry Gate, !pos 488 -226 -20 78
-- Imperial Whitegate, !pos 152.8295 -2.2 0.0613 50
-----------------------------------
local hazhalmTestingGroundsID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------

local quest = Quest:new(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_RIDER_COMETH)

quest.reward =
{
    title = xi.title.HEIR_OF_THE_BLIGHTED_GLOOM
}

local rewardItems =
{
    [1] = xi.item.AESIR_MANTLE,
    [2] = xi.item.AESIR_EAR_PENDANT,
    [3] = xi.item.AESIR_TORQUE,
}

local function getRewardMask(player)
    local rewardMask = 0

    for bitNum, itemId in pairs(rewardItems) do
        if player:hasItem(itemId) then
            rewardMask = utils.mask.setBit(rewardMask, bitNum - 1, true)
        end
    end

    if player:hasSpell(xi.magic.spell.ODIN) then
        rewardMask = utils.mask.setBit(rewardMask, 4, true)
    end

    rewardMask = utils.mask.setBit(rewardMask, 5, true) -- information about valhalla only for repeat

    return rewardMask
end

local function giveQuestReward(player, eventOption)
    local wasRewarded = true

    if eventOption <= 3 then
        wasRewarded = npcUtil.giveItem(player, rewardItems[eventOption])
    elseif eventOption == 4 then
        npcUtil.giveCurrency(player, 'gil', 10000)
    elseif eventOption == 5 then
        player:addSpell(xi.magic.spell.ODIN)
        player:messageSpecial(hazhalmTestingGroundsID.text.ODIN_UNLOCKED, 0, 0, 1)
    end

    return wasRewarded
end

local function onTradeYoyoroon(trade)
    local chance = 0
    local items = 0

    if npcUtil.tradeHasExactly(trade, { xi.item.TIMEWORN_TALISMAN, xi.item.BOWL_OF_SUTLAC }) then
        items = 0
        chance = 60
    elseif npcUtil.tradeHasExactly(trade, { xi.item.TIMEWORN_TALISMAN, xi.item.IRMIK_HELVASI }) then
        items = 1
        chance = 60
    elseif npcUtil.tradeHasExactly(trade, { xi.item.TIMEWORN_TALISMAN, xi.item.BOWL_OF_SUTLAC, xi.item.IRMIK_HELVASI }) then
        items = 2
        chance = 80
    end

    if chance > 0 then
        if math.random(1,100) <= chance then
            return quest:progressEvent(319, 6, 0, 3, items, 0, -172515585, 3, 4)
        else
            return quest:progressEvent(324, 76, 0, 3, items, 0, 95045740, 4095, 0)
        end
    end
end

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.ETERNAL_MERCENARY
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [11] = function(player, triggerArea)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(933, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return quest:progressEvent(934, 65, 1, -25296784, -233832456, -101183490, -16642, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [933] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [934] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.TALISMAN_KEY) then
                        player:delKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                        quest:begin(player)
                    end
                end,
            },
        },
        
        [xi.zone.NASHMAU] =
        {
            ['Yoyoroon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(318, 9, 0, 3, 0, 0, 95045740, 4095, 4)
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        not player:needToZone() and
                        not player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return quest:progressEvent(320, 78, 0, 3, 2, 0, -172515585, 3, 4)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') >= 2 and
                        not player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return onTradeYoyoroon(trade)
                    end
                end,
            },

            onEventFinish =
            {
                [318] = function(player, csid, option, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.MESSAGE_FROM_YOYOROON) then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [319] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:needToZone(true)
                    quest:setVar(player, 'Prog', 3)
                end,

                [320] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                end,

                [324] = function(player, csid, option, npc)
                    player:confirmTrade()
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if npcUtil.giveKeyItem(player, xi.ki.TALISMAN_KEY) then
                        player:delKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS) -- should this give a cutscene?
                    end
                end
            },
        },

        [xi.zone.HAZHALM_TESTING_GROUNDS] =
        {
            ['Entry_Gate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(9, 78, 23, 2964, 1, 0, 3072, 5413, 1)
                    end
                end,
            },

            onEventUpdate =
            {
                [10] = function(player, csid, option, npc)
                    if option == 6 then
                        player:updateEvent(0, 25, 2964, 422, 0, 0, 0, 0)
                    elseif option == 10 then
                        player:updateEvent(xi.item.AESIR_MANTLE, xi.item.AESIR_EAR_PENDANT, xi.item.AESIR_TORQUE, 0, 0, 0, 0, getRewardMask(player))
                    end
                end,

                [32001] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                    player:updateEvent(2, 0, 0, 422, 0, 0, 0, 0)
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 5 then
                        return 10
                    end
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [10] = function(player, csid, option, npc)
                    if giveQuestReward(player, option) then
                        quest:setVar(player, 'Prog', 6)
                        player:startEvent(32002)
                    end
                end,

                [32001] = function(player, csid, option, npc)
                    player:setPos(0, 0, 0, 0, 78)
                end,
            },
        },

        [xi.zone.NASHMAU] =
        {
            ['Yoyoroon'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Yoyoroon') == 0 and
                        not player:hasKeyItem(xi.ki.TALISMAN_KEY) and
                        not player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return quest:progressEvent(321, 0, 0, 0, 0, 0, 0, 0, 0)
                    elseif
                        quest:getVar(player, 'Yoyoroon') == 2 and
                        not player:needToZone() and
                        not player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return quest:progressEvent(320, 0, 0, 0, 0, 0, 0, 0, 0)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Yoyoroon') == 1 and
                        not player:hasKeyItem(xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    then
                        return onTradeYoyoroon(trade)
                    end
                end,
            },

            onEventFinish =
            {
                [321] = function(player, csid, option, npc)
                    quest:setVar(player, 'Yoyoroon', 1)
                end,

                [319] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:needToZone(true)
                    quest:setVar(player, 'Yoyoroon', 2)
                end,

                [320] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TALISMAN_OF_THE_REBEL_GODS)
                    quest:setVar(player, 'Yoyoroon', 0)
                end,

                [324] = function(player, csid, option, npc)
                    player:confirmTrade()
                end,
            },
        },
    },

    -- Section: Complete quest
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, 'Prog') == 6
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(935, 0, 0, 10, 1863579, 1, 1, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [935] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:setCharVar('Quest[6][77]Timer', 1, NextJstDay()) -- Unwavering Resolve
                end,
            },
        },
    },
}

return quest
