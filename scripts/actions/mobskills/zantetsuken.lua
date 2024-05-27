-----------------------------------
-- Zantetsuken
--
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getAnimation() == 33 then -- can't hit targets that are healing
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    if math.random(1, 100) >= target:getMod(xi.mod.DEATHRES) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
        target:setHP(0)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return 0
end

return mobskillObject
