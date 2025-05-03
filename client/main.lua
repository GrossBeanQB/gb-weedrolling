local QBCore = exports['qb-core']:GetCoreObject()
local isSmoking = false
local isRolling = false

RegisterNetEvent("gb-weedrolling:useRollingPaper", function(budName)
    if isSmoking then
        QBCore.Functions.Notify("You can't roll while smoking!", "error")
        return
    end

    if isRolling then
        return
    end

    local ped = PlayerPedId()
    local player = QBCore.Functions.GetPlayerData()

    if player.metadata["isdead"] or player.metadata["inlaststand"]
        or LocalPlayer.state.invBusy
        or IsPedArmed(ped, 6)
        or GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED")
        or IsPedRagdoll(ped)
        or IsPedFalling(ped)
        or IsPedInParachuteFreeFall(ped)
        or LocalPlayer.state.isCuffed
    then
        QBCore.Functions.Notify("Your hands are busy!", "error")
        return
    end

    if IsPedInAnyVehicle(ped, false) then
        QBCore.Functions.Notify("You can't roll a joint while driving!", "error")
        return
    end

    isRolling = true

    local animDict   = "missheistdockssetup1clipboard@base"
    local animName   = "base"
    local jointModel = "p_cs_joint_01"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    RequestModel(GetHashKey(jointModel))
    while not HasModelLoaded(GetHashKey(jointModel)) do
        Wait(10)
    end

    local jointProp = CreateObject(GetHashKey(jointModel), 0, 0, 0, true, true, true)
    AttachEntityToEntity(
        jointProp, ped,
        GetPedBoneIndex(ped, 18905),
        0.125, 0.00, 0.02,
        270.0, 20.0, 10.0,
        true, true, false, true, 1, true
    )
    TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, -1, 49, 0, false, false, false)

    QBCore.Functions.Progressbar(
        "rolling_joint",
        "Rolling a Joint...",
        7000,
        false,
        true,
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true },
        {}, {}, {},
        function()
            ClearPedTasks(ped)
            if DoesEntityExist(jointProp) then DeleteObject(jointProp) end
            isRolling = false
            TriggerServerEvent("gb-weedrolling:server:finishRolling", budName)
        end,
        function()
            ClearPedTasks(ped)
            if DoesEntityExist(jointProp) then DeleteObject(jointProp) end
            QBCore.Functions.Notify("You stopped rolling! No items were removed.", "error")
            isRolling = false
        end
    )
end)

RegisterNetEvent("gb-weedrolling:client:smokeJoint", function()
    local ped = PlayerPedId()
    if isSmoking then return end
    if isRolling then
        QBCore.Functions.Notify("You're busy rolling a joint!", "error")
        return
    end

    local player = QBCore.Functions.GetPlayerData()
    if player.metadata["isdead"] or player.metadata["inlaststand"]
        or LocalPlayer.state.invBusy
        or IsPedArmed(ped, 6)
        or GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED")
        or IsPedRagdoll(ped)
        or IsPedFalling(ped)
        or IsPedInParachuteFreeFall(ped)
        or LocalPlayer.state.isCuffed
    then
        QBCore.Functions.Notify("Your hands are busy!", "error")
        return
    end

    isSmoking = true

    local animDict = "amb@world_human_smoking@male@male_a@idle_a"
    local animName = "idle_c"
    local prop     = "p_cs_joint_01"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end

    RequestModel(prop)
    while not HasModelLoaded(prop) do
        Wait(0)
    end

    local joint = CreateObject(GetHashKey(prop), 0, 0, 0, true, true, true)
    AttachEntityToEntity(
        joint, ped,
        GetPedBoneIndex(ped, 28422),
        0.01, 0.0, 0.0,
        80.0, 0.0, 0.0,
        true, true, false, true, 1, true
    )
    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

    while not IsEntityPlayingAnim(ped, animDict, animName, 3) do
        Wait(10)
    end

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Wait(10)
    end
    UseParticleFxAsset("core")

    local fx        = StartNetworkedParticleFxLoopedOnEntity("exp_grd_bzgas_smoke", joint, 0.0, 0.0, 0.05, 0.0, 0.0, 0.0, 0.1, false, false, false)
    local smoking   = true
    local initialW  = GetSelectedPedWeapon(ped)
    local smokeTime = 15000
    local tickRate  = 250
    local elapsed   = 0

    local function dropJointOnGround(entity)
        if not DoesEntityExist(entity) then return end
        DetachEntity(entity, true, true)
        ClearPedSecondaryTask(ped)
        local coords = GetEntityCoords(entity)
        SetEntityCoords(entity, coords.x, coords.y, coords.z - 0.98, false, false, false, true)
        PlaceObjectOnGroundProperly(entity)
        SetEntityRotation(entity, 90.0, 0.0, math.random(0, 360), 2, true)
        UseParticleFxAsset("core")
        StartParticleFxNonLoopedAtCoord("exp_grd_bzgas_smoke", coords.x, coords.y, coords.z + 0.05, 0.0, 0.0, 0.0, 0.1, false, false, false)

        CreateThread(function()
            while true do
                Wait(2000)
                if #(GetEntityCoords(PlayerPedId()) - coords) > 10.0 then
                    if DoesEntityExist(entity) then DeleteObject(entity) end
                    break
                end
            end
        end)
    end

    CreateThread(function()
        while smoking and elapsed < smokeTime do
            local currentW = GetSelectedPedWeapon(ped)

            if currentW ~= initialW or IsPedArmed(ped, 6) or IsControlJustPressed(0, 73) then
                smoking = false
                QBCore.Functions.Notify("You canceled smoking.", "error")
                StopParticleFxLooped(fx, 0)
                ClearPedTasks(ped)
                dropJointOnGround(joint)
                isSmoking = false
                return
            end

            if not IsEntityPlayingAnim(ped, animDict, animName, 3) then
                smoking = false
                QBCore.Functions.Notify("You canceled smoking.", "error")
                StopParticleFxLooped(fx, 0)
                ClearPedTasks(ped)
                dropJointOnGround(joint)
                isSmoking = false
                return
            end

            Wait(tickRate)
            elapsed = elapsed + tickRate
        end

        smoking = false
        StopParticleFxLooped(fx, 0)
        ClearPedTasks(ped)
        dropJointOnGround(joint)

        isSmoking = false
        TriggerServerEvent("hud:server:RelieveStress", 15)
    end)
end)
