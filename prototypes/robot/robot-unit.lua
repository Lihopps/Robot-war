require("prototypes.robot.robot-unit-corpse")
local robot_util = require("prototypes.robot.robot-util")


data.extend({
    {
        type = "unit",
        name = "robot-unit",
        flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
        max_health = 200,
        order = "t-b",
        subgroup = "enemies",
        --factoriopedia_simulation = simulations.factoriopedia_small_spitter,
        impact_category = "metal",
        has_belt_immunity = true,
        resistances = robot_util.resistance(90),
        healing_per_tick = 0.05,
        collision_box = { { -0.2, -0.2 }, { 0.2, 0.2 } },
        selection_box = { { -0.4, -1.4 }, { 0.4, 0.2 } },
        hit_visualization_box = { { -0.2, -1.1 }, { 0.2, 0.2 } },
        sticker_box = { { -0.2, -1 }, { 0.2, 0 } },
        distraction_cooldown = 300,
        min_pursue_time = 10 * 60,
        max_pursue_distance = 50,
        loot =
        {
            {
                item = "neural-matrix",
                probability = 0.001,
                count_min = 1,
                count_max = 1,
            }
        },
        move_while_shooting = true,
        can_open_gates = true,
        radar_range=1,
        attack_parameters = {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 6,
            animation = robot_util.run_anim(0.5),
            movement_slow_down_factor = 0.7,
            shell_particle =
            {
                name = "shell-particle",
                direction_deviation = 0.1,
                speed = 0.1,
                speed_deviation = 0.03,
                center = { 0, 0.1 },
                creation_distance = -0.5,
                starting_frame_speed = 0.4,
                starting_frame_speed_deviation = 0.1
            },
            projectile_creation_distance = 1.125,
            range = 18,
            ammo_type =
            {
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "instant",
                        source_effects =
                        {
                            type = "create-explosion",
                            entity_name = "explosion-gunshot"
                        },
                        target_effects =
                        {
                            {
                                type = "create-entity",
                                entity_name = "explosion-hit",
                                offsets = { { 0, 1 } },
                                offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } }
                            },
                            {
                                type = "damage",
                                damage = { amount = 12, type = "physical" }
                            },
                            {
                                type = "activate-impact",
                                deliver_category = "bullet"
                            }
                        }
                    }
                }
            }
            --sound = sounds.submachine_gunshot
        },
        vision_distance = 30,
        movement_speed = 0.30,
        distance_per_frame = 0.26,
        -- in pu
        absorptions_to_join_attack = { pollution = 4 },
        corpse = "robot-unit-corpse",
        dying_explosion = "medium-explosion",
        run_animation = robot_util.run_anim(0.5),
        --walking_sound = sounds.spitter_walk(0, 0.3),
        --ai_settings = biter_ai_settings,
    },
    {
        type = "unit",
        name = "robot-unit-big",
        flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable" },
        max_health = 500,
        order = "t-c",
        subgroup = "enemies",
        --factoriopedia_simulation = simulations.factoriopedia_small_spitter,
        impact_category = "metal",
        has_belt_immunity = true,
        resistances = robot_util.resistance(100),
        healing_per_tick = 0.1,
        collision_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
        selection_box = { { -0.8, -2.8 }, { 0.8, 0.4 } },
        hit_visualization_box = { { -0.4, -2.2 }, { 0.4, 0.4 } },
        distraction_cooldown = 300,
        min_pursue_time = 10 * 60,
        max_pursue_distance = 50,
        loot =
        {
            {
                item = "neural-matrix",
                probability = 0.005,
                count_min = 1,
                count_max = 1,
            }
        },
        move_while_shooting = true,
        can_open_gates = true,
        radar_range=2,
        attack_parameters =
        {
            type = "projectile",
            ammo_category = "rocket",
            movement_slow_down_factor = 1,
            cooldown = 45,
            animation = robot_util.run_anim(1),
            projectile_creation_distance = 0.6,
            range = 26,
            projectile_center = { -0.17, 0 },
            sound =
            {
                filename = "__base__/sound/fight/rocket-launcher.ogg",
                volume = 0.7,
                modifiers = volume_multiplier("main-menu", 0.9)
            },

            --sound = sounds.submachine_gunshot
            ammo_type =
            {
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "projectile",
                        projectile = "rocket",
                        starting_speed = 0.1,
                        source_effects =
                        {
                            type = "create-entity",
                            entity_name = "explosion-hit"
                        }
                    }
                }
            },

        },
        vision_distance = 30,
        movement_speed = 0.60,
        distance_per_frame = 0.52,
        -- in pu
        absorptions_to_join_attack = { pollution = 4 },
        corpse = "robot-unit-big-corpse",
        dying_explosion = "big-explosion",
        run_animation = robot_util.run_anim(1),
        --walking_sound = sounds.spitter_walk(0, 0.3),
        --ai_settings = biter_ai_settings,
    },

})


