local small_scorchmark=table.deepcopy(data.raw.corpse["small-scorchmark"])
small_scorchmark.render_layer="decorative"
small_scorchmark.type="optimized-decorative"
small_scorchmark.collision_mask = {layers={water_tile=true, doodad=true}, colliding_with_tiles_only=true}
small_scorchmark.autoplace={probability_expression = "asura_remnant_smallscorchmark(0,4)"}
small_scorchmark.pictures=small_scorchmark.ground_patch

data.extend({small_scorchmark})

local medium_scorchmark=table.deepcopy(data.raw.corpse["medium-scorchmark"])
medium_scorchmark.render_layer="decorative"
medium_scorchmark.type="optimized-decorative"
medium_scorchmark.collision_mask = {layers={water_tile=true, doodad=true}, colliding_with_tiles_only=true}
medium_scorchmark.autoplace={probability_expression = "asura_remnant_mediumscorchmark(0,4)"}
medium_scorchmark.pictures=medium_scorchmark.ground_patch

data.extend({medium_scorchmark})

local big_scorchmark=table.deepcopy(data.raw.corpse["big-scorchmark"])
big_scorchmark.render_layer="decorative"
big_scorchmark.type="optimized-decorative"
big_scorchmark.collision_mask = {layers={water_tile=true, doodad=true}, colliding_with_tiles_only=true}
big_scorchmark.autoplace={probability_expression = "asura_remnant_bigscorchmark(0,4)"}--data.raw["simple-entity"]["fulgoran-ruin-big"].autoplace
big_scorchmark.pictures=big_scorchmark.ground_patch

data.extend({big_scorchmark})


local asura_fluid=table.deepcopy(data.raw.tile.water)
asura_fluid.name="asura_fluid"
asura_fluid.autoplace ={probability_expression = "lava_asura_final_probability"}
asura_fluid.fluid="asura_fluid"
asura_fluid.default_cover_tile = "foundation"
asura_fluid.variants =
    {
      main =
      {
        {
          picture = "__Robot-war__/graphics/terrain/asura_fluid/asura_fluid-2.png",
          count = 1,
          scale = 0.5,
          size = 1
        },
        {
          picture = "__Robot-war__/graphics/terrain/asura_fluid/asura_fluid-1.png",
          count = 1,
          scale = 0.5,
          size = 2
        },
        {
          picture = "__Robot-war__/graphics/terrain/asura_fluid/asura_fluid-3.png",
          count = 1,
          scale = 0.5,
          size = 4
        }
      },
      empty_transitions = true
    }
asura_fluid.map_color={230, 126, 214}
asura_fluid.effect_color = {230, 126, 214}
asura_fluid.effect_color_secondary = {230, 126, 214}
table.insert(water_tile_type_names, "asura_fluid")
data.extend({asura_fluid})

local tiles={"refined-concrete","hazard-concrete-left","concrete"}
for _,tile in pairs(tiles) do
  local ntile=table.deepcopy(data.raw["tile"][tile])
  local iname=ntile.name
  ntile.name=ntile.name.."-asuras"
  ntile.minable=nil
  ntile.localised_name={"",{"?",{"tile-name."..iname},ntile.localised_name}," (",{"space-location-name.asuras"},")"}
  ntile.autoplace={
    default_enabled=false,
    placement_density=0,
    probability_expression = string.gsub(ntile.name,"-","_")
    }

  data.extend({ntile})


end