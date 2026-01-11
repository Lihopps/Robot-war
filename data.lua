lihop_debug = false

require("prototypes.sprite")
require("prototypes.enemies.replicateur")
require("prototypes.entities.logistics.station")


require("prototypes.asura.tile")
--[[



require("prototypes.autoplace-controls")
require("prototypes.robot-building.asura-bases-proxy")
require("prototypes.robot-building.robot-spawner")
require("prototypes.robot-building.robot-assembler")
require("prototypes.robot-building.robot-generator")
require("prototypes.robot-building.robot-chest-provider")
require("prototypes.robot-building.robot-totem")
require("prototypes.remnants")
require("prototypes.asuras.asuras")
require("prototypes.asuras.resources")
require("prototypes.robot.robot-unit")
require("prototypes.categories.categories")
require("prototypes.items")
require("prototypes.recipe")
require("prototypes.entities")
require("prototypes.sprite")
require("prototypes.technology")

require("prototypes.tips-and-tricks")
]]

if lihop_debug then
    for name, prototype in pairs(data.raw["space-connection"]) do
        prototype.length = 2000
    end
    data.extend({
        {
            type = "shortcut",
            name = "savebp",
            --order = "c[toggles]-a[roboport]",
            action = "lua",
            localised_name = "Bp reader",
            unavailable_until_unlocked = false,
            icon = "__base__/graphics/icons/steam-engine.png",
            icon_size = 64,
            small_icon = "__base__/graphics/icons/steam-engine.png",
            small_icon_size = 64
        },
    })
end
