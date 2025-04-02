name = "󰀗季节性蜘蛛󰀗"
description = [[

󰀗添加三种新的蜘蛛敌人 - 冰霜蜘蛛、潮湿蜘蛛和火爆蜘蛛。

󰀗所有的普通蜘蛛会在冬天变成冰霜蜘蛛，春天变成潮湿蜘蛛，夏天变成火爆蜘蛛，秋天则保持普通形态但属性增强。

󰀗每种蜘蛛都有独特的攻击方式和死亡效果。

󰀗韦伯可以驯服所有的蜘蛛并为你作战，攻击BUFF转移到敌人身上。

󰀗特别提醒：小心夏天的火爆蜘蛛把家烧了，春天的潮湿蜘蛛让你一直掉San，冬天的冰霜蜘蛛两个强控，秋天蜘蛛进行了加强。

󰀗如果想要永远不随季节改变的模组蜘蛛，可以打开控制台进行刷新。"

]]
author = "凌"
version = "2.5"
api_version = 10

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
    "季节性蜘蛛",
    "凌",
}

-- 配置选项
configuration_options = {
    {
        name = "frostspider_health",
        label = "冰霜蜘蛛生命值",
        options = {
            {description = "低 (80)", data = 80},
            {description = "默认 (100)", data = 100},
            {description = "高 (120)", data = 120},
            {description = "很高 (150)", data = 150},
        },
        default = 100,
    },
    {
        name = "frostspider_damage",
        label = "冰霜蜘蛛伤害",
        options = {
            {description = "低 (15)", data = 15},
            {description = "默认 (20)", data = 20},
            {description = "高 (25)", data = 25},
            {description = "很高 (30)", data = 30},
        },
        default = 20,
    },
    {
        name = "frostspider_freeze_power",
        label = "冰霜蜘蛛冻结强度",
        options = {
            {description = "低 (1)", data = 1},
            {description = "默认 (3)", data = 3},
            {description = "高 (5)", data = 5},
        },
        default = 3,
    },
    {
        name = "wetspider_health",
        label = "潮湿蜘蛛生命值",
        options = {
            {description = "低 (70)", data = 70},
            {description = "默认 (90)", data = 90},
            {description = "高 (110)", data = 110},
        },
        default = 90,
    },
    {
        name = "wetspider_damage",
        label = "潮湿蜘蛛伤害",
        options = {
            {description = "低 (10)", data = 10},
            {description = "默认 (15)", data = 15},
            {description = "高 (20)", data = 20},
        },
        default = 15,
    },
    {
        name = "wetspider_wet_power",
        label = "潮湿蜘蛛湿度效果",
        options = {
            {description = "低 (20)", data = 20},
            {description = "默认 (30)", data = 30},
            {description = "高 (40)", data = 40},
        },
        default = 30,
    },
    {
        name = "wetspider_death_wet",
        label = "潮湿蜘蛛死亡湿润效果",
        options = {
            {description = "开启", data = true},
            {description = "关闭", data = false},
        },
        default = true,
    },
    {
        name = "hotspider_health",
        label = "火爆蜘蛛生命值",
        options = {
            {description = "低 (100)", data = 100},
            {description = "默认 (120)", data = 120},
            {description = "高 (140)", data = 140},
            {description = "很高 (160)", data = 160},
        },
        default = 120,
    },
    {
        name = "hotspider_damage",
        label = "火爆蜘蛛伤害",
        options = {
            {description = "低 (20)", data = 20},
            {description = "默认 (25)", data = 25},
            {description = "高 (30)", data = 30},
            {description = "很高 (35)", data = 35},
        },
        default = 25,
    },
    {
        name = "hotspider_death_burn",
        label = "火爆蜘蛛死亡燃烧效果",
        options = {
            {description = "开启", data = true},
            {description = "关闭", data = false},
        },
        default = true,
    },
    {
        name = "autumn_spider_health_mult",
        label = "秋季蜘蛛生命值倍率",
        options = {
            {description = "无增强 (1.0)", data = 1.0},
            {description = "轻微增强 (1.1)", data = 1.1},
            {description = "中等增强 (1.2)", data = 1.2},
            {description = "显著增强 (1.3)", data = 1.3},
        },
        default = 1.2,
    },
    {
        name = "autumn_spider_damage_mult",
        label = "秋季蜘蛛伤害倍率",
        options = {
            {description = "无增强 (1.0)", data = 1.0},
            {description = "轻微增强 (1.1)", data = 1.1},
            {description = "中等增强 (1.2)", data = 1.2},
            {description = "显著增强 (1.3)", data = 1.3},
        },
        default = 1.2,
    },
    {
        name = "autumn_spider_speed_mult",
        label = "秋季蜘蛛速度倍率",
        options = {
            {description = "无增强 (1.0)", data = 1.0},
            {description = "轻微增强 (1.1)", data = 1.1},
            {description = "中等增强 (1.2)", data = 1.2},
        },
        default = 1.1,
    },
}
