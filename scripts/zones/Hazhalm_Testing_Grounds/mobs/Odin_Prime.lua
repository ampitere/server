-----------------------------------
-- Area: Hazhalm Testing Grounds (The Rider Cometh)
--  Mob: Odin Prime
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('NextImageSpawn', os.time() + 60) 
end

entity.onMobFight = function(mob, target)
    local isBusy = false
    local act = mob:getCurrentAction()
    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH or
        act == xi.act.MAGIC_CASTING
    then
        isBusy = true
    end

    if
        mob:getHPP() <= 50 and
        mob:getTP() >= 1000 and
        mob:getLocalVar('Zantetsuken') == 0 and
        not isBusy
    then
        local chance = math.random(1, 50) + (50 - mob:getHPP())
        if chance >= 80 then
            mob:setLocalVar('Zantetsuken', 1)
            mob:setMobAbilityEnabled(false)
            mob:setMagicCastingEnabled(false)
            mob:showText(mob, ID.text.ZANTETSUKEN_START)

            mob:timer(2000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 9)
            end)
            
            mob:timer(3000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 8)
            end)
            
            mob:timer(4000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 7)
            end)
            
            mob:timer(5000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 6)
            end)
            
            mob:timer(6000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 5)
            end)
            
            mob:timer(7000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 4)
            end)
            
            mob:timer(8000, function(mobArg)
                mobArg:showText(mobArg,ID.text.ZANTETSUKEN_COUNT, 3)
            end)
            
            mob:timer(9000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 2)
            end)
            
            mob:timer(10000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_COUNT, 1)
            end)

            mob:timer(11000, function(mobArg)
                mobArg:showText(mobArg, ID.text.ZANTETSUKEN_END)
                mobArg:useMobAbility(2126)
            end)

            mob:timer(12000, function(mobArg)
                mobArg:setMobAbilityEnabled(true)
                mobArg:setMagicCastingEnabled(true)
            end)
        end
    end

    local spawnTime = mob:getLocalVar('NextImageSpawn') - os.time()
    if spawnTime <= 0 then
        -- spawn image
        mob:setLocalVar('NextImageSpawn', os.time() + 60)
        local imageToSpawn = nil
        local imageOne = GetMobByID(ID.mob.ODIN_IMAGE_1)
        local imageTwo = GetMobByID(ID.mob.ODIN_IMAGE_2)
        local imageThree = GetMobByID(ID.mob.ODIN_IMAGE_3)

        if not imageOne:isSpawned() then
            imageToSpawn = imageOne
        elseif not imageTwo:isSpawned() then
            imageToSpawn = imageTwo
        elseif not imageThree:isSpawned() then
            imageToSpawn = imageThree
        end

        if imageToSpawn then
            imageToSpawn:setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos() + math.random(-2, 2), mob:getZPos() + math.random(-2, 2), mob:getRotPos())
            imageToSpawn:spawn()

            if target then
                print(target, imageToSpawn, 'updateenmity')
                imageToSpawn:updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local imageOne = GetMobByID(ID.mob.ODIN_IMAGE_1)
    if imageOne:isSpawned() then
        DespawnMob(imageOne:getID())
    end

    local imageTwo = GetMobByID(ID.mob.ODIN_IMAGE_2)
    if imageTwo:isSpawned() then
        DespawnMob(imageTwo:getID())
    end

    local imageThree = GetMobByID(ID.mob.ODIN_IMAGE_3)
    if imageThree:isSpawned() then
        DespawnMob(imageThree:getID())
    end
end

return entity