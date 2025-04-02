local assets = {
    Asset("ANIM", "anim/wet_switcherdoodle.zip"),
    Asset("ATLAS", "images/inventoryimages/wet_switcherdoodle.xml"),
    Asset("IMAGE", "images/inventoryimages/wet_switcherdoodle.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wet_switcherdoodle")
    inst.AnimState:SetBuild("wet_switcherdoodle")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")
    inst:AddTag("switcherdoodle")
    inst:AddTag("spidermutator")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wet_switcherdoodle.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 20

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = -3
    inst.components.edible.hungervalue = 12.5
    inst.components.edible.sanityvalue = -10
    inst.components.edible.ismeat = true
    inst.components.edible.secondaryfoodtype = FOODTYPE.MONSTER
    
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

    inst:AddComponent("seasonswitcherdoodle")
    inst.components.seasonswitcherdoodle:SetTargetType("wet")

    inst:AddComponent("tradable")
    
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("wet_switcherdoodle", fn, assets) 