-----------------------------------
-- Area: Hazhalm_Testing_Grounds
-----------------------------------
zones = zones or {}

zones[xi.zone.HAZHALM_TESTING_GROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6390, -- Obtained: <item>.
        GIL_OBTAINED                     = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                     = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED    = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7260, -- You cannot enter the battlefield at present. Please wait a little longer.
        TIME_IN_THE_BATTLEFIELD_IS_UP    = 7263, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED        = 7264, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY            = 7569, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE         = 7570, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS    = 7572, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN        = 7573, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED        = 7580, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR     = 7634, -- Entering the battlefield for [The Rider Cometh/]!
        ODIN_UNLOCKED                    = 7868, -- You have gained the ability to summon Odin!
        ZANTETSUKEN_START                = 8021, -- Is this the uttermost limit of thy resolve? Ten beats of a fearless heart hast thou to prove thy worth, lest a brutal demise be thy sole reward...
        ZANTETSUKEN_COUNT                = 8022, -- #...
        ZANTETSUKEN_END                  = 8023, -- Hark, for my blade sings thy dirge!
    },
    mob =
    {
        ODIN_PRIME   = 17097298,
        ODIN_IMAGE_1 = 17097299,
        ODIN_IMAGE_2 = 17097300,
        ODIN_IMAGE_3 = 17097301,
    },
    npc =
    {
    },
}

return zones[xi.zone.HAZHALM_TESTING_GROUNDS]
