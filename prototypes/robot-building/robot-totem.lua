local robot_totem_item = {
    type = "item",
    name = "robot-totem",
    icon = "__space-age__/graphics/icons/lightning-collector.png",
    hidden = true,
    subgroup = "other",
    order = "c[item]-o[infinity-chest]",
    stack_size = 10,
    place_result = "robot-totem"
}

local robot_totem = util.table.deepcopy(data.raw["container"]["steel-chest"])
robot_totem.name = "robot-totem"
robot_totem.icon = "__space-age__/graphics/icons/lightning-collector.png"
robot_totem.max_health = 1000
robot_totem.is_military_target = false
robot_totem.hidden = true
robot_totem.inventory_size = 1
--robot_totem.collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } }
--obot_totem.selection_box = { { -1, -1 }, { 1, 1 } }
robot_totem.erase_contents_when_mined = true
robot_totem.preserve_contents_when_created = true
robot_totem.minable = { mining_time = 0.1, result = "robot-totem" }
robot_totem.picture =
{
    layers =
    {
        util.sprite_load("__Robot-war__/graphics/entities/robot-totem",
            {
                priority = "high",
                scale = 0.5,
                repeat_count = repeat_count
            }),
        util.sprite_load("__space-age__/graphics/entity/lightning-collector/lightning-collector-shadow",
            {
                priority = "high",
                draw_as_shadow = true,
                scale = 0.5,
                repeat_count = repeat_count
            })
    }
}
robot_totem.resistances = {}
robot_totem.corpse = "lightning-collector-remnants"
robot_totem.dying_explosion = "substation-explosion"
table.insert(robot_totem.flags, "no-automated-item-removal")
table.insert(robot_totem.flags, "no-automated-item-insertion")
data:extend({ robot_totem_item, robot_totem })


data:extend({
    --[[{
    type = "item",
    name = "robot-shield",
    icon = "__base__/graphics/icons/wooden-chest.png",
    hidden = true,
    subgroup = "other",
    order = "c[item]-o[infinity-chest]",
    stack_size = 10,
    place_result = "robot-shield"
},]]
    {
        type = "simple-entity-with-force",
        name = "robot-shield",
        flags = { "not-on-map" },
        collision_box = { { -1, -1 }, { 1, 1 } },
        selection_box = { { -1, -1 }, { 1, 1 } },
        collision_mask = {
            layers = {
                object = true,
                player = true,
                item = true,
                train = true,
                is_object = true,
                robot_shield = true
            }
        },
        resistances = {},
        selectable_in_game = lihop_debug,
        render_layer = "object",
        animations = {
            {
                filename = "__Robot-war__/graphics/entities/wall2.png",
                priority = "high",
                width = 512,
                height = 384,
                frame_count = 12,
                line_length = 4,
                --shift = util.by_pixel(0, -5),
                scale = 0.3,
                draw_as_glow = true,
                draw_as_light = true,
                blend_mode = "additive-soft",
                run_mode="forward-then-backward",
                animation_speed = 0.1
            },
        },

    }
})
