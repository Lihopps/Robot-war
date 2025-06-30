local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local robot_util = require("prototypes.robot.robot-util")

table.insert(data.raw.ammo["capture-robot-rocket"].ammo_type.target_filter, "robot-spawner")

local control_name = "robot-spawner"

local function enemy_autoplace(params)
  return
  {
    control = params.control or control_name,
    order = params.order or "b[enemy]-misc",
    force = "robot_evil",
    probability_expression = params.probability_expression,
    richness_expression = 1
  }
end

local function enemy_spawner_autoplace(probability_expression)
  return enemy_autoplace {
    probability_expression = probability_expression,
    order = "b[enemy]-a[spawner]"
  }
end

data.extend({
  {
    type = "item",
    name = "robot-spawner-blue",
    icon = "__Robot-war__/graphics/icons/robot-spawner.png",
    hidden = true,
    hidden_in_factoriopedia=true,
    place_result = "robot-spawner-blue",
    stack_size = 10,
    weight = 2000 * kg
  },
  {
    type = "simple-entity-with-owner",
    name = "robot-spawner-blue",
    render_layer = "object",
    icon = "__Robot-war__/graphics/icons/robot-spawner.png",
    flags = { "placeable-neutral", "player-creation" },
    hidden = true,
    hidden_in_factoriopedia=true,
    minable = { mining_time = 0.1, result = "robot-spawner-blue" },
    max_health = 100,
    collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    picture =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/iron-chest/iron-chest.png",
          priority = "extra-high",
          width = 66,
          height = 76,
          shift = util.by_pixel(-0.5, -0.5),
          scale = 0.5
        },
        {
          filename = "__base__/graphics/entity/iron-chest/iron-chest-shadow.png",
          priority = "extra-high",
          width = 110,
          height = 50,
          shift = util.by_pixel(10.5, 6),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    },
  },
  {
    type = "unit-spawner",
    name = "robot-spawner",
    icon = "__Robot-war__/graphics/icons/robot-spawner.png",
    flags = { "placeable-player", "placeable-enemy" },
    max_health = 350,
    captured_spawner_entity = "robot-creator",
    time_to_capture = 60 * 5,
    --working_sound =,
    --dying_sound =,
    damaged_trigger_effect = hit_effects.entity(),
    order = "t-a",
    subgroup = "enemies",
    resistances = robot_util.resistance(50),
    healing_per_tick = 0.02,
    collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    map_generator_bounding_box = { { -3.7, -3.2 }, { 3.7, 3.2 } },
    impact_category = "metal",
    -- in ticks per 1 pu
    absorptions_per_second = { pollution = { absolute = 20, proportional = 0.01 } },
    corpse = "robot-spawner-remnants",
    dying_explosion = "big-explosion",
    max_count_of_owned_units = 5,
    max_friends_around_to_spawn = 2,
    graphics_set =
    {
      animations =
      {
        {
          layers = {
            {
              filename = "__Robot-war__/graphics/entities/robot-spawner.png",
              priority = "high",
              flags = { "low-object" },
              width = 422,
              height = 303,
              frame_count = 16,
              line_length = 4,
              shift = util.by_pixel(30, 0),
              scale = 0.5
            }
          }
        }
      }
    },
    result_units = (function()
      local res = {}
      res[1] = { "robot-unit", { { 0.0, 0.95 }, { 1, 0.8 } } }
      res[2] = { "robot-unit-big", { { 0.0, 0.05 }, { 1, 0.1 } } }
      return res
    end)(),
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = { 360, 150 },
    spawning_radius = 10,
    spawning_spacing = 3,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    autoplace = enemy_spawner_autoplace("robot_autoplace_spawner(0, 6)"),
    call_for_help_radius = 50,
    spawn_decorations_on_expansion = false,
    spawn_decoration = {}
  },
  {
    type = "item",
    name = "robot-creator",
    icon = "__Robot-war__/graphics/icons/robot-creator.png",
    subgroup = "production-machine",
    order = "i[robot-creator]",
    place_result = "robot-creator",
    stack_size = 5,
    weight = 200 * kg
  },
  {
    type = "assembling-machine",
    name = "robot-creator",
    icon = "__Robot-war__/graphics/icons/robot-creator.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "robot-creator" },
    max_health = 300,
    corpse="big-remnants",
    dying_explosion = "big-explosion",
    subgroup = "production-machine",
    order = "i[robot-creator]",
    icon_draw_specification = { shift = { 0, -0.3 } },
    resistances = robot_util.resistance(45),
    collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    --circuit_connector = circuit_connector_definitions["assembling-machine"],
    alert_icon_shift = util.by_pixel(0, -12),
     surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    graphics_set =
    {
      animation =
      {
        layers = {
          {
            filename = "__Robot-war__/graphics/entities/robot-creator.png",
            priority = "high",
            flags = { "low-object" },
            width = 422,
            height = 303,
            frame_count = 16,
            line_length = 4,
            shift = util.by_pixel(30, 0),
            scale = 0.5
          }
        }
      }
    },
    crafting_categories = { "robot-creation" },
    crafting_speed = 1,
    energy_source =
    {
      type = "burner",
      fuel_categories = {"nuclear","robot-fuel"},
      effectivity = 1,
      fuel_inventory_size = 1,
      burnt_inventory_size = 1,
      light_flicker =
      {
        color = {0,0,0},
        minimum_intensity = 0.7,
        maximum_intensity = 0.95
      }
    },
    energy_usage = "80MW",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    allowed_effects = { "speed", "consumption", "pollution","productivity" },
    module_slots = 4,
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


local remnant=table.deepcopy(data.raw.corpse["big-remnants"])
remnant.name="robot-spawner-remnants"
remnant.selectable_in_game=true
remnant.time_before_removed = 5 * minute
remnant.hidden_in_factoriopedia = false
remnant.collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } }
remnant.selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } }
remnant.minable = {
  mining_time = 1,
  results = { { type = "item", name = "neural-matrix", amount_min = 2, amount_max = 8 } },
}
remnant.animation =
    {
      {
        width = 109,
        height = 102,
        direction_count = 1,
        x=0,
        filename = "__base__/graphics/entity/remnants/big-remnants.png"
      },
      
    }
remnant.selection_priority = 45
data:extend({remnant})
