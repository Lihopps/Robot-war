local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
--[[
data.extend({
    {
    type = "electric-energy-interface",
    name = "distorsion-reactor",
    icons = {{icon = "__base__/graphics/icons/accumulator.png", tint = {1, 0.8, 1, 1}}},
    flags = {"placeable-neutral", "player-creation"},
    hidden = true,
    minable = {mining_time = 0.1, result = "distorsion-reactor"},
    max_health = 150,
    corpse = "medium-remnants",
    subgroup = "other",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.5,
    gui_mode = "all",--"none",
    allow_copy_paste = false,
    surface_conditions =
    {
      {
        property = "gravity",
        min = 0,
        max=0
      }
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "10GJ",
      usage_priority = "secondary-input",
      input_flow_limit = "250MW",
      drain="5MW"
    },
    energy_production = "0kW",
    energy_usage = "10MW",
    -- also 'pictures' for 4-way sprite is available, or 'animation' resp. 'animations'
    picture = accumulator_picture( {1, 0.8, 1, 1} ),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    impact_category = "metal",
  },
})
]]

local graphic_set = {
  plasma_category = "fusion-reactor-plasma",
  structure = {
    layers = { {
      filename = "__Robot-war__/graphics/entities/distorsion-reactor.png",
      width = 530,
      height = 530,
      scale = 0.5,
      x = 0,
      frame_count = 1,
     },
     {
      filename = "__Robot-war__/graphics/entities/distorsion-reactor-shadow.png",
      width = 1000,
      height = 666,
      scale = 0.5,
      draw_as_shadow=true,
      shift = util.by_pixel(20, 10),
      x = 0,
      frame_count = 1,
    } 
  }
  },
  working_light_pictures = {
    layers = { 
      {
      filename = "__Robot-war__/graphics/entities/distorsion-reactor-emission.png",
      width = 530,
      height = 530,
      scale = 0.5,
      apply_special_effect = true,
      draw_as_glow = true,
      blend_mode = "additive",
      apply_runtime_tint = true,
      tint = { 255, 0, 0 },
      frame_count = 1,
    } 
    }
  },
  light={
    type="basic",
    intensity=0.8,
    size=3,
    add_perspective=true,
    flicker_interval=60,
    color={255,0,0}
  }
}


data:extend({
  {
    type = "fusion-reactor",
    name = "distorsion-reactor",
    --factoriopedia_description = {"factoriopedia-description.fusion-reactor"},
    icon = "__space-age__/graphics/icons/fusion-reactor.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "distorsion-reactor" },
    max_health = 1000,
    impact_category = "metal",
    corpse = "fusion-reactor-remnants",
    dying_explosion = "fusion-reactor-explosion",
    -- alert_icon_shift = util.by_pixel(0, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    surface_conditions =
    {
      {
        property = "gravity",
        min = 0,
        max = 0
      }
    },
    collision_box = { { -3.9, -3.9 }, { 3.9, 3.9 } },
    selection_box = { { -4, -4 }, { 4, 4 } },
    damaged_trigger_effect = hit_effects.entity(),
    neighbour_connectable =
    {
      connections =
      {
        { location = { position = { -1.5, -3 }, direction = defines.direction.north }, category = "distorsion-reactor" },
        { location = { position = { 1.5, -3 }, direction = defines.direction.north },  category = "distorsion-reactor" },
        { location = { position = { 3, -1.5 }, direction = defines.direction.east },   category = "distorsion-reactor" },
        { location = { position = { 3, 1.5 }, direction = defines.direction.east },    category = "distorsion-reactor" },
        { location = { position = { 1.5, 3 }, direction = defines.direction.south },   category = "distorsion-reactor" },
        { location = { position = { -1.5, 3 }, direction = defines.direction.south },  category = "distorsion-reactor" },
        { location = { position = { -3, 1.5 }, direction = defines.direction.west },   category = "distorsion-reactor" },
        { location = { position = { -3, -1.5 }, direction = defines.direction.west },  category = "distorsion-reactor", },
      }
    },

    two_direction_only = true,
    graphics_set = graphic_set,
    working_sound =
    {
      sound = { filename = "__space-age__/sound/entity/fusion/fusion-reactor.ogg", volume = 0.6, modifiers = volume_multiplier("main-menu", 1.44) },
      use_doppler_shift = false,
      match_volume_to_activity = true,
      max_sounds_per_prototype = 2,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    perceived_performance = { minimum = 0.25, performance_to_activity_rate = 2.0 },

    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.reactor_open,
    close_sound = sounds.reactor_close,

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "250MW",
      drain = "5MW"
    },
    power_input = "10MW",         -- at normal quality
    max_fluid_usage = 4 / second, -- at normal quality

    burner =
    {
      type = "burner",
      fuel_categories = { "robot-fuel" },
      effectivity = 0.05,
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = 0 },
      light_flicker =
      {
        color = { 1, 0, 0.7 },
        minimum_intensity = 0.0,
        maximum_intensity = 0.1,
      }
    },
    input_fluid_box =
    {
      production_type = "input",
      volume = 1000,
      filter = "fluoroketone-cold",
      pipe_connections =
      {
        { flow_direction = "input", direction = defines.direction.west, position = { -3.5, -2.5 } },
        { flow_direction = "input", direction = defines.direction.west, position = { -3.5, 2.5 } },
        { flow_direction = "input", direction = defines.direction.east, position = { 3.5, -2.5 } },
        { flow_direction = "input", direction = defines.direction.east, position = { 3.5, 2.5 } },
      },
    },
    output_fluid_box =
    {
      production_type = "output",
      volume = 500,
      filter = "distorsion_fluid",
      pipe_connections = {}
    }
  }
})
--data.raw["fusion-reactor"]["distorsion-reactor"].graphics_set.direction_to_connections_graphics.north=nil
