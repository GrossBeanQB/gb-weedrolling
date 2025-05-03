gb-weedrolling

Dear QBCore community,Here's another gift — a lightweight, plug-and-play rolling and smoking system fully integrated with the QBCore framework.

This script allows players to roll and smoke joints in a realistic, immersive way — complete with joint props, puffing animation, cancel behavior, and stress relief support. It’s been designed to be modular, optimized, and easy to customize.

How to Test

To try it out quickly on your server:

/giveitem  weed_og_kush_bud 1/giveitem  rolling_paper 1

Then open your inventory and use the rolling_paper to roll a joint.Once rolled, use the joint item to smoke it.

Features

Roll joints using any defined bud + rolling paper

Smoke joints to relieve 15 stress

Includes full animation, particle FX, and prop

You cannot roll or smoke if:

You're armed

You're eating or drinking (progressbar)

You're injured, dead, cuffed, ragdolled, or falling

You're already rolling or already smoking

Smoking cancels if:

You pull out a weapon

You press X (hands up)

You interrupt the animation

You do anything else that breaks focus

Joint is dropped on the ground when canceled

Items Included

No need to edit qb-core/shared/items.lua.This script defines its own items dynamically:

rolling_paper

joint

Supported weed buds:

weed_og_kush_bud

weed_purple_haze_bud

weed_amnesia_bud

weed_ak47_bud

weed_skunk_bud

weed_white_widow_bud

Paste pictures from "images" folder into qb-inventory/html/images.

Installation

Place this folder inside resources/, for example:
resources/[local]/gb-weedrolling


That’s it. The script handles its own config and items.

Config

Strains are set in config.lua:
Config.Buds = {
"weed_og_kush_bud",
"weed_purple_haze_bud",
...
}

Items are injected automatically in items.lua.

Credits

Made for the QBCore community with love <3 .Enjoy and blaze responsibly. 🌿
