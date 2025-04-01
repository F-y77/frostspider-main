local assets = {
    Asset("ANIM", "anim/wetspider.zip"),
}

local prefabs = {
    "monstermeat",
    "silk",
    "wetgoop",
    "splash_ocean"
}

local brain = require "brains/spiderbrain"

local function ShouldSleep(inst)
    return TheWorld.state.iscaveday and not inst.components.combat:HasTarget()
        and not (inst.components.homeseeker and inst.components.homeseeker:HasHome())
        and not inst.components.burnable:IsBurning()
        and not inst.components.freezable:IsFrozen()
        and not inst.components.health.takingfiredamage
end

local function ShouldWake(inst)
    return not TheWorld.state.iscaveday
        or inst.components.combat:HasTarget()
        or (inst.components.homeseeker and inst.components.homeseeker:HasHome())
        or inst.components.burnable:IsBurning()
        or inst.components.freezable:IsFrozen()
        or inst.components.health.takingfiredamage
        or (inst.components.follower and inst.components.follower.leader)
end

local function OnAttack(inst, target)
    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
        -- 添加潮湿效果
        if target.components.moisture then
            local wet_power = TUNING.WETSPIDER_WET_POWER or 30
            target.components.moisture:DoDelta(wet_power)
        end
    end
end

local function NormalRetarget(inst)
    return FindEntity(
        inst,
        TUNING.WETSPIDER_TARGET_DIST or TUNING.SPIDER_TARGET_DIST,
        function(guy)
            return inst.components.combat:CanTarget(guy)
                and not (inst.components.follower and inst.components.follower.leader == guy)
        end,
        { "_combat", "character" },
        { "spiderwhisperer", "spiderdisguise", "INLIMBO" }
    )
end

local function keeptargetfn(inst, target)
    return target ~= nil
        and target.components.combat ~= nil
        and target.components.health ~= nil
        and not target.components.health:IsDead()
        and not (inst.components.follower ~= nil and inst.components.follower.leader == target)
end

local function OnDeath(inst)
    if TUNING.WETSPIDER_DEATH_WET then
        -- 播放潮湿效果
        local fx = SpawnPrefab("splash_ocean")
        if fx then
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
        
        -- 使周围的生物潮湿
        local wet_range = TUNING.WETSPIDER_DEATH_WET_RANGE or 3
        local wet_power = TUNING.WETSPIDER_WET_POWER or 30
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, wet_range, {"_combat"}, {"INLIMBO", "wetspider", "wall", "structure"})
        
        for _, ent in ipairs(ents) do
            if ent ~= inst and ent.components.moisture then
                ent.components.moisture:DoDelta(wet_power)
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 10, .5)

    inst.DynamicShadow:SetSize(1.5, .5)
    inst.Transform:SetFourFaced()

    inst:AddTag("cavedweller")
    inst:AddTag("monster")
    inst:AddTag("hostile")
    inst:AddTag("scarytoprey")
    inst:AddTag("canbetrapped")
    inst:AddTag("smallcreature")
    inst:AddTag("spider")
    inst:AddTag("wetspider")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("wetspider")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 添加follower组件
    inst:AddComponent("follower")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.WETSPIDER_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.WETSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WETSPIDER_ATTACK_PERIOD)
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat.onhitotherfn = OnAttack

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED * 1.2  -- 潮湿蜘蛛移动更快
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED * 1.2
    inst.components.locomotor:SetSlowMultiplier(1)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.7)
    inst.components.lootdropper:AddRandomLoot("wetgoop", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.WETSPIDER_MIN_LOOT or 2

    inst:AddComponent("inspectable")
    
    inst:AddComponent("knownlocations")
    
    -- 添加更多必要的组件
    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.MEAT }, { FOODTYPE.MEAT })
    inst.components.eater:SetCanEatHorrible()
    inst.components.eater:SetStrongStomach(true)
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_SMALL
    
    MakeHauntablePanic(inst)
    MakeMediumBurnableCharacter(inst, "body")
    MakeMediumFreezableCharacter(inst, "body")

    -- 潮湿蜘蛛更容易被冻结
    if inst.components.freezable then
        inst.components.freezable:SetResistance(0.5)
    end

    -- 潮湿蜘蛛自带潮湿效果
    inst:AddComponent("moisture")
    inst.components.moisture.wetness = 100
    inst.components.moisture:ForceDry(false)

    inst:SetStateGraph("SGspider")
    inst:SetBrain(brain)

    -- 修改声音处理部分
    inst.sounds = {
        attack = "dontstarve/creatures/spider/attack",
        attack_grunt = "dontstarve/creatures/spider/attack_grunt",
        death = "dontstarve/creatures/spider/die",
        hit = "dontstarve/creatures/spider/hit_response",
        hit_response = "dontstarve/creatures/spider/hit_response",
        jump = "dontstarve/creatures/spider/attack_grunt",
        walk = "dontstarve/creatures/spider/walk",
        eat = "dontstarve/creatures/spider/eat",
        scream = "dontstarve/creatures/spider/scream",
        taunt = "dontstarve/creatures/spider/taunt",
        sleep = "dontstarve/creatures/spider/sleep",
        wake = "dontstarve/creatures/spider/wake"
    }

    -- 修改声音播放函数
    inst.SoundPath = function(inst, event)
        if event:find("spider_") then
            event = event:gsub("spider_", "")
        end
        return inst.sounds[event] or "dontstarve/creatures/spider/" .. event
    end

    -- 修改声音事件监听
    inst:ListenForEvent("attacked", function(inst)
        inst.SoundEmitter:PlaySound(inst:SoundPath("hit_response"))
    end)

    -- 修改攻击声音播放
    local old_attack_fn = inst.components.combat.StartAttack
    inst.components.combat.StartAttack = function(self)
        inst.SoundEmitter:PlaySound(inst:SoundPath("attack"))
        if old_attack_fn then
            old_attack_fn(self)
        end
    end

    -- 修改死亡声音播放
    inst:ListenForEvent("death", function(inst)
        inst.SoundEmitter:PlaySound(inst:SoundPath("death"))
        OnDeath(inst)
    end)

    return inst
end

return Prefab("wetspider", fn, assets, prefabs) 