local robot_chest_provider_item = {
  type = "item",
  name = "robot-chest-provider",
  icon = "__Robot-war__/graphics/icons/robot-chest.png",
  hidden = true,
  subgroup = "other",
  order = "c[item]-o[infinity-chest]",
  stack_size = 10,
  place_result = "robot-chest-provider"
}

local robot_chest_provider = util.table.deepcopy(data.raw["logistic-container"]["storage-chest"])
robot_chest_provider.type = "infinity-container"
robot_chest_provider.name = "robot-chest-provider"
robot_chest_provider.hidden = true
robot_chest_provider.icon = "__Robot-war__/graphics/icons/robot-chest.png"
robot_chest_provider.animation = nil
robot_chest_provider.picture =
{
  layers =
  {
    {
      filename = "__Robot-war__/graphics/entities/robot-chest.png",
      priority = "extra-high",
      width = 66,
      height = 76,
      shift = util.by_pixel(0.5, 0.5),
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
}
robot_chest_provider.gui_mode = "admins" -- all, none, admins
robot_chest_provider.erase_contents_when_mined = true
robot_chest_provider.preserve_contents_when_created = true
robot_chest_provider.minable = { mining_time = 0.1, result = "robot-chest-provider" }
table.insert(robot_chest_provider.flags, "no-automated-item-removal")
table.insert(robot_chest_provider.flags, "no-automated-item-insertion")
data:extend({ robot_chest_provider_item, robot_chest_provider })
