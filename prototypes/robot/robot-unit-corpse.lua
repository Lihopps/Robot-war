local robot_util=require("prototypes.robot.robot-util")

data.extend({
    {
        type = "corpse",
        name = "robot-unit-corpse",
        icon = "__base__/graphics/icons/small-spitter-corpse.png",
        selectable_in_game = false,
        selection_box = { { -1, -1 }, { 1, 1 } },
        subgroup = "corpses",
        order = "c[corpse]-b[spitter]-a[small]",
        hidden_in_factoriopedia = true,
        flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" },
        animation = robot_util.corpse(0.5),
        --decay_animation = ,
        decay_frame_transition_duration = 6 * 60,
        use_decay_layer = true,
        --dying_speed = (1 / 25) * (0.27 + 0.1 / scale),
        time_before_removed = 15 * 60 * 60,
        direction_shuffle = { { 1, 1,  }},
        shuffle_directions_at_frame = 0,
        final_render_layer = "lower-object-above-shadow",

        --ground_patch_render_layer = "decals", -- "transport-belt-integration"
        --ground_patch_fade_in_delay = 1 / 0.02, --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
        --ground_patch_fade_in_speed = 0.002,
        --ground_patch_fade_out_start = 50 * 60,
        --ground_patch_fade_out_duration = 20 * 60,


        
    },
    {
        type = "corpse",
        name = "robot-unit-big-corpse",
        icon = "__base__/graphics/icons/medium-spitter-corpse.png",
        selectable_in_game = false,
        selection_box = { { -1, -1 }, { 1, 1 } },
        subgroup = "corpses",
        order = "c[corpse]-b[spitter]-a[small]",
        hidden_in_factoriopedia = true,
        flags = { "placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map" },
        animation = robot_util.corpse(1),
        --decay_animation = ,
        decay_frame_transition_duration = 6 * 60,
        use_decay_layer = true,
        --dying_speed = (1 / 25) * (0.27 + 0.1 / scale),
        time_before_removed = 15 * 60 * 60,
        direction_shuffle = { { 1, 1,  }},
        shuffle_directions_at_frame = 0,
        final_render_layer = "lower-object-above-shadow",

        --ground_patch_render_layer = "decals", -- "transport-belt-integration"
        --ground_patch_fade_in_delay = 1 / 0.02, --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
        --ground_patch_fade_in_speed = 0.002,
        --ground_patch_fade_out_start = 50 * 60,
        --ground_patch_fade_out_duration = 20 * 60,


        
    }

})
