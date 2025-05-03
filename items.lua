local QBCore = exports['qb-core']:GetCoreObject()

local items = {
    ["rolling_paper"] = {
        name = "rolling_paper",
        label = "Rolling Paper",
        weight = 10,
        type = "item",
        image = "rolling_paper.png",
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = "Used to roll joints."
    },
    ["joint"] = {
        name = "joint",
        label = "Joint",
        weight = 10,
        type = "item",
        image = "joint.png",
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = "Rolled and ready to smoke."
    },
    ["weed_purple_haze_bud"] = {
        name = "weed_purple_haze_bud",
        label = "Purple Haze Bud",
        weight = 10,
        type = "item",
        image = "purple_haze.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Some potent Purple Haze."
    },
    ["weed_og_kush_bud"] = {
        name = "weed_og_kush_bud",
        label = "OG Kush Bud",
        weight = 10,
        type = "item",
        image = "og_kush.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Classic OG Kush strain."
    },
    ["weed_amnesia_bud"] = {
        name = "weed_amnesia_bud",
        label = "Amnesia Bud",
        weight = 10,
        type = "item",
        image = "amnesia.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Amnesia strain — very strong."
    },
    ["weed_ak47_bud"] = {
        name = "weed_ak47_bud",
        label = "AK-47 Bud",
        weight = 10,
        type = "item",
        image = "ak47.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Strong AK-47 hybrid bud."
    },
    ["weed_skunk_bud"] = {
        name = "weed_skunk_bud",
        label = "Skunk Bud",
        weight = 10,
        type = "item",
        image = "skunk.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Skunky and pungent bud."
    },
    ["weed_white_widow_bud"] = {
        name = "weed_white_widow_bud",
        label = "White Widow Bud",
        weight = 10,
        type = "item",
        image = "white_widow.png",
        unique = false,
        useable = false,
        shouldClose = true,
        combinable = nil,
        description = "Famous White Widow strain."
    }
}

CreateThread(function()
    for k, v in pairs(items) do
        QBCore.Shared.Items[k] = v
    end
end)
