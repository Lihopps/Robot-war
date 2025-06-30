local base_tile_sounds = require("__base__.prototypes.tile.tile-sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")
local particle_animations = require("__space-age__/prototypes/particle-animations")
--local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
particle_animations.get_old_calcite_particle_pictures = function(options)
  return
  {
    {
      filename = "__space-age__/graphics/particle/calcite-particle/calcite-particle-1.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      tint={255,255,255},
      scale = 0.5
    },
    {
      filename = "__space-age__/graphics/particle/calcite-particle/calcite-particle-2.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      tint={255,255,255},
      scale = 0.5
    },
    {
      filename = "__space-age__/graphics/particle/calcite-particle/calcite-particle-3.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      tint={255,255,255},
      scale = 0.5
    },
    {
      filename = "__space-age__/graphics/particle/calcite-particle/calcite-particle-4.png",
      priority = "extra-high",
      width = 32,
      height = 32,
      tint={255,255,255},
      scale = 0.5
    }
  }
end

local default_ended_in_water_trigger_effect = function()
  return
  {

    {
      type = "create-particle",
      probability = 1,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "secondary",
      offset_deviation = { { -0.05, -0.05 }, { 0.05, 0.05 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.05,
      initial_vertical_speed_deviation = 0.05,
      speed_from_center = 0.01,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 2,
      tail_length_deviation = 1,
      tail_width = 3,
      only_when_visible = true
    },
    {
      type = "create-particle",
      repeat_count = 10,
      repeat_count_deviation = 6,
      probability = 0.03,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "primary",
      offsets =
      {
        { 0, 0 },
        { 0.01563, -0.09375 },
        { 0.0625, 0.09375 },
        { -0.1094, 0.0625 }
      },
      offset_deviation = { { -0.2969, -0.1992 }, { 0.2969, 0.1992 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.053,
      initial_vertical_speed_deviation = 0.005,
      speed_from_center = 0.02,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 9,
      tail_length_deviation = 0,
      tail_width = 1,
      only_when_visible = true
    },
    {
      type = "play-sound",
      sound = sounds.small_splash
    }
  }

end

local make_particle = function(params)

  if not params then error("No params given to make_particle function") end
  local name = params.name or error("No name given")

  local ended_in_water_trigger_effect = params.ended_in_water_trigger_effect or default_ended_in_water_trigger_effect()
  if params.ended_in_water_trigger_effect == false then
    ended_in_water_trigger_effect = nil
  end

  local particle =
  {

    type = "optimized-particle",
    name = name,

    life_time = params.life_time or (60 * 15),
    fade_away_duration = params.fade_away_duration,

    render_layer = params.render_layer or "projectile",
    render_layer_when_on_ground = params.render_layer_when_on_ground or "corpse",

    regular_trigger_effect_frequency = params.regular_trigger_effect_frequency or 2,
    regular_trigger_effect = params.regular_trigger_effect,
    ended_in_water_trigger_effect = ended_in_water_trigger_effect,

    pictures = params.pictures,
    shadows = params.shadows,
    draw_shadow_when_on_ground = params.draw_shadow_when_on_ground,

    movement_modifier_when_on_ground = params.movement_modifier_when_on_ground,
    movement_modifier = params.movement_modifier,
    vertical_acceleration = params.vertical_acceleration,

    mining_particle_frame_speed = params.mining_particle_frame_speed,

  }

  return particle

end

local function resource(resource_parameters, autoplace_parameters)
  return
  {
    type = "resource",
    name = resource_parameters.name,
    icon = "__Robot-war__/graphics/icons/" .. resource_parameters.name .. ".png",
    flags = {"placeable-neutral"},
    order="a-b-"..resource_parameters.order,
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable = resource_parameters.minable or
    {
      mining_particle = resource_parameters.name .. "-particle",
      mining_time = resource_parameters.mining_time,
      fluid_amount = 200,
      required_fluid = "asura_fluid",
      result = resource_parameters.name
    },
    category = resource_parameters.category,
    subgroup = resource_parameters.subgroup,
    walking_sound = resource_parameters.walking_sound,
    collision_mask = resource_parameters.collision_mask,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    resource_patch_search_radius = resource_parameters.resource_patch_search_radius,
    autoplace = autoplace_parameters.probability_expression ~= nil and
    {
      --control = resource_parameters.name,
      order = resource_parameters.order,
      probability_expression = autoplace_parameters.probability_expression,
      richness_expression = autoplace_parameters.richness_expression
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__Robot-war__/graphics/entities/".. resource_parameters.name .. ".png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    map_color = resource_parameters.map_color,
    mining_visualisation_tint = resource_parameters.mining_visualisation_tint,
    --factoriopedia_simulation = resource_parameters.factoriopedia_simulation
  }
end

local particle=make_particle
  {
    name = "chrome-ore-particle",
    life_time = 180,
    pictures = particle_animations.get_old_calcite_particle_pictures(),
    shadows = particle_animations.get_old_stone_particle_shadow_pictures()
  }


data:extend({
  -- Usually earlier order takes priority, but there's some special
  -- case buried in the code about resources removing other things
  -- (though maybe there shouldn't be, and we should just place things in a different order).
  -- Trees are "a", and resources will delete trees when placed.
  -- Oil is "c" so won't be placed if another resource is already there.
  -- "d" is available for another resource, but isn't used for now.
  particle,
  resource(
    {
      name = "chrome-ore",
      order = "b",
      map_color = {r = 0.9, g = 0.9, b = 0.9, a = 1.000},
      mining_time = 5,
      walking_sound = base_tile_sounds.walking.ore,
      mining_visualisation_tint = {r = 255/255, g = 255/255, b = 255/25, a = 1.000},
      category = "hard-solid",
      --factoriopedia_simulation = simulations.factoriopedia_tungsten_ore,
    },
    {
      probability_expression = 0
    }
  ),
  {
    type = "item",
    name = "chrome-ore",
    icon = "__Robot-war__/graphics/icons/chrome-ore.png",
    pictures =
    {
      { size = 64, filename = "__Robot-war__/graphics/icons/chrome-ore.png",   scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__Robot-war__/graphics/icons/chrome-ore-1.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__Robot-war__/graphics/icons/chrome-ore-2.png", scale = 0.5, mipmap_count = 4 },
      --{ size = 64, filename = "__Robot-war__/graphics/icons/chrome-ore-3.png", scale = 0.5, mipmap_count = 4 }
    },
    subgroup="asura-processes",
    order = "a",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    default_import_location = "asuras",
    weight = 5*kg
  },
  {
    type = "fluid",
    name = "asura_fluid",
    subgroup = "fluid",
    default_temperature = 80,
    base_color = {75, 2, 69},
    flow_color = {230, 126, 214},
    icon = "__Robot-war__/graphics/icons/asura_fluid.png",
    order = "b[new-fluid]-f[asura]"
  },
   {
    type = "fluid",
    name = "distorsion_fluid",
    subgroup = "fluid",
    default_temperature = 500000,
    max_temperature = 10000000,
    heat_capacity = "25J",
    hidden=true,
    hidden_in_factoriopedia=true,
    auto_barrel=false,
    base_color = {75, 2, 69},
    flow_color = {230, 126, 214},
    icon = "__Robot-war__/graphics/icons/asura_fluid.png",
    order = "b[new-fluid]-f[asura]"
  },
})

