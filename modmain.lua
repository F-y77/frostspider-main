GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

-- 添加预制体
PrefabFiles = {
    "frostspider",
    "wetspider",
    "hotspider",
    "frost_switcherdoodle",
    "wet_switcherdoodle",
    "hot_switcherdoodle"
}

-- 添加资源文件路径
Assets = {
    Asset("ANIM", "anim/frostspider.zip"),
    Asset("ANIM", "anim/wetspider.zip"),
    Asset("ANIM", "anim/hotspider.zip"),
    Asset("ANIM", "anim/frost_switcherdoodle.zip"),
    Asset("ANIM", "anim/wet_switcherdoodle.zip"),
    Asset("ANIM", "anim/hot_switcherdoodle.zip"),
}

-- 添加字符串表
STRINGS.NAMES.FROSTSPIDER = "冰霜蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FROSTSPIDER = "一只散发着寒气的蜘蛛！"
STRINGS.NAMES.WETSPIDER = "潮湿蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WETSPIDER = "一只湿漉漉的蜘蛛！"
STRINGS.NAMES.HOTSPIDER = "火爆蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOTSPIDER = "一只燃烧着怒火的蜘蛛！"

-- 添加变身涂鸦的名称和描述
STRINGS.NAMES.FROST_SWITCHERDOODLE = "冰霜变身涂鸦"
STRINGS.RECIPE_DESC.FROST_SWITCHERDOODLE = "让蜘蛛变成冰霜蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FROST_SWITCHERDOODLE = "看起来冷冰冰的，但蜘蛛会喜欢它"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.FROST_SWITCHERDOODLE = "我们做了一个冰冷的小点心！"

STRINGS.NAMES.WET_SWITCHERDOODLE = "潮湿变身涂鸦"
STRINGS.RECIPE_DESC.WET_SWITCHERDOODLE = "让蜘蛛变成潮湿蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WET_SWITCHERDOODLE = "湿漉漉的，但蜘蛛会喜欢它"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.WET_SWITCHERDOODLE = "我们做了一个湿润的小点心！"

STRINGS.NAMES.HOT_SWITCHERDOODLE = "火爆变身涂鸦"
STRINGS.RECIPE_DESC.HOT_SWITCHERDOODLE = "让蜘蛛变成火爆蜘蛛"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOT_SWITCHERDOODLE = "摸起来很烫，但蜘蛛会喜欢它"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.HOT_SWITCHERDOODLE = "我们做了一个火辣的小点心！"

-- 冰霜蜘蛛的基础属性配置
TUNING.FROSTSPIDER_HEALTH = 100
TUNING.FROSTSPIDER_DAMAGE = 20
TUNING.FROSTSPIDER_ATTACK_PERIOD = 2
TUNING.FROSTSPIDER_FREEZE_POWER = 3
TUNING.FROSTSPIDER_TARGET_DIST = 10
TUNING.FROSTSPIDER_MIN_LOOT = 2
TUNING.FROSTSPIDER_DEATH_FREEZE = true
TUNING.FROSTSPIDER_DEATH_FREEZE_RANGE = 3

-- 潮湿蜘蛛的基础属性配置
TUNING.WETSPIDER_HEALTH = 90
TUNING.WETSPIDER_DAMAGE = 15
TUNING.WETSPIDER_ATTACK_PERIOD = 1.5
TUNING.WETSPIDER_WET_POWER = 30
TUNING.WETSPIDER_TARGET_DIST = 8
TUNING.WETSPIDER_MIN_LOOT = 2
TUNING.WETSPIDER_DEATH_WET = true
TUNING.WETSPIDER_DEATH_WET_RANGE = 3

-- 火爆蜘蛛的基础属性配置
TUNING.HOTSPIDER_HEALTH = 120
TUNING.HOTSPIDER_DAMAGE = 25
TUNING.HOTSPIDER_ATTACK_PERIOD = 2.5
TUNING.HOTSPIDER_BURN_POWER = 3
TUNING.HOTSPIDER_TARGET_DIST = 12
TUNING.HOTSPIDER_MIN_LOOT = 2
TUNING.HOTSPIDER_DEATH_BURN = true
TUNING.HOTSPIDER_DEATH_BURN_RANGE = 3

-- 添加秋季普通蜘蛛的基础属性配置
TUNING.AUTUMN_SPIDER_HEALTH_MULT = 1.2  -- 生命值倍率
TUNING.AUTUMN_SPIDER_DAMAGE_MULT = 1.2  -- 伤害倍率
TUNING.AUTUMN_SPIDER_SPEED_MULT = 1.1   -- 速度倍率

-- 然后应用配置选项
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

-- 应用潮湿蜘蛛配置选项
local wetspider_health = GetModConfigData("wetspider_health")
if wetspider_health ~= nil then
    TUNING.WETSPIDER_HEALTH = wetspider_health
end

local wetspider_damage = GetModConfigData("wetspider_damage")
if wetspider_damage ~= nil then
    TUNING.WETSPIDER_DAMAGE = wetspider_damage
end

local wetspider_wet_power = GetModConfigData("wetspider_wet_power")
if wetspider_wet_power ~= nil then
    TUNING.WETSPIDER_WET_POWER = wetspider_wet_power
end

-- 应用火爆蜘蛛配置选项
local hotspider_health = GetModConfigData("hotspider_health")
if hotspider_health ~= nil then
    TUNING.HOTSPIDER_HEALTH = hotspider_health
end

local hotspider_damage = GetModConfigData("hotspider_damage")
if hotspider_damage ~= nil then
    TUNING.HOTSPIDER_DAMAGE = hotspider_damage
end

-- 应用秋季蜘蛛配置选项
local autumn_spider_health_mult = GetModConfigData("autumn_spider_health_mult")
if autumn_spider_health_mult ~= nil then
    TUNING.AUTUMN_SPIDER_HEALTH_MULT = autumn_spider_health_mult
end

local autumn_spider_damage_mult = GetModConfigData("autumn_spider_damage_mult")
if autumn_spider_damage_mult ~= nil then
    TUNING.AUTUMN_SPIDER_DAMAGE_MULT = autumn_spider_damage_mult
end

local autumn_spider_speed_mult = GetModConfigData("autumn_spider_speed_mult")
if autumn_spider_speed_mult ~= nil then
    TUNING.AUTUMN_SPIDER_SPEED_MULT = autumn_spider_speed_mult
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
    inst:RemoveTag("wetspider")
    inst:RemoveTag("hotspider")
    
    -- 添加冰冻攻击效果
    inst.components.combat.onhitotherfn = function(inst, target)
        if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
            if target.components.freezable then
                local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER
                target.components.freezable:AddColdness(freeze_power)
            end
            if target.components.temperature then
                target.components.temperature:DoDelta(-2)  -- 降低目标温度
            end
        end
    end
    
    -- 修改掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.7)
    inst.components.lootdropper:AddRandomLoot("ice", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.FROSTSPIDER_MIN_LOOT
    
    -- 添加死亡冰冻效果
    if not inst._old_ondeath then
        inst._old_ondeath = inst.components.health.ondeath
        inst.components.health.ondeath = function(inst)
            if TUNING.FROSTSPIDER_DEATH_FREEZE then
                -- 播放冰冻效果
                local fx = SpawnPrefab("icespike_fx_1")
                if fx then
                    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                
                -- 冰冻周围的生物
                local freeze_range = TUNING.FROSTSPIDER_DEATH_FREEZE_RANGE or 3
                local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER or 3
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x, y, z, freeze_range, {"_combat"}, {"INLIMBO", "frostspider", "wall", "structure"})
                
                for _, ent in ipairs(ents) do
                    if ent ~= inst and ent.components.freezable and not ent.components.freezable:IsFrozen() then
                        ent.components.freezable:AddColdness(freeze_power)
                    end
                    if ent.components.temperature then
                        ent.components.temperature:DoDelta(-5)
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
    
    -- 恢复原始外观
    inst.AnimState:SetBuild("spider_build")
    inst.components.freezable:SetResistance(1)
    inst:RemoveTag("frostspider")
    inst:RemoveTag("wetspider")
    inst:RemoveTag("hotspider")
    
    -- 移除特殊攻击效果
    inst.components.combat.onhitotherfn = nil
    
    -- 恢复原始掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.5)
    inst.components.lootdropper.numrandomloot = 1
    
    -- 秋季增强版普通蜘蛛
    if TheWorld.state.season == "autumn" then
        -- 增强生命值
        local base_health = TUNING.SPIDER_HEALTH
        inst.components.health:SetMaxHealth(base_health * TUNING.AUTUMN_SPIDER_HEALTH_MULT)
        
        -- 增强攻击力
        local base_damage = TUNING.SPIDER_DAMAGE
        inst.components.combat:SetDefaultDamage(base_damage * TUNING.AUTUMN_SPIDER_DAMAGE_MULT)
        
        -- 增强移动速度
        local base_speed = TUNING.SPIDER_WALK_SPEED
        inst.components.locomotor.walkspeed = base_speed * TUNING.AUTUMN_SPIDER_SPEED_MULT
        inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED * TUNING.AUTUMN_SPIDER_SPEED_MULT
    else
        -- 恢复原始生命值和攻击力
        inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH)
        inst.components.combat:SetDefaultDamage(TUNING.SPIDER_DAMAGE)
        inst.components.combat:SetAttackPeriod(TUNING.SPIDER_ATTACK_PERIOD)
        inst.components.locomotor.walkspeed = TUNING.SPIDER_WALK_SPEED
        inst.components.locomotor.runspeed = TUNING.SPIDER_RUN_SPEED
    end
    
    -- 移除死亡特殊效果
    if inst._old_ondeath then
        inst.components.health.ondeath = inst._old_ondeath
        inst._old_ondeath = nil
    end
end

-- 添加潮湿蜘蛛变形功能
local function BecomeWetSpider(inst)
    inst.task = nil
    if inst.components.health:IsDead() then
        return
    end
    
    -- 应用所有自定义配置
    inst.components.health:SetMaxHealth(TUNING.WETSPIDER_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.WETSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WETSPIDER_ATTACK_PERIOD)
    
    -- 修改外观和标签
    inst.AnimState:SetBuild("wetspider")
    inst:AddTag("wetspider")
    inst:RemoveTag("frostspider")
    inst:RemoveTag("hotspider")
    
    -- 添加潮湿攻击效果
    inst.components.combat.onhitotherfn = function(inst, target)
        if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
            if target.components.moisture then
                local wet_power = TUNING.WETSPIDER_WET_POWER
                target.components.moisture:DoDelta(wet_power)
            end
        end
    end
    
    -- 修改掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.7)
    inst.components.lootdropper:AddRandomLoot("waterballoon", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.WETSPIDER_MIN_LOOT
    
    -- 添加死亡潮湿效果
    if not inst._old_ondeath then
        inst._old_ondeath = inst.components.health.ondeath
        inst.components.health.ondeath = function(inst)
            if TUNING.WETSPIDER_DEATH_WET then
                -- 播放潮湿效果
                local fx = SpawnPrefab("splash_ocean")
                if fx then
                    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                
                -- 使周围的生物潮湿
                local wet_range = TUNING.WETSPIDER_DEATH_WET_RANGE
                local wet_power = TUNING.WETSPIDER_WET_POWER
                local x, y, z = inst.Transform:GetWorldPosition()
                local ents = TheSim:FindEntities(x, y, z, wet_range, {"_combat"}, {"INLIMBO", "wetspider", "wall", "structure"})
                
                for _, ent in ipairs(ents) do
                    if ent ~= inst and ent.components.moisture then
                        ent.components.moisture:DoDelta(wet_power)
                    end
                end
            end
            if inst._old_ondeath then
                inst._old_ondeath(inst)
            end
        end
    end
end

-- 添加火爆蜘蛛变形功能
local function BecomeHotSpider(inst)
    inst.task = nil
    if inst.components.health:IsDead() then
        return
    end
    
    -- 应用所有自定义配置
    inst.components.health:SetMaxHealth(TUNING.HOTSPIDER_HEALTH)
    inst.components.combat:SetDefaultDamage(TUNING.HOTSPIDER_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.HOTSPIDER_ATTACK_PERIOD)
    
    -- 修改外观和标签
    inst.AnimState:SetBuild("hotspider")
    inst.components.freezable:SetResistance(8)
    inst:AddTag("hotspider")
    inst:RemoveTag("frostspider")
    inst:RemoveTag("wetspider")
    
    -- 添加燃烧攻击效果
    inst.components.combat.onhitotherfn = function(inst, target)
        if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
            if target.components.burnable and not target.components.burnable:IsBurning() then
                local burn_power = TUNING.HOTSPIDER_BURN_POWER or 3
                if math.random() < 0.3 then  -- 30%几率点燃目标
                    target.components.burnable:Ignite()
                end
            end
            if target.components.temperature then
                target.components.temperature:DoDelta(2)  -- 增加目标温度
            end
        end
    end
    
    -- 修改掉落物
    inst.components.lootdropper:SetLoot(nil)
    inst.components.lootdropper:AddRandomLoot("monstermeat", 1)
    inst.components.lootdropper:AddRandomLoot("silk", 0.5)
    inst.components.lootdropper:AddRandomLoot("charcoal", 0.3)
    inst.components.lootdropper.numrandomloot = TUNING.HOTSPIDER_MIN_LOOT
    
    -- 添加死亡燃烧效果
    if not inst._old_ondeath then
        inst._old_ondeath = inst.components.health.ondeath
        inst.components.health.ondeath = function(inst)
            if TUNING.HOTSPIDER_DEATH_BURN then
                -- 播放燃烧爆炸效果
                local fx = SpawnPrefab("explode_small")
                if fx then
                    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
                
                -- 点燃周围的生物
                local burn_range = TUNING.HOTSPIDER_DEATH_BURN_RANGE
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
            if inst._old_ondeath then
                inst._old_ondeath(inst)
            end
        end
    end
end

local function OnSeasonChange(inst)
    -- 如果是永久形态，不随季节变化
    --if inst:HasTag("permanent_form") then
    --    return
    --end
    
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    
    local current_season = TheWorld.state.season
    
    if current_season == "winter" then
        if inst.AnimState:GetBuild() ~= "frostspider" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeFrostSpider)
        end
    elseif current_season == "spring" then
        if inst.AnimState:GetBuild() ~= "wetspider" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeWetSpider)
        end
    elseif current_season == "summer" then
        if inst.AnimState:GetBuild() ~= "hotspider" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeHotSpider)
        end
    else -- autumn
        if inst.AnimState:GetBuild() ~= "spider_build" then
            inst.task = inst:DoTaskInTime(math.random() * .5, BecomeNormalSpider)
        end
    end
end

local function OnWake(inst)
    -- 如果是永久形态，不随季节变化
    --if inst:HasTag("permanent_form") then
    --    return
    --end
    
    inst:WatchWorldState("season", OnSeasonChange)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
    
    local current_season = TheWorld.state.season
    
    if current_season == "winter" then
        if inst.AnimState:GetBuild() ~= "frostspider" then
            BecomeFrostSpider(inst)
        end
    elseif current_season == "spring" then
        if inst.AnimState:GetBuild() ~= "wetspider" then
            BecomeWetSpider(inst)
        end
    elseif current_season == "summer" then
        if inst.AnimState:GetBuild() ~= "hotspider" then
            BecomeHotSpider(inst)
        end
    else -- autumn
        if inst.AnimState:GetBuild() ~= "spider_build" then
            BecomeNormalSpider(inst)
        end
    end
end

local function OnSleep(inst)
    inst:StopWatchingWorldState("season", OnSeasonChange)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
    end
end

-- 修改蜘蛛的喂食逻辑
local function FeedSpider(inst, item, giver)
    if item and item:HasComponent("seasonswitcherdoodle") then
        item.components.seasonswitcherdoodle:Transform(inst, giver)
        return true
    end
    return false
end

-- 修改普通蜘蛛
AddPrefabPostInit("spider", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    
    -- 添加季节变化监听
    inst.OnEntityWake = OnWake
    inst.OnEntitySleep = OnSleep
    
    -- 添加可被喂食的功能
    if not inst.components.trader then
        inst:AddComponent("trader")
        inst.components.trader.acceptnontradable = true
        inst.components.trader:SetAcceptTest(function(inst, item)
            return item:HasTag("switcherdoodle")
        end)
        inst.components.trader.onaccept = FeedSpider
    end
    
    -- 初始检查
    -- 如果已经是永久形态，不做任何改变
    --if inst:HasTag("permanent_form") then
    --    return
    --end
    
    local current_season = TheWorld.state.season
    
    if current_season == "winter" then
        BecomeFrostSpider(inst)
    elseif current_season == "spring" then
        BecomeWetSpider(inst)
    elseif current_season == "summer" then
        BecomeHotSpider(inst)
    end
    -- 秋天保持普通形态，不需要特殊处理
end)

-- 同样修改其他类型的蜘蛛
local spider_types = {"spider_warrior", "spider_dropper", "spider_hider", "spider_spitter", "spider_moon", "spider_healer"}
for _, spider_type in ipairs(spider_types) do
    AddPrefabPostInit(spider_type, function(inst)
        if not TheWorld.ismastersim then
            return
        end
        
        -- 添加季节变化监听
        inst.OnEntityWake = OnWake
        inst.OnEntitySleep = OnSleep
        
        -- 添加可被喂食的功能
        if not inst.components.trader then
            inst:AddComponent("trader")
            inst.components.trader.acceptnontradable = true
            inst.components.trader:SetAcceptTest(function(inst, item)
                return item:HasTag("switcherdoodle")
            end)
            inst.components.trader.onaccept = FeedSpider
        end
        
        -- 初始检查
        -- 如果已经是永久形态，不做任何改变
        --if inst:HasTag("permanent_form") then
        --    return
        --end
        
        local current_season = TheWorld.state.season
        
        if current_season == "winter" then
            BecomeFrostSpider(inst)
        elseif current_season == "spring" then
            BecomeWetSpider(inst)
        elseif current_season == "summer" then
            BecomeHotSpider(inst)
        end
        -- 秋天保持普通形态，不需要特殊处理
    end)
end

-- 修改变身涂鸦的制作配方
AddRecipe2(
    "frost_switcherdoodle",
    {Ingredient("monstermeat", 2), Ingredient("silk", 2), Ingredient("ice", 4)},
    TECH.SCIENCE_ONE,
    {
        atlas = "images/inventoryimages/frost_switcherdoodle.xml",
        image = "frost_switcherdoodle.tex",
        builder_tag = "spiderwhisperer", -- 韦伯专属标签
        nounlock = false, -- 改为false，允许解锁
        numtogive = 1,
        sortkey = 1
    },
    {"SPIDER", "FOOD"} -- 添加分类标签
)

AddRecipe2(
    "wet_switcherdoodle",
    {Ingredient("monstermeat", 2), Ingredient("silk", 2), Ingredient("waterballoon", 2)},
    TECH.SCIENCE_ONE,
    {
        atlas = "images/inventoryimages/wet_switcherdoodle.xml",
        image = "wet_switcherdoodle.tex",
        builder_tag = "spiderwhisperer", -- 韦伯专属标签
        nounlock = false, -- 改为false，允许解锁
        numtogive = 1,
        sortkey = 2
    },
    {"SPIDER", "FOOD"} -- 添加分类标签
)

AddRecipe2(
    "hot_switcherdoodle",
    {Ingredient("monstermeat", 2), Ingredient("silk", 2), Ingredient("charcoal", 4)},
    TECH.SCIENCE_ONE,
    {
        atlas = "images/inventoryimages/hot_switcherdoodle.xml",
        image = "hot_switcherdoodle.tex",
        builder_tag = "spiderwhisperer", -- 韦伯专属标签
        nounlock = false, -- 改为false，允许解锁
        numtogive = 1,
        sortkey = 3
    },
    {"SPIDER", "FOOD"} -- 添加分类标签
)

-- 添加变身涂鸦的解锁条件
local function UnlockSwitcherdoodles(inst)
    if inst and inst:HasTag("player") and inst.prefab == "webber" then
        -- 解锁冰霜变身涂鸦
        if inst.components.builder and not inst.components.builder:KnowsRecipe("frost_switcherdoodle") then
            inst.components.builder:UnlockRecipe("frost_switcherdoodle")
        end
        
        -- 解锁潮湿变身涂鸦
        if inst.components.builder and not inst.components.builder:KnowsRecipe("wet_switcherdoodle") then
            inst.components.builder:UnlockRecipe("wet_switcherdoodle")
        end
        
        -- 解锁火爆变身涂鸦
        if inst.components.builder and not inst.components.builder:KnowsRecipe("hot_switcherdoodle") then
            inst.components.builder:UnlockRecipe("hot_switcherdoodle")
        end
    end
end

-- 当韦伯与季节蜘蛛交朋友时解锁对应的变身涂鸦
local function OnBecameFriends(inst, spider)
    if inst and inst.prefab == "webber" and spider then
        if spider:HasTag("frostspider") then
            if inst.components.builder and not inst.components.builder:KnowsRecipe("frost_switcherdoodle") then
                inst.components.builder:UnlockRecipe("frost_switcherdoodle")
                if inst.components.talker then
                    inst.components.talker:Say("我们可以做冰霜变身涂鸦了！")
                end
            end
        elseif spider:HasTag("wetspider") then
            if inst.components.builder and not inst.components.builder:KnowsRecipe("wet_switcherdoodle") then
                inst.components.builder:UnlockRecipe("wet_switcherdoodle")
                if inst.components.talker then
                    inst.components.talker:Say("我们可以做潮湿变身涂鸦了！")
                end
            end
        elseif spider:HasTag("hotspider") then
            if inst.components.builder and not inst.components.builder:KnowsRecipe("hot_switcherdoodle") then
                inst.components.builder:UnlockRecipe("hot_switcherdoodle")
                if inst.components.talker then
                    inst.components.talker:Say("我们可以做火爆变身涂鸦了！")
                end
            end
        end
    end
end

-- 修改韦伯，添加解锁变身涂鸦的功能
AddPrefabPostInit("webber", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    
    -- 初始解锁所有变身涂鸦（可选，如果想要玩家通过交朋友解锁，可以注释掉这行）
    inst:DoTaskInTime(0, UnlockSwitcherdoodles)
    
    -- 监听交朋友事件
    if inst.components.spiderfriender then
        local old_makefriend = inst.components.spiderfriender.MakeFriend
        inst.components.spiderfriender.MakeFriend = function(self, spider)
            local result = old_makefriend(self, spider)
            if result then
                OnBecameFriends(inst, spider)
            end
            return result
        end
    end
end)

-- 添加变身涂鸦的功能
local function OnEatSwitcherdoodle(inst, eater, switcherdoodle_type)
    if eater and eater:HasTag("spider") and not eater:HasTag("spiderqueen") then
        -- 移除现有的季节标签
        eater:RemoveTag("frostspider")
        eater:RemoveTag("wetspider")
        eater:RemoveTag("hotspider")
        
        -- 根据涂鸦类型添加新标签并应用效果
        if switcherdoodle_type == "frost" then
            -- 如果已经是冰霜蜘蛛，不做任何改变
            if eater.AnimState:GetBuild() == "frostspider" then
                return
            end
            
            -- 变为冰霜蜘蛛
            eater.AnimState:SetBuild("frostspider")
            eater:AddTag("frostspider")
            
            -- 恢复生命值
            if eater.components.health then
                eater.components.health:SetMaxHealth(TUNING.FROSTSPIDER_HEALTH)
                eater.components.health:SetPercent(1)
            end
            
            -- 设置攻击属性
            if eater.components.combat then
                eater.components.combat:SetDefaultDamage(TUNING.FROSTSPIDER_DAMAGE)
                eater.components.combat:SetAttackPeriod(TUNING.FROSTSPIDER_ATTACK_PERIOD)
                
                -- 添加冰冻攻击效果
                eater.components.combat.onhitotherfn = function(inst, target)
                    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
                        if target.components.freezable then
                            local freeze_power = TUNING.FROSTSPIDER_FREEZE_POWER
                            target.components.freezable:AddColdness(freeze_power)
                        end
                        if target.components.temperature then
                            target.components.temperature:DoDelta(-2)  -- 降低目标温度
                        end
                    end
                end
            end
            
            -- 添加冰冻抗性
            if eater.components.freezable then
                eater.components.freezable:SetResistance(4)
            end
            
            -- 播放变身特效
            local fx = SpawnPrefab("icespike_fx_1")
            if fx then
                fx.Transform:SetPosition(eater.Transform:GetWorldPosition())
            end
            
        elseif switcherdoodle_type == "wet" then
            -- 如果已经是潮湿蜘蛛，不做任何改变
            if eater.AnimState:GetBuild() == "wetspider" then
                return
            end
            
            -- 变为潮湿蜘蛛
            eater.AnimState:SetBuild("wetspider")
            eater:AddTag("wetspider")
            
            -- 恢复生命值
            if eater.components.health then
                eater.components.health:SetMaxHealth(TUNING.WETSPIDER_HEALTH)
                eater.components.health:SetPercent(1)
            end
            
            -- 设置攻击属性
            if eater.components.combat then
                eater.components.combat:SetDefaultDamage(TUNING.WETSPIDER_DAMAGE)
                eater.components.combat:SetAttackPeriod(TUNING.WETSPIDER_ATTACK_PERIOD)
                
                -- 添加潮湿攻击效果
                eater.components.combat.onhitotherfn = function(inst, target)
                    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
                        if target.components.moisture then
                            local wet_power = TUNING.WETSPIDER_WET_POWER
                            target.components.moisture:DoDelta(wet_power)
                        end
                    end
                end
            end
            
            -- 播放变身特效
            local fx = SpawnPrefab("splash_ocean")
            if fx then
                fx.Transform:SetPosition(eater.Transform:GetWorldPosition())
            end
            
        elseif switcherdoodle_type == "hot" then
            -- 如果已经是火爆蜘蛛，不做任何改变
            if eater.AnimState:GetBuild() == "hotspider" then
                return
            end
            
            -- 变为火爆蜘蛛
            eater.AnimState:SetBuild("hotspider")
            eater:AddTag("hotspider")
            
            -- 恢复生命值
            if eater.components.health then
                eater.components.health:SetMaxHealth(TUNING.HOTSPIDER_HEALTH)
                eater.components.health:SetPercent(1)
            end
            
            -- 设置攻击属性
            if eater.components.combat then
                eater.components.combat:SetDefaultDamage(TUNING.HOTSPIDER_DAMAGE)
                eater.components.combat:SetAttackPeriod(TUNING.HOTSPIDER_ATTACK_PERIOD)
                
                -- 添加燃烧攻击效果
                eater.components.combat.onhitotherfn = function(inst, target)
                    if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
                        if target.components.burnable and not target.components.burnable:IsBurning() then
                            local burn_power = TUNING.HOTSPIDER_BURN_POWER or 3
                            if math.random() < 0.3 then  -- 30%几率点燃目标
                                target.components.burnable:Ignite()
                            end
                        end
                        if target.components.temperature then
                            target.components.temperature:DoDelta(2)  -- 增加目标温度
                        end
                    end
                end
            end
            
            -- 添加冰冻抗性
            if eater.components.freezable then
                eater.components.freezable:SetResistance(8)
            end
            
            -- 播放变身特效
            local fx = SpawnPrefab("explode_small")
            if fx then
                fx.Transform:SetPosition(eater.Transform:GetWorldPosition())
            end
        end
        
        -- 清除潮湿状态
        if eater.components.moisture then
            eater.components.moisture:SetPercent(0)
        end
    end
end

-- 添加变身涂鸦的可食用组件
local function AddEdibleComponent(inst, switcherdoodle_type)
    if not TheWorld.ismastersim then
        return
    end
    
    if inst.components.edible == nil then
        inst:AddComponent("edible")
    end
    
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = -3
    inst.components.edible.hungervalue = 12.5
    inst.components.edible.sanityvalue = -10
    inst.components.edible.ismeat = true
    inst.components.edible.secondaryfoodtype = FOODTYPE.MONSTER
    
    -- 韦伯吃了不会有负面效果
    local old_GetHealth = inst.components.edible.GetHealth
    inst.components.edible.GetHealth = function(self, eater)
        if eater and eater:HasTag("spiderwhisperer") then
            return 0
        end
        return old_GetHealth(self, eater)
    end
    
    local old_GetSanity = inst.components.edible.GetSanity
    inst.components.edible.GetSanity = function(self, eater)
        if eater and eater:HasTag("spiderwhisperer") then
            return 0
        end
        return old_GetSanity(self, eater)
    end
    
    -- 添加吃后的效果
    inst.components.edible:SetOnEatenFn(function(inst, eater)
        OnEatSwitcherdoodle(inst, eater, switcherdoodle_type)
    end)
    
    -- 添加可喂食组件
    if not inst.components.perishable then
        inst:AddComponent("perishable")
        inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
        inst.components.perishable:StartPerishing()
    end
end

-- 添加冰霜变身涂鸦的功能
AddPrefabPostInit("frost_switcherdoodle", function(inst)
    AddEdibleComponent(inst, "frost")
end)

-- 添加潮湿变身涂鸦的功能
AddPrefabPostInit("wet_switcherdoodle", function(inst)
    AddEdibleComponent(inst, "wet")
end)

-- 添加火爆变身涂鸦的功能
AddPrefabPostInit("hot_switcherdoodle", function(inst)
    AddEdibleComponent(inst, "hot")
end)


