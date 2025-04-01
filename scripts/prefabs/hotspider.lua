local assets = {
    Asset("ANIM", "anim/hotspider.zip"),
}

local prefabs = {
    "monstermeat",
    "silk",
    "charcoal",
    "explode_small"
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
        -- 添加燃烧效果
        if target.components.burnable and not target.components.burnable:IsBurning() then
            if math.random() < 0.3 then  -- 30%几率点燃目标
                target.components.burnable:Ignite()
            end
        end
        if target.components.temperature then
            target.components.temperature:DoDelta(2)  -- 增加目标温度
        end
    end
end

local function NormalRetarget(inst)
    return FindEntity(
        inst,
        TUNING.HOTSPIDER_TARGET_DIST or TUNING.SPIDER_TARGET_DIST,
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
    if TUNING.HOTSPIDER_DEATH_BURN then
        -- 播放燃烧爆炸效果
        local fx = SpawnPrefab("explode_small")
        if fx then
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
        
        -- 点燃周围的生物
        local burn_range = TUNING.HOTSPIDER_DEATH_BURN_RANGE or 3
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, burn_range, {"_combat"}, {"INLIMBO", "hotspider", "wall", "structure"})
        
        for _, ent in ipairs(ents) do
            if ent ~= inst and ent.components.burnable and not ent.components.burnable:IsBurning() then
                if math.random() < 0.5 then  -- 50%几率点燃
                    ent.components.burnable:Ignite()
                end
            end
            if ent.components.temperature then
                ent.components.temperature:DoDelta(5)
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
    inst:AddTag("hotspider")

    inst.AnimState:SetBank("spider")
    inst.AnimState:SetBuild("hotspider")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- 添加follower组件
    inst:AddComponent("follower")
    
    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.HOTSPIDER_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(TUNING.HOTSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.HOTSPIDER_ATTACK_PERIOD)
    inst.components.combat.hiteffectsymbol = "body"
    inst.components.combat:SetRetargetFunction(1, NormalRetarget)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat.onhitotherfn = OnAttack

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED * 0.9  -- 火爆蜘蛛移动较慢
    inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED * 0.9
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
    inst.components.lootdropper:AddRandomLoot("charcoal", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.HOTSPIDER_MIN_LOOT or 2

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

    -- 火爆蜘蛛更难被冻结
    if inst.components.freezable then
        inst.components.freezable:SetResistance(8)
    end

    -- 火爆蜘蛛自带高温效果
    inst:AddComponent("temperature")
    inst.components.temperature.current = 60
    inst.components.temperature.mintemp = 40

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

return Prefab("hotspider", fn, assets, prefabs) 