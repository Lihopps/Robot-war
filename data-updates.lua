data.raw.unit["robot-unit"].icons = data.raw.item["robot-unit"].icons
data.raw.unit["robot-unit-big"].icons = data.raw.item["robot-unit-big"].icons

-------------------------------------------------------------------------------------------------------------------
----------------------------- NANIFICATION Item et recipe en meme temps ------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
local util = require("script.util") -- list should accesible in prototypes et runtime stages

for item_name, typ in pairs(util.item_to_nanify) do
    local item = table.deepcopy(data.raw.item[item_name]) --assuming exist
    local recipe = table.deepcopy(data.raw.recipe[item_name]) --assuming exist
    local entity = table.deepcopy(data.raw[typ][item_name]) --assuming exist


    item.localised_name = { "", { "entity-name." .. entity.name }, { "item-name.nanify" } }
    item.localised_description={"",{"?",{"entity-description."..entity.name},""},{"item-description.nanify"}}
    item.name = item.name .. "-nanify"
    item.icons= 
        {
            {icon=item.icon},{
                icon = "__Robot-war__/graphics/icons/healing.png",
                scale = 0.2,
                shift={-8.5,-8.5}
            }}
    item.spoil_tick = nil
    item.spoil_result = nil
    item.place_result = item.name



    recipe.localised_name = item.localised_name
    recipe.localized_description = item.localised_description
    table.insert(recipe.ingredients, { type = "item", name = "asura-nanite", amount = entity.max_health / 10 })
    --recipe.energy_required = recipe.energy_required*3
    recipe.category = "robot-assembling"
    if recipe.icon then
        recipe.icons= 
            {
                {icon=recipe.icon},{
                    icon = "__Robot-war__/graphics/icons/healing.png",
                    scale = 0.2,
                    shift={-8.5,-8.5}
                }}
    end
    recipe.name=item.name
    local result_tmp = {}
    for _, result in pairs(recipe.results) do
        if result.name == item_name then
            result.name = item.name
        end
    end
    recipe.enabled = lihop_debug



    entity.localised_name = item.localised_name
    entity.localised_description=item.localised_description
    entity.icons= 
        {
            {icon=entity.icon},{
                icon = "__Robot-war__/graphics/icons/healing.png",
                scale = 0.2,
                shift={-8.5,-8.5}
            }}
    entity.name = item.name
    entity.minable.result = item.name
    entity.healing_per_tick = 5 / 60
    if not entity.created_effect then
        entity.created_effect={}
    end
    table.insert(entity.created_effect,{
        type="direct",
        probability=1,
        repeat_count=1,
        action_delivery = {
          type = "instant",
          target_effects = {
            type = "script",
            effect_id = "nanified_entity"
          }
        }
    })



    --add to the tech
    data.extend({ item, recipe, entity })
    table.insert(data.raw["technology"]["asuras-entity-nanified"].effects,
        {
        type = "unlock-recipe",
        recipe = recipe.name
      }
    )
end


-------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Projectile -----------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
for k,v in pairs(data.raw.projectile) do
    if v.action then
        if v.action.type then
            v.action ={v.action}
        end

        for _,action in pairs(v.action) do
            if action.action_delivery then
                if action.action_delivery.type then
                    action.action_delivery={action.action_delivery}
                end

                for _,action_delivery in pairs(action.action_delivery) do
                    if action_delivery.target_effects then
                        if action_delivery.target_effects.type then
                            action_delivery.target_effects={action_delivery.target_effects}
                        end

                        for _,target_effect in pairs(action_delivery.target_effects) do
                            if target_effect.type=="damage" then
                                if not v.hit_collision_mask then
                                    v.hit_collision_mask={layers={}}
                                end
                                v.collision_box={{-0.01,-0.01},{0.01,0.01}}
                                v.hit_collision_mask.layers.robot_shield=true
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

for k,v in pairs(data.raw["artillery-projectile"]) do
    if not v.collision_mask then
        v.collision_mask={layers={}}
    end
    v.collision_mask.layers.robot_shield=true
end


for k,v in pairs(data.raw["damage-type"]) do
    if v.name~="physical" then
        table.insert(data.raw["simple-entity-with-force"]["robot-shield"].resistances,{type = v.name,percent=100})
        table.insert(data.raw["container"]["robot-totem"].resistances,{type = v.name,percent=100})
    end
end

-------------------------------------------------------------------------------------------------------------------
--------------------------------------------- Spidertron -----------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
for k,v in pairs(data.raw["spider-vehicle"]) do
    if not v.surface_conditions then
        v.surface_conditions={}
    end
    table.insert(v.surface_conditions,
            {
                property = "spidertron_buildability",
                min = 1,
                max = 1
            }
        )
end

-------------------------------------------------------------------
------------------- Creation des unit spawnable -------------------
-------------------------------------------------------------------
local robots={"robot-unit","robot-unit-big"}
for _,v in pairs(robots)do
    local item=table.deepcopy(data.raw.item[v])
    item.name=item.name.."-spawnable"
    item.spoil_ticks=60*5
    item.spoil_to_trigger_result =
    {
      items_per_trigger = 1,
      trigger =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            {
              type = "create-entity",
              entity_name =v,
              affects_target = true,
              show_in_tooltip = true,
              as_enemy = false,
              find_non_colliding_position = true,
              abort_if_over_space = true,
              offset_deviation = {{-1, -1}, {1, 1}},
              non_colliding_fail_result =
              {
                type = "direct",
                action_delivery =
                {
                  type = "instant",
                  source_effects =
                  {
                    {
                      type = "create-entity",
                      entity_name = v,
                      affects_target = true,
                      show_in_tooltip = false,
                      as_enemy = false,
                      offset_deviation = {{-1, -1}, {1, 1}},
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    table.insert(item.icons,{
        icon = "__Robot-war__/graphics/icons/spoil.png",
        scale=0.25,
        shift = { -8, -8 }
    })


    local recipe =table.deepcopy(data.raw.recipe[v])
    recipe.name=recipe.name.."-spawnable"
    --table.insert(recipe.ingredients,{type="item",name="copper-plate",amount=1})
    recipe.results = { { type = "item", name = item.name, amount = 1 } }
    recipe.result_is_always_fresh=true

    --item.factoriopedia_alternative=v
    item.order=item.order.."a"
    --recipe.factoriopedia_alternative=v
    recipe.order=recipe.order.."a"
    data:extend({item,recipe})

end
table.insert(data.raw["lab"]["biolab"].inputs,"robot-science-pack")
table.insert(data.raw["lab"]["lab"].inputs,"robot-science-pack")
