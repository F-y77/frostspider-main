local assets = {
    Asset("ANIM", "anim/frost_switcherdoodle.zip"),
    Asset("ATLAS", "images/inventoryimages/frost_switcherdoodle.xml"),
    Asset("IMAGE", "images/inventoryimages/frost_switcherdoodle.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("frost_switcherdoodle")
    inst.AnimState:SetBuild("frost_switcherdoodle")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("preparedfood")
    inst:AddTag("switcherdoodle")

    MakeInventoryFloatable(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/frost_switcherdoodle.xml"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = 20

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("frost_switcherdoodle", fn, assets) 