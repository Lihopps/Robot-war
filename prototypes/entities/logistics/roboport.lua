local garage=table.deepcopy(data.raw.roboport.roboport)
garage.name="rw-roboport"
garage.material_slots_count=0
garage.robot_slots_count=5
garage.logistics_connection_distance=50
garage.radar_range=4
garage.logistics_radius=0
garage.construction_radius=0
garage.charging_station_count=2
garage.created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          type = "script",
          effect_id = "rw-create-garage"
        }
      }
    }
garage.radius_visualisation_specification = {
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
    }
garage.dying_trigger_effect = {
      type = "script",
      effect_id = "rw-destroy-garage"
    }
--garage.collision_box = { { -4.20, -4.20 }, { 4.20, 4.20 } }
--garage.selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } }
data.extend({garage})

local robstation=table.deepcopy(data.raw.roboport.roboport)
robstation.name="rw-robstation"
robstation.construction_radius=0
robstation.logistics_radius=1
robstation.radar_range=4
robstation.logistics_connection_distance=50
robstation.draw_logistic_radius_visualization=false
robstation.circuit_connector=nil
robstation.charging_station_count=0
robstation.robot_slots_count=0
robstation.material_slots_count=0
robstation.base =nil	
robstation.base_animation=nil	
robstation.base_patch=nil
robstation.door_animation_down=nil
robstation.door_animation_up=nil
robstation.collision_box = { { -4.20, -4.20 }, { 4.20, 4.20 } }
robstation.selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } }
robstation.selectable_in_game=false
robstation.selection_priority=1
data.extend({robstation})