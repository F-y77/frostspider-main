local SeasonSwitcherdoodle = Class(function(self, inst)
    self.inst = inst
    self.target_type = nil
end)

function SeasonSwitcherdoodle:SetTargetType(target_type)
    self.target_type = target_type
end

function SeasonSwitcherdoodle:CanTransform(spider)
    -- 检查是否可以变身
    if not spider:HasTag("spider") or spider:HasTag("spiderqueen") then
        return false
    end
    
    -- 如果已经是目标类型，则不需要变身
    if (self.target_type == "frost" and spider:HasTag("frostspider")) or
       (self.target_type == "wet" and spider:HasTag("wetspider")) or
       (self.target_type == "hot" and spider:HasTag("hotspider")) then
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
        
        -- 设置攻击属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.FROSTSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.FROSTSPIDER_ATTACK_PERIOD)
            
            -- 添加冰冻攻击效果
            spider.components.combat.onhitotherfn = function(inst, target)
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
        if spider.components.freezable then
            spider.components.freezable:SetResistance(8)
        end
        
        -- 播放变身特效
        local fx = SpawnPrefab("icespike_fx_1")
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
        
        -- 设置攻击属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.WETSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.WETSPIDER_ATTACK_PERIOD)
            
            -- 添加潮湿攻击效果
            spider.components.combat.onhitotherfn = function(inst, target)
                if target and target:IsValid() and target.components.health and not target.components.health:IsDead() then
                    if target.components.moisture then
                        local wet_power = TUNING.WETSPIDER_WET_POWER or 20
                        target.components.moisture:DoDelta(wet_power)
                    end
                    if target.components.sanity then
                        target.components.sanity:DoDelta(-TUNING.WETSPIDER_SANITY_DRAIN)  -- 降低目标理智
                    end
                end
            end
        end
        
        -- 播放变身特效
        local fx = SpawnPrefab("splash_ocean")
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
        
        -- 设置攻击属性
        if spider.components.combat then
            spider.components.combat:SetDefaultDamage(TUNING.HOTSPIDER_DAMAGE)
            spider.components.combat:SetAttackPeriod(TUNING.HOTSPIDER_ATTACK_PERIOD)
            
            -- 添加燃烧攻击效果
            spider.components.combat.onhitotherfn = function(inst, target)
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
        if spider.components.freezable then
            spider.components.freezable:SetResistance(8)
        end
        
        -- 播放变身特效
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