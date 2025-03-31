GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

-- 添加预制体
PrefabFiles = {
    "frostspider"
}

-- 添加资源文件路径
Assets = {
    Asset("ANIM", "anim/ds_spider_basic.zip"),
    Asset("ANIM", "anim/spider_build.zip"),
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

