local sounds = require("__base__.prototypes.entity.sounds")

data.extend({
    {
    type = "projectile",
    name = "asura-nanite-capsule",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0.005,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-smoke",
              show_in_tooltip = true,
              entity_name = "asura-nanite-cloud",
              initial_height = 0
            },
            {
              type = "create-particle",
              particle_name = "poison-capsule-metal-particle",
              repeat_count = 8,
              initial_height = 1,
              initial_vertical_speed = 0.1,
              initial_vertical_speed_deviation = 0.05,
              offset_deviation = {{-0.1, -0.1}, {0.1, 0.1}},
              speed_from_center = 0.05,
              speed_from_center_deviation = 0.01
            }
          }
        }
      }
    },
    --light = {intensity = 0.5, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
      draw_as_glow = true,
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 58,
      height = 59,
      shift = util.by_pixel(1, 0.5),
      priority = "high",
      scale = 0.5
    },
    shadow =
    {
      filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
      frame_count = 16,
      line_length = 8,
      animation_speed = 0.250,
      width = 54,
      height = 42,
      shift = util.by_pixel(1, 2),
      priority = "high",
      draw_as_shadow = true,
      scale = 0.5
    },
    smoke =
    {
      {
        name = "poison-capsule-smoke",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 0},
        starting_frame = 3,
        starting_frame_deviation = 5,
      }
    }
  },
    {
    name = "asura-nanite-cloud",
    type = "smoke-with-trigger",
    flags = {"not-on-map"},
    hidden = true,
    show_when_smoke_off = true,
    particle_count = 16,
    particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
    particle_distance_scale_factor = 0.5,
    particle_scale_factor = { 1, 0.707 },
    wave_speed = { 1/80, 1/60 },
    wave_distance = { 0.3, 0.2 },
    spread_duration_variation = 20,
    particle_duration_variation = 60 * 3,
    render_layer = "object",

    affected_by_wind = false,
    cyclic = true,
    duration = 60 * 3,
    fade_away_duration = 1 * 60,
    spread_duration = 20,
    color = {0, 0, 0, 0.690}, -- #3ddffdb0,

    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    },

    -- created_effect =
    -- {
    --   {
    --     type = "cluster",
    --     cluster_count = 10,
    --     distance = 4,
    --     distance_deviation = 5,
    --     action_delivery =
    --     {
    --       type = "instant",
    --       target_effects =
    --       {
    --         {
    --           type = "create-smoke",
    --           show_in_tooltip = false,
    --           entity_name = "poison-cloud-visual-dummy",
    --           initial_height = 0
    --         },
    --         {
    --           type = "play-sound",
    --           sound = sounds.poison_capsule_explosion
    --         }
    --       }
    --     }
    --   },
    --   {
    --     type = "cluster",
    --     cluster_count = 11,
    --     distance = 8 * 1.1,
    --     distance_deviation = 2,
    --     action_delivery =
    --     {
    --       type = "instant",
    --       target_effects =
    --       {
    --         {
    --           type = "create-smoke",
    --           show_in_tooltip = false,
    --           entity_name = "poison-cloud-visual-dummy",
    --           initial_height = 0
    --         }
    --       }
    --     }
    --   }
    -- },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 4,
            entity_flags = {"breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 0.01, type = "asura-nanite"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 5
  },
})