local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")


local robot=table.deepcopy(data.raw["logistic-robot"]["logistic-robot"])
robot.name="rw-transporter"
robot.minable = {mining_time = 0.1, result = "rw-transporter"}
robot.max_payload_size = 200


data.extend({
    robot,
     {
    type = "item",
    name = "rw-transporter",
    icon = "__base__/graphics/icons/requester-chest.png",
    subgroup = "logistic-network",
    color_hint = { text = "R" },
    order = "b[storage]-e[requester-chest]",
    inventory_move_sound = item_sounds.metal_chest_inventory_move,
    pick_sound = item_sounds.metal_chest_inventory_pickup,
    drop_sound = item_sounds.metal_chest_inventory_move,
    place_result = "rw-transporter",
    stack_size = 1,
    spoil_ticks=150,
    spoil_to_trigger_result={
        items_per_trigger=1,
        trigger={
            type="direct",
            action_delivery={
                type="instant",
                source_effects={
                    type="create-entity",
                    entity_name="multiplicator",
                    as_enemy=true,
                    ignore_no_enemies_mode=true,
                    find_non_colliding_position=true,
                    non_colliding_search_radius=20
                }
            }
        }
    }

  },
})