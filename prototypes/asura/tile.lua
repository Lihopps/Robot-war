local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_graphics = require("__base__/prototypes/tile/tile-graphics")


data.extend({
    {
    type = "tile",
    name = "asura-sol",
    order = "a[artificial]-b[tier-2]-b[hazard-concrete-left]",
    subgroup = "artificial-tiles",
    needs_correction = false,
    next_direction = "hazard-concrete-right",
    transition_merges_with_tile = "concrete",
    --minable = {mining_time = 0.1, result = "hazard-concrete"},
    
    collision_mask = tile_collision_masks.ground(),
    walking_speed_modifier = 1.4,
    layer = 15,
    layer_group = "ground-artificial",
    decorative_removal_probability = 0.25,
    --placeable_by = {item = "hazard-concrete", count = 1},
    variants =
    {
      transition = tile_graphics.generic_texture_on_concrete_transition,

      material_background =
      {
        picture = "__Robot-war__/graphics/terrain/sol/tile-1.png",
        count = 8,
        scale = 0.5
      }
    },
    
    map_color={176, 142, 39},
    

    

  },
})