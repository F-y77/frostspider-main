name = "冰霜蜘蛛"
description = "添加一种新的蜘蛛敌人 - 冰霜蜘蛛，它们会对敌人造成冰冻伤害，群体攻击十分难打，死后爆炸范围冰冻效果。"
author = "凌"
version = "1.2"

-- 兼容性
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

-- 客户端/服务器兼容性
client_only_mod = false
all_clients_require_mod = true

-- 图标
icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- mod标签
server_filter_tags = {
    "冰霜蜘蛛",
    "凌",
}

-- 配置选项
configuration_options = {
    {
        name = "frostspider_health",
        label = "冰霜蜘蛛生命值",
        options = {
            {description = "低 (75)", data = 75},
            {description = "默认 (100)", data = 100},
            {description = "高 (150)", data = 150},
            {description = "很高 (200)", data = 200},
        },
        default = 75,
    },
    {
        name = "frostspider_damage",
        label = "冰霜蜘蛛攻击力",
        options = {
            {description = "低 (15)", data = 15},
            {description = "默认 (20)", data = 20},
            {description = "高 (30)", data = 30},
            {description = "很高 (40)", data = 40},
        },
        default = 15,
    },
    {
        name = "frostspider_freeze_power",
        label = "冰冻效果强度",
        options = {
            {description = "弱 (2)", data = 2},
            {description = "默认 (3)", data = 3},
            {description = "强 (4)", data = 4},
            {description = "很强 (5)", data = 5},
        },
        default = 2,
    },
    {
        name = "frostspider_target_dist",
        label = "冰霜蜘蛛视野攻击距离",
        options = {
            {description = "近 (6)", data = 6},
            {description = "默认 (10)", data = 10},
            {description = "远 (15)", data = 15},
            {description = "很远 (20)", data = 20},
        },
        default = 10,
    },
    {
        name = "frostspider_attack_period",
        label = "冰霜蜘蛛攻击间隔",
        options = {
            {description = "慢 (1)", data = 1},
            {description = "默认 (2)", data = 2},
            {description = "快 (3)", data = 3},
            {description = "很快 (4)", data = 4},
        },
        default = 2,
    },
    {
        name = "frostspider_min_loot",
        label = "冰霜蜘蛛最少掉落物数量",
        options = {
            {description = "1个", data = 1},
            {description = "2个", data = 2},
            {description = "3个", data = 3},
            {description = "4个", data = 4},
        },
        default = 2,
    },
    {
        name = "frostspider_death_freeze",
        label = "死亡冰冻效果",
        options = {
            {description = "开启", data = true},
            {description = "关闭", data = false},
        },
        default = true,
    },
    {
        name = "frostspider_death_freeze_range",
        label = "死亡冰冻范围",
        options = {
            {description = "小 (2)", data = 2},
            {description = "中 (3)", data = 3},
            {description = "大 (4)", data = 4},
            {description = "很大 (5)", data = 5},
        },
        default = 2,
    },
} 