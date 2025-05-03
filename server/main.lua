local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("rolling_paper", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    local foundBud
    for _, bud in pairs(Config.Buds) do
        local invItem = Player.Functions.GetItemByName(bud)
        if invItem and invItem.amount > 0 then
            foundBud = bud
            break
        end
    end

    if foundBud then
        TriggerClientEvent("gb-weedrolling:useRollingPaper", source, foundBud)
    else
        TriggerClientEvent('QBCore:Notify', source, "You don't have any weed to roll!", "error")
    end
end)

RegisterNetEvent("gb-weedrolling:server:finishRolling", function(budName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if Player.Functions.RemoveItem(budName, 1) and Player.Functions.RemoveItem("rolling_paper", 1) then
            Player.Functions.AddItem("joint", 1)
            TriggerClientEvent('QBCore:Notify', src, "You rolled a joint!", "success")
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["joint"], "add")
        else
            TriggerClientEvent('QBCore:Notify', src, "Something went wrong while rolling!", "error")
        end
    end
end)

QBCore.Functions.CreateUseableItem("joint", function(source, item)
    TriggerClientEvent("gb-weedrolling:client:smokeJoint", source)
end)
