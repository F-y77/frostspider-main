local SeasonSwitcherdoodle = Class(function(self, inst)
    self.inst = inst
    self.target_type = nil
end)

function SeasonSwitcherdoodle:SetTargetType(type)
    self.target_type = type
end

function SeasonSwitcherdoodle:CanTransform(spider)
    -- 检查是否是蜘蛛
    if not spider:HasTag("spider") then
        return false
    end
    
    -- 检查是否已经是目标类型
    if self.target_type == "frost" and spider:HasTag("frostspider") then
        return false
    elseif self.target_type == "wet" and spider:HasTag("wetspider") then
        return false
    elseif self.target_type == "hot" and spider:HasTag("hotspider") then
        return false
    end
    
    return true
end

function SeasonSwitcherdoodle:Transform(spider, giver)
    if not self:CanTransform(spider) then
        return false
    end
    
    -- 移除现有的季节标签
    spider:RemoveTag("frostspider")
    spider:RemoveTag("wetspider")
    spider:RemoveTag("hotspider")
    
    -- 添加永久形态标记，防止季节变化影响
    spider:AddTag("permanent_form")
    
    -- 根据目标类型应用变身效果
    if self.target_type == "frost" then
        -- 变为冰霜蜘蛛
        spider.AnimState:SetBuild("frostspider")
        spider:AddTag("frostspider")
        
        -- 恢复生命值
        if spider.components.health then
            spider.components.health:SetMaxHealth(TUNING.FROSTSPIDER_HEALTH)
            spider.components.health:SetPercent(1)
        end
        
        -- 更新战斗属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.FROSTSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.FROSTSPIDER_ATTACK_PERIOD)
        end
        
        -- 添加冰冻效果
        if spider.components.combat and not spider.components.combat.onhitotherfn_old then
            spider.components.combat.onhitotherfn_old = spider.components.combat.onhitotherfn
            spider.components.combat.onhitotherfn = function(inst, other, damage)
                if other and other.components.freezable then
                    other.components.freezable:AddColdness(1)
                    other.components.freezable:SpawnShatterFX()
                end
                if spider.components.combat.onhitotherfn_old then
                    return spider.components.combat.onhitotherfn_old(inst, other, damage)
                end
            end
        end
        
        -- 添加死亡效果
        if spider.components.health and not spider.components.health.ondeath_old then
            spider.components.health.ondeath_old = spider.components.health.ondeath
            spider.components.health.ondeath = function(inst, data)
                local fx = SpawnPrefab("shatter")
                if fx then
                    fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
                end
                if spider.components.health.ondeath_old then
                    return spider.components.health.ondeath_old(inst, data)
                end
            end
        end
        
        -- 添加冰冻抗性
        if spider.components.freezable then
            spider.components.freezable:SetResistance(4)
        end
        
        -- 添加温度调节
        if spider.components.temperature then
            spider.components.temperature.mintemp = -20
            spider.components.temperature.maxtemp = 10
        end
        
        -- 特效
        local fx = SpawnPrefab("shatter")
        if fx then
            fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
        end
    elseif self.target_type == "wet" then
        -- 变为潮湿蜘蛛
        spider.AnimState:SetBuild("wetspider")
        spider:AddTag("wetspider")
        
        -- 恢复生命值
        if spider.components.health then
            spider.components.health:SetMaxHealth(TUNING.WETSPIDER_HEALTH)
            spider.components.health:SetPercent(1)
        end
        
        -- 更新战斗属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.WETSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.WETSPIDER_ATTACK_PERIOD)
        end
        
        -- 添加潮湿效果
        if spider.components.combat and not spider.components.combat.onhitotherfn_old then
            spider.components.combat.onhitotherfn_old = spider.components.combat.onhitotherfn
            spider.components.combat.onhitotherfn = function(inst, other, damage)
                if other and other.components.moisture then
                    other.components.moisture:DoDelta(10)
                end
                if spider.components.combat.onhitotherfn_old then
                    return spider.components.combat.onhitotherfn_old(inst, other, damage)
                end
            end
        end
        
        -- 添加死亡效果
        if spider.components.health and not spider.components.health.ondeath_old then
            spider.components.health.ondeath_old = spider.components.health.ondeath
            spider.components.health.ondeath = function(inst, data)
                local fx = SpawnPrefab("splash")
                if fx then
                    fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
                end
                if spider.components.health.ondeath_old then
                    return spider.components.health.ondeath_old(inst, data)
                end
            end
        end
        
        -- 添加潮湿抗性
        if spider.components.moisture then
            spider.components.moisture.waterproofness = 1
        end
        
        -- 特效
        local fx = SpawnPrefab("splash")
        if fx then
            fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
        end
    elseif self.target_type == "hot" then
        -- 变为火爆蜘蛛
        spider.AnimState:SetBuild("hotspider")
        spider:AddTag("hotspider")
        
        -- 恢复生命值
        if spider.components.health then
            spider.components.health:SetMaxHealth(TUNING.HOTSPIDER_HEALTH)
            spider.components.health:SetPercent(1)
        end
        
        -- 更新战斗属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.HOTSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.HOTSPIDER_ATTACK_PERIOD)
        end
        
        -- 添加燃烧效果
        if spider.components.combat and not spider.components.combat.onhitotherfn_old then
            spider.components.combat.onhitotherfn_old = spider.components.combat.onhitotherfn
            spider.components.combat.onhitotherfn = function(inst, other, damage)
                if other and other.components.burnable and not other.components.burnable:IsBurning() then
                    other.components.burnable:Ignite()
                end
                if spider.components.combat.onhitotherfn_old then
                    return spider.components.combat.onhitotherfn_old(inst, other, damage)
                end
            end
        end
        
        -- 添加死亡效果
        if spider.components.health and not spider.components.health.ondeath_old then
            spider.components.health.ondeath_old = spider.components.health.ondeath
            spider.components.health.ondeath = function(inst, data)
                local fx = SpawnPrefab("explode_small")
                if fx then
                    fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
                end
                if spider.components.health.ondeath_old then
                    return spider.components.health.ondeath_old(inst, data)
                end
            end
        end
        
        -- 添加火焰抗性
        if spider.components.health then
            spider.components.health.fire_damage_scale = 0
        end
        
        -- 添加温度调节
        if spider.components.temperature then
            spider.components.temperature.mintemp = 10
            spider.components.temperature.maxtemp = 90
        end
        
        -- 特效
        local fx = SpawnPrefab("explode_small")
        if fx then
            fx.Transform:SetPosition(spider.Transform:GetWorldPosition())
        end
    end
    
    -- 清除潮湿状态
    if spider.components.moisture then
        spider.components.moisture:SetPercent(0)
    end
    
    -- 消耗物品
    if self.inst.components.stackable then
        self.inst.components.stackable:Get():Remove()
    else
        self.inst:Remove()
    end
    
    return true
end

return SeasonSwitcherdoodle 