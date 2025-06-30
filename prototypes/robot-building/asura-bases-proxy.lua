local size_def = {
  small = { size = "1", color = { 255, 0, 0 } },
  medium = { size = "2", color = { 0, 255, 0 } },
  big = { size = "3", color = { 0, 0, 255 } }
}

local control_name = "asura-bases-proxy"

local function enemy_autoplace(params)
  return
  {
    control = params.control or control_name,
    order = params.order or "b[enemy]-misc",
    force = "robot_friend",
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


for size, data_size in pairs(size_def) do
  local icons= {
      {
        icon="__Robot-war__/graphics/icons/base-proxy.png",
      },
      {
        icon="__Robot-war__/graphics/icons/"..size..".png",
        shift = { 8, 8 },
        scale=0.25
      }
    }
  data.extend({
    {
      type = "item",
      name = "asura-base-proxy-" .. size,
      icons = icons,
      place_result = "asura-base-proxy-" .. size,
      hidden = true,
      hidden_in_factoriopedia = true,
      order = "s-e-w-f-"..data_size.size,
      stack_size = 10,
    },
    {
      type = "simple-entity-with-force",
      name = "asura-base-proxy-" .. size,
      render_layer = "object",
      icons = icons,
      flags = { "placeable-neutral", "player-creation" },
      hidden = true,
      hidden_in_factoriopedia = true,
      order = "s-e-w-f-"..data_size.size,
      map_color = data_size.color,
      minable = { mining_time = 0.1, result = "asura-base-proxy-" .. size },
      max_health = 100,
      build_grid_size = 2,
      corpse = size .. "-remnants",
      autoplace = enemy_spawner_autoplace("asura_bases_proxy(" .. data_size.size .. ")"),
      collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
      selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
      picture =
      {
        layers =
        {
          {
            filename = "__Robot-war__/graphics/entities/base-proxy.png",
            priority = "extra-high",
            width = 214,
            height = 237,
            shift = util.by_pixel(0, -0.75),
            scale = 0.5
          },
        }
      },
      created_effect = {
        type = "direct",
        probability = 1,
        action_delivery = {
          type = "instant",
          target_effects = {
            type = "script",
            effect_id = "proxy_robotbase_built"
          }
        }
      }
    },
  })
end
