local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data.extend({
    {
        type = "item",
        name = "robot-assembler",
        icon = "__Robot-war__/graphics/icons/robot-assembler.png",
        --hidden = true,
        subgroup = "production-machine",
        order = "i[robot-assembler]",
        place_result = "robot-assembler",
        stack_size = 10,
        weight = 2000 * kg
    },
    {
        type = "assembling-machine",
        name = "robot-assembler",
        icon = "__Robot-war__/graphics/icons/robot-assembler.png",
        flags = { "placeable-neutral", "placeable-player", "player-creation" },
        minable = { mining_time = 0.2, result = "robot-assembler" },
        max_health = 300,
        corpse = "robot-assembler-remnants",
        dying_explosion = "big-explosion",
        subgroup = "production-machine",
        order = "i[robot-assembler]",
        icon_draw_specification = { shift = { 0, -0.3 } },
        resistances =
        {
            {
                type = "fire",
                percent = 70
            }
        },
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        damaged_trigger_effect = hit_effects.entity(),
        alert_icon_shift = util.by_pixel(0, -12),
        match_animation_speed_to_activity=false,
        graphics_set =
        {
            animation =
            {
                layers =
                {
                    {
                        filename = "__Robot-war__/graphics/entities/robot-assembler.png",
                        priority = "high",
                        width = 590,
                        height = 5120/8,
                        frame_count = 80,
                        line_length = 10,
                        shift = util.by_pixel(0, -5),
                        scale = 0.15,
                        animation_speed=1
                    },
                    {
                        filename = "__Robot-war__/graphics/entities/robot-assembler-emission1.png",
                        priority = "high",
                        width = 590,
                        height = 5120/8,
                        frame_count = 80,
                        line_length = 10,
                        shift = util.by_pixel(0, -5),
                        scale = 0.15,
                        draw_as_glow=true,
                        draw_as_light=true,
                        blend_mode="additive-soft",
                        animation_speed=1
                    },
                    {
                        filename = "__Robot-war__/graphics/entities/robot-assembler-shadow.png",
                        priority = "high",
                        width = 1200,
                        height = 700,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count=80,
                        shift = util.by_pixel(0, -5),
                        scale = 0.15,
                        draw_as_shadow=true,
                        animation_speed=1
                    },
                }
            },
        },
        crafting_categories = { "robot-assembling" },
        crafting_speed = 1,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = 4 }
        },
        energy_usage = "75kW",
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        module_slots = 2,
        allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
        effect_receiver = { uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true },
        impact_category = "metal",
        working_sound =
        {
            sound = { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5 },
            fade_in_ticks = 4,
            fade_out_ticks = 20
        }
    },
})
