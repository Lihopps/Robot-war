local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

data.extend({

  {
    type = "item",
    name = "rw-requester-station",
    icon = "__base__/graphics/icons/requester-chest.png",
    subgroup = "logistic-network",
    color_hint = { text = "R" },
    order = "b[storage]-e[requester-chest]",
    inventory_move_sound = item_sounds.metal_chest_inventory_move,
    pick_sound = item_sounds.metal_chest_inventory_pickup,
    drop_sound = item_sounds.metal_chest_inventory_move,
    place_result = "rw-requester-station",
    stack_size = 50
  },
  {
    type = "container",
    name = "rw-requester-station",
    icon = "__base__/graphics/icons/steel-chest.png",
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "rw-requester-station" },
    max_health = 350,
    corpse = "steel-chest-remnants",
    dying_explosion = "steel-chest-explosion",
    open_sound = sounds.metallic_chest_open,
    close_sound = sounds.metallic_chest_close,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "script",
          effect_id = "rw-create-station"
        }
      }
    },
    radius_visualisation_specification = {
      distance = 50,
      draw_in_cursor = true,
      draw_on_selection = true,
      sprite = {
        filename = "__Robot-war__/graphics/entities/visualisation.png",
        priority = "extra-high-no-scale",
        width = 12,
        height = 12,
        scale = 100 * 5.28,
        flags = { "terrain" },
      }
    },
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    collision_box = { { -4.20, -4.20 }, { 4.20, 4.20 } },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "container",
    inventory_size = 48,
    impact_category = "metal",
    icon_draw_specification = { scale = 0.7 },
    picture =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/steel-chest/steel-chest.png",
          priority = "extra-high",
          width = 64,
          height = 80,
          shift = util.by_pixel(-0.25, -0.5),
          scale = 0.5
        },
        {
          filename = "__base__/graphics/entity/steel-chest/steel-chest-shadow.png",
          priority = "extra-high",
          width = 110,
          height = 46,
          shift = util.by_pixel(12.25, 8),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    },
    circuit_connector = circuit_connector_definitions["chest"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },


  {
    type = "logistic-container",
    name = "rw-requester-station-h",
    icon = "__base__/graphics/icons/requester-chest.png",
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.1, result = "rw-requester-station" },
    placeable_by = { item = "rw-requester-station", count = 1 },
    max_health = 350,
    dying_trigger_effect = {
      type = "script",
      effect_id = "rw-destroy-station"
    },
    corpse = "requester-chest-remnants",
    dying_explosion = "requester-chest-explosion",
    collision_box = { { -4.20, -4.20 }, { 4.20, 4.20 } },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = 48,
    icon_draw_specification = { scale = 0.7 },
    trash_inventory_size = 20,
    logistic_mode = "requester",
    open_sound = sounds.metallic_chest_open,
    close_sound = sounds.metallic_chest_close,
    animation_sound = sounds.logistics_chest_open,
    impact_category = "metal",
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/logistic-chest/requester-chest.png",
          priority = "extra-high",
          width = 66,
          height = 74,
          frame_count = 7,
          shift = util.by_pixel(0, -2),
          scale = 0.5
        },
        {
          filename = "__base__/graphics/entity/logistic-chest/logistic-chest-shadow.png",
          priority = "extra-high",
          width = 112,
          height = 46,
          repeat_count = 7,
          shift = util.by_pixel(12, 4.5),
          draw_as_shadow = true,
          scale = 0.5
        }
      }
    },
    circuit_connector = circuit_connector_definitions["chest"],
    circuit_wire_max_distance = default_circuit_wire_max_distance
  },
})
