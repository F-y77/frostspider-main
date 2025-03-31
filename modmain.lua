GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

-- 添加预制体
PrefabFiles = {
    "frostspider"
}

-- 添加资源文件路径
Assets = {
    Asset("ANIM", "anim/frostspider.zip"),
}

-- 添加字符串表
STRINGS.NAMES.FROSTSPIDER = "冰霜蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FROSTSPIDER = "一只散发着寒气的蜘蛛！"

-- 冰霜蜘蛛的基础属性配置
TUNING.FROSTSPIDER_HEALTH = 100
TUNING.FROSTSPIDER_DAMAGE = 20
TUNING.FROSTSPIDER_ATTACK_PERIOD = 2
TUNING.FROSTSPIDER_FREEZE_POWER = 3
TUNING.FROSTSPIDER_TARGET_DIST = 10

-- 应用配置选项
local health_config = GetModConfigData("frostspider_health")
if health_config ~= nil then
    TUNING.FROSTSPIDER_HEALTH = health_config
end

local damage_config = GetModConfigData("frostspider_damage")
if damage_config ~= nil then
    TUNING.FROSTSPIDER_DAMAGE = damage_config
end

local freeze_power = GetModConfigData("frostspider_freeze_power")
if freeze_power ~= nil then
    TUNING.FROSTSPIDER_FREEZE_POWER = freeze_power
end

local target_dist = GetModConfigData("frostspider_target_dist")
if target_dist ~= nil then
    TUNING.FROSTSPIDER_TARGET_DIST = target_dist
end

local attack_period = GetModConfigData("frostspider_attack_period")
if attack_period ~= nil then
    TUNING.FROSTSPIDER_ATTACK_PERIOD = attack_period
end

local min_loot = GetModConfigData("frostspider_min_loot")
if min_loot ~= nil then
    TUNING.FROSTSPIDER_MIN_LOOT = min_loot
end

local death_freeze = GetModConfigData("frostspider_death_freeze")
if death_freeze ~= nil then
    TUNING.FROSTSPIDER_DEATH_FREEZE = death_freeze
end

local death_freeze_range = GetModConfigData("frostspider_death_freeze_range")
if death_freeze_range ~= nil then
    TUNING.FROSTSPIDER_DEATH_FREEZE_RANGE = death_freeze_range
end

-- 添加冬季蜘蛛变形功能
local function BecomeFrostSpider(inst)
    inst.task = nil
    if inst.components.health:IsDead() then
        return
    end
    
    -- 应用所有自定义配置
    inst.components.health:SetMaxHealth(TUNING.FROSTSPIDER_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.FROSTSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.FROSTSPIDER_ATTACK_PERIOD)
    
    -- 修改外观和标签
    inst.AnimState:SetBuild("frostspider")
    inst.components.freezable:SetResistance(4)
    inst:AddTag("frostspider")
    
    -- 添加冰冻攻击效果
    inst.components.combat.onhitotherfn = function(inst, target)
        if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
            if target.components.freezable then
                local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER
                target.components.freezable:AddColdness(freeze_power)
                target.components.freezable:SpawnShatterFX()
            end
        end
    end
    
    -- 修改掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.5)
    inst.components.lootdropper:AddRandomLoot("ice", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.FROSTSPIDER_MIN_LOOT
    
    -- 添加死亡冰冻效果
    if not inst._old_ondeath then
        inst._old_ondeath = inst.components.health.ondeath
        inst.components.health.ondeath = function(inst)
            if TUNING.FROSTSPIDER_DEATH_FREEZE then
                -- 播放冰冻爆炸效果
                local fx = SpawnPrefab("icespike_fx_1")
                if fx then
                    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                
                -- 冻结周围的生物
                local freeze_range = TUNING.FROSTSPIDER_DEATH_FREEZE_RANGE
                local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x, y, z, freeze_range, {"_combat"}, {"INLIMBO", "frostspider", "wall", "structure"})
                
                for _, ent in ipairs(ents) do
                    if ent ~= inst and ent.components.freezable then
                        ent.components.freezable:AddColdness(freeze_power)
                        ent.components.freezable:SpawnShatterFX()
                    end
                end
            end
            if inst._old_ondeath then
                inst._old_ondeath(inst)
            end
        end
    end
end

local function BecomeNormalSpider(inst)
    inst.task = nil
    if inst.components.health:IsDead() then
        return
    end
    
    -- 恢复原始属性
    inst.AnimState:SetBuild("spider_build")
    inst.components.freezable:SetResistance(1)
    inst:RemoveTag("frostspider")
    
    -- 移除冰冻攻击效果
    inst.components.combat.onhitotherfn = nil
    
    -- 恢复原始掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.5)
    inst.components.lootdropper.numrandomloot = 1
    
    -- 恢复原始生命值和攻击力
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.SPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.SPIDER_ATTACK_PERIOD)
    
    -- 移除死亡冰冻效果
    if inst._old_ondeath then
        inst.components.health.ondeath = inst._old_ondeath
        inst._old_ondeath = nil
    end
end

local function OnIsWinter(inst, iswinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if iswinter then
        if inst.AnimState:GetBuild() ~= "frostspider" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeFrostSpider)
        end
    else
        if inst.AnimState:GetBuild() ~= "spider_build" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeNormalSpider)
        end
    end
end

local function OnWake(inst)
    inst:WatchWorldState("iswinter", OnIsWinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    if TheWorld.state.iswinter then
        if inst.AnimState:GetBuild() ~= "frostspider" then
            BecomeFrostSpider(inst)
        end
    else
        if inst.AnimState:GetBuild() ~= "spider_build" then
            BecomeNormalSpider(inst)
        end
    end
end

local function OnSleep(inst)
    inst:StopWatchingWorldState("iswinter", OnIsWinter)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
end

-- 修改普通蜘蛛
AddPrefabPostInit("spider", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    
    -- 添加季节变化监听
    inst.OnEntityWake = OnWake
    inst.OnEntitySleep = OnSleep
    
    -- 初始检查
    if TheWorld.state.iswinter then
        BecomeFrostSpider(inst)
    end
end)


