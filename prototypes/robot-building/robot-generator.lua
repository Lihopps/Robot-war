data:extend({
    {
    type = "item",
    name = "robot-generator",
    icon = "__Robot-war__/graphics/icons/robot-reactor.png",
    hidden = true,
    subgroup = "other",
    order = "c[item]-o[infinity-chest]",
    stack_size = 10,
    place_result = "robot-generator"
  },
    {
        name = "robot-generator",
        type = "burner-generator",
        icon = "__Robot-war__/graphics/icons/robot-reactor.png",
        flags = { "placeable-neutral", "player-creation" },
        hidden = true,
        max_health = 400,
        dying_explosion = "big-explosion",
        corpse = "big-remnants",
        collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        max_power_output = "100MW",
        minable = { mining_time = 1, result = "robot-generator" },
        
        animation =
            {
                layers =
                {
                    {
                        filename = "__Robot-war__/graphics/entities/robot-reactor.png",
                        priority = "high",
                        width = 3200/8,
                        height = 3200/8,
                        frame_count = 60,
                        line_length = 8,
                        --shift = util.by_pixel(0, 2),
                        scale = 0.35
                    },
                     {
                        filename = "__Robot-war__/graphics/entities/robot-reactor-emmision.png",
                        priority = "high",
                        width = 3200/8,
                        height = 3200/8,
                        frame_count = 60,
                        line_length = 8,
                        draw_as_glow=true,
                        blend_mode="additive-soft",
                        --shift = util.by_pixel(0, 2),
                        scale = 0.35
                    },
                     {
                        filename = "__Robot-war__/graphics/entities/robot-reactor-shadow.png",
                        priority = "high",
                        width = 700,
                        height = 600,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count=60,
                        draw_as_shadow=true,
                        --shift = util.by_pixel(0, 2),
                        scale = 0.35
                    },
                }
            },
        -- idle_animation can also be specified
        perceived_performance = { minimum = 1, performance_to_activity_rate = 1 },
        burner =
        {
            type = "burner",
            fuel_categories = { "robot-fuel" },
            effectivity = 1,
            fuel_inventory_size = 1,
            emissions_per_minute = { pollution = 50 },
            --smoke ={}
        },
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-output"
        }
    } })
