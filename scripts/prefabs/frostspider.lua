local assets = {
    Asset("ANIM", "anim/ds_spider_basic.zip"),
    Asset("ANIM", "anim/spider_build.zip"),
}

local prefabs = {
    "monstermeat",
    "silk",
    "ice"
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
        -- 添加冰冻效果
        if target.components.freezable then
            local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER or 3
            target.components.freezable:AddColdness(freeze_power)  -- 使用配置的冰冻强度
            target.components.freezable:SpawnShatterFX()  -- 产生冰冻特效
        end
    end
end

local function NormalRetarget(inst)
    return FindEntity(
        inst,
        TUNING.FROSTSPIDER_TARGET_DIST or TUNING.SPIDER_TARGET_DIST,
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
    inst:AddTag("frostspider")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("spider_build")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 添加follower组件
    inst:AddComponent("follower")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.FROSTSPIDER_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.FROSTSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.FROSTSPIDER_ATTACK_PERIOD)
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat.onhitotherfn = OnAttack

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED
    inst.components.locomotor:SetSlowMultiplier(1)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { ignorecreep = true }

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWake)

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.5)
    inst.components.lootdropper:AddRandomLoot("ice", 0.3)
    inst.components.lootdropper.numrandomloot = 2

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

    -- 添加冰冻抗性
    if inst.components.freezable then
        inst.components.freezable:SetResistance(4)
    end

    inst:SetStateGraph("SGspider")
    inst:SetBrain(brain)

    -- 修复声音处理
    inst.SoundPath = function(inst, event)
        if event == "attack" then
            return "dontstarve/creatures/spider/attack"
        elseif event == "attack_grunt" then
            return "dontstarve/creatures/spider/attack_grunt"
        elseif event == "death" then
            return "dontstarve/creatures/spider/die"
        elseif event == "hit" then
            return "dontstarve/creatures/spider/hit_response"
        elseif event == "hit_response" then
            return "dontstarve/creatures/spider/hit_response"
        elseif event == "jump" then
            return "dontstarve/creatures/spider/attack_grunt"
        elseif event == "walk" then
            return "dontstarve/creatures/spider/walk"
        elseif event == "eat" then
            return "dontstarve/creatures/spider/eat"
        elseif event == "scream" then
            return "dontstarve/creatures/spider/scream"
        elseif event == "taunt" then
            return "dontstarve/creatures/spider/taunt"
        elseif event == "sleep" then
            return "dontstarve/creatures/spider/sleep"
        elseif event == "wake" then
            return "dontstarve/creatures/spider/wake"
        end
        return "dontstarve/creatures/spider/spider_" .. event
    end

    -- 添加声音事件监听
    inst:ListenForEvent("attacked", function(inst)
        inst.SoundEmitter:PlaySound(inst:SoundPath("hit_response"))
    end)

    -- 确保攻击声音正确播放
    local old_attack_fn = inst.components.combat.StartAttack
    inst.components.combat.StartAttack = function(self)
        inst.SoundEmitter:PlaySound(inst:SoundPath("attack"))
        if old_attack_fn then
            old_attack_fn(self)
        end
    end

    return inst
end

return Prefab("frostspider", fn, assets, prefabs) 