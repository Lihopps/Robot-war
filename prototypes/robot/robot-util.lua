local idle_sequence =
{
   1, 2, 3, 4, 4, 3, 2, 1, 1, 2,
   3, 4, 4, 3, 2, 1, 1, 2, 3, 4,
   5, 6, 7, 8, 9,10,11,12,13,14,
  15,16,17,18,19,20,21,22
}

local robot_util={}

local function mech_anim(name, table, light)

  table.scale = table.scale or 0.5
  local mask_table = {}
  local light_table = {}
  local shadow_table = {}

  for k,v in pairs(table) do
    light_table[k] = v
    mask_table[k] = v
    shadow_table[k] = v
  end
  mask_table.apply_runtime_tint = true
  shadow_table.draw_as_shadow = true
  local base_path = "__space-age__/graphics/entity/mech-armor/"
  local anim =
  {
    layers = {
      util.sprite_load(base_path .. name, table),
      util.sprite_load(base_path .. name .. "-mask", mask_table),
      util.sprite_load(base_path .. name .. "-shadow", shadow_table),
    }
  }

  light = light or false
  if light then
    light_table.blend_mode = "additive"
    light_table.draw_as_light = true
    anim.layers[4] = util.sprite_load(base_path .. name .. "-light", light_table)
  end

  return anim
end

robot_util.idle_anim = mech_anim("mech-idle",
{
  frame_count = 22,
  animation_speed = 0.16,
  frame_sequence = idle_sequence,
  direction_count = 8,
  usage = "player",
})

function robot_util.run_anim(scale)
    return mech_anim("mech-run",
{
  frame_count = 22,
  direction_count = 40,
  animation_speed = 0.37*2,
  scale=scale,
  usage = "player",
})
end

robot_util.mining_anim = mech_anim("mech-mining",
{
  frame_count = 27,
  animation_speed = 0.45,
  direction_count = 8,
  usage = "player",
})

robot_util.take_off = mech_anim("mech-uplift",
{
  frame_count = 16,
  animation_speed = 0.6,
  direction_count = 8,
  usage = "player",
}, true)

robot_util.landing = mech_anim("mech-descend",
{
  frame_count = 16,
  animation_speed = 0.6,
  direction_count = 8,
  usage = "player",
}, true)

robot_util.idle_air = mech_anim("mech-idle-air",
{
  frame_count = 5,
  animation_speed = 0.2,
  --frame_sequence = idle_air_sequence,
  direction_count = 8,
  usage = "player",
}, true)

function robot_util.corpse(scale)
 return mech_anim("mech-corpse",
{
  frame_count = 2,
  animation_speed = 1,
  usage = "player",
  scale=scale
}, false)
end

function robot_util.resistance(percent)
    local res={
            {
                type = "impact",
                percent = percent
            },
            {
                type = "fire",
                percent = percent
            },
            {
                type = "acid",
                percent = percent
            },
            {
                type = "poison",
                percent = percent
            },
            {
                type = "laser",
                percent = percent
            },
            {
                type = "electric",
                percent = percent
            },

        }
    return res
end


return robot_util