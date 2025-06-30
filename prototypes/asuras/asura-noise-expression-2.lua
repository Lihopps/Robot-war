

data:extend {
  {
    type = "noise-function",
    name = "and",
    parameters = { "a", "b" },
    expression = "a*b",
  },
  {
    type = "noise-function",
    name = "or",
    parameters = { "a", "b" },
    expression = "max(a,b)",
  },
  {
    type = "noise-function",
    name = "modulo",
    parameters = { "a", "b" },
    expression = "a-(b*floor(a/b))",
  },
  {
    type = "noise-function",
    name = "asura_map",
    parameters = { "input", "start1", "end1", "start2", "end2" },
    expression = "((input-start1)/(end1-start1))*(end2-start2)+start2"
  },


  {
    type = "noise-function",
    name = "square",
    parameters = { "size", "large","offset","weight" },
    expression = "\z
    if(\z
      or(\z
        and(\z
          if(modulo(x,size)<large+offset,1,0),\z
          if(modulo(x,size)>0-offset,1,0)\z
        ),\z
        and(\z
          if(modulo(y,size)<large+offset,1,0),\z
          if(modulo(y,size)>0-offset,1,0)\z
        )\z
      ),\z
    weight,-1000)"
  },
  {
    type = "noise-function",
    name = "center_square",
    parameters = { "size","weight" },
    expression = "\z
    if(\z
      and(\z
        if(modulo(x-2+size/2,size)==0,1,0),\z
        if(modulo(y-2+size/2,size)==0,1,0)\z
      ),\z
    weight,-1000)"
  },




  {
    type = "noise-function",
    name = "asuras_out_city_probability",
    parameters={"base_prob"},
    expression ="if(city_biome_probability<=-2,base_prob*1,-10000)"
  },

  {
    type = "noise-function",
    name = "asuras_base_prob",
    parameters={"base_prob"},
    expression ="if(random(1,0)<0.7*var('control:asura-bases-proxy:frequency')/3,1,0)"
  },


  {
    type = "noise-function",
    name = "asuras_in_city_probability",
    parameters={"base_prob"},
    expression ="if(city_biome_probability>0.1 & asuras_base_prob(1)>0,base_prob*1,-10000)"
  },

   {
    type = "noise-function",
    name = "asura_bases_proxy",
    parameters = { "size" },
    expression = "asuras_in_city_probability(if(elevation>0 ,center_square(52,robot_base_intensity_size(size)),0))"
  },
  {
    type = "noise-function",
    name = "robot_base_intensity_size",
    parameters = { "size" },
    -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
    expression = "10*random_penalty{x = x + size,\z
                                 y = y,\z
                                 source = 1,\z
                                 amplitude = 1}"
  },


  {
    type = "noise-expression",
    name = "city_intensity",
    -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
    expression = "1"--"clamp(distance, 0, 2400) / 325"
  },
  {
    type = "noise-expression",
    name = "city_radius",
    expression = "15*var('control:asuras-city:size')* (15 + 4 * city_intensity)"
  },
  {
    type = "noise-expression",
    name = "city_frequency",
    -- bases_per_km2 = 10 + 3 * enemy_base_intensity
    expression = "(0.00001 + 0.000003 * city_intensity) *(var('control:asuras-city:richness'))"
  },
  {
    type = "noise-expression",
    name = "city_biome_probability",
    expression = "spot_noise{x = x,\z
                             y = y,\z
                             density_expression = spot_quantity_expression * max(0, city_frequency),\z
                             spot_quantity_expression = spot_quantity_expression,\z
                             spot_radius_expression = spot_radius_expression,\z
                             spot_favorability_expression = 1,\z
                             seed0 = map_seed,\z
                             seed1 = 123,\z
                             region_size = 1024,\z
                             candidate_point_count = 1,\z
                             hard_region_target_quantity = 0,\z
                             basement_value = -1000,\z
                             maximum_spot_basement_radius = 500} + \z
                  (blob(1/8, 1) + blob(1/24, 1) + blob(1/64, 2) - 0.5) * spot_radius_expression / 150 * \z
                  (0.1 + 0.9 * clamp(distance / 3000, 0, 1)) - 0.3 + min(0, 20 / starting_area_radius * distance - 20)",
    local_expressions =
    {
      spot_radius_expression = "max(0, city_radius)",
      spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
    },
    local_functions =
    {
      blob =
      {
        parameters = {"input_scale", "output_scale"},
        expression = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 123, input_scale = input_scale, output_scale = output_scale}"
      }
    }
  },
  
 {
    type = "noise-expression",
    name = "refined_concrete_asuras",
    expression = "if(city_biome_probability>0,square(52,5,0,200),-1000)"
  },
  {
    type = "noise-expression",
    name = "hazard_concrete_left_asuras",
    expression = "if(city_biome_probability>0,square(52,5,1,190),-1000)"
  },
  {
    type = "noise-expression",
    name = "concrete_asuras",
    expression = "if(city_biome_probability>0,180,-1000)"
  },


---------------------------------------------------------------------------------------------------------------
----------------------------------   Resources spawn   --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
  {
    type = "noise-function",
    name = "richness_asura",
    parameters={"richness","size_multiplier","gain"},
    expression = "random_penalty_between(0.2, 1, 1)\z
                  * gain * clamp(distance,100,500)\z
                  * richness/ size_multiplier"
  },
  
  {
    type = "noise-expression",
    name = "iron_asura_frequency",
    expression = "(control:iron_asura:frequency)*1.2"
  },
  {
    type = "noise-expression",
    name = "iron_asura_richness",
    expression = "richness_asura(control:iron_asura:richness,iron_asura_size,42.69)"
  },
  {
    type = "noise-expression",
    name = "iron_asura_size",
    expression = "control:iron_asura:size"
  },
   {
    type = "noise-expression",
    name = "iron_asura_base_probability",
    expression =  "resource_autoplace_all_patches{\z
      base_density = 10,\z
      base_spots_per_km2 = 2.5,\z
      candidate_spot_count = 22,\z
      frequency_multiplier = iron_asura_frequency*2.5,\z
      has_starting_area_placement = 1,\z
      random_spot_size_minimum = 0.25,\z
      random_spot_size_maximum = 2,\z
      regular_blob_amplitude_multiplier = 1/8,\z
      regular_patch_set_count = default_regular_resource_patch_set_count,\z
      regular_patch_set_index = 1,\z
      regular_rq_factor = 1.10/10,\z
      seed1 = 100,\z
      size_multiplier = iron_asura_size*1.3,\z
      starting_blob_amplitude_multiplier =1/8,\z
      starting_patch_set_count = default_starting_resource_patch_set_count,\z
      starting_patch_set_index = 1,\z
      starting_rq_factor = 1.5/7}",
  },
   {
    type = "noise-expression",
    name = "iron_asura_probability",
    expression ="if(city_biome_probability<=-20,iron_asura_base_probability,-1000)"  
   },
 
 {
    type = "noise-expression",
    name = "uranium_asura_frequency",
    expression = "(control:uranium_asura:frequency)*1.05"
  },
  {
    type = "noise-expression",
    name = "uranium_asura_richness",
    expression = "richness_asura(control:uranium_asura:richness,uranium_asura_size,35.23)"
  },
  {
    type = "noise-expression",
    name = "uranium_asura_size",
    expression = "control:uranium_asura:size"
  },
   {
    type = "noise-expression",
    name = "uranium_asura_base_probability",
    expression =  "resource_autoplace_all_patches{\z
      base_density = 8,\z
      base_spots_per_km2 = 2.5,\z
      candidate_spot_count = 22,\z
      frequency_multiplier = uranium_asura_frequency*1.5,\z
      has_starting_area_placement = 1,\z
      random_spot_size_minimum = 0.25,\z
      random_spot_size_maximum = 2,\z
      regular_blob_amplitude_multiplier = 1/8,\z
      regular_patch_set_count = default_regular_resource_patch_set_count,\z
      regular_patch_set_index = 1,\z
      regular_rq_factor = 1.10/10,\z
      seed1 = 50,\z
      size_multiplier = uranium_asura_size*1.1,\z
      starting_blob_amplitude_multiplier =1/8,\z
      starting_patch_set_count = default_starting_resource_patch_set_count,\z
      starting_patch_set_index = 1,\z
      starting_rq_factor = 1.2/7}",
  },
   {
    type = "noise-expression",
    name = "uranium_asura_probability",
    expression ="if(city_biome_probability<=-10,uranium_asura_base_probability,-1000)"  
   },



  {
    type = "noise-expression",
    name = "lava_asura_frequency",
    expression = "control:lava_asura:frequency"
  },
  {
    type = "noise-expression",
    name = "lava_asura_richness",
    expression = "control:lava_asura:richness"
  },
  {
    type = "noise-expression",
    name = "lava_asura_size",
    expression = "control:lava_asura:size"
  },
   {
    type = "noise-expression",
    name = "lava_asura_probability",
    expression =  "resource_autoplace_all_patches{\z
      base_density = 0.9,\z
      base_spots_per_km2 = 1.5,\z
      candidate_spot_count = 21,\z
      frequency_multiplier = 1/(3*lava_asura_frequency),\z
      has_starting_area_placement = 0,\z
      random_spot_size_minimum = 2,\z
      random_spot_size_maximum = 4,\z
      regular_blob_amplitude_multiplier = 1/8,\z
      regular_patch_set_count = default_regular_resource_patch_set_count,\z
      regular_patch_set_index = 1,\z
      regular_rq_factor = 1.1/10,\z
      seed1 = 4586524,\z
      size_multiplier = lava_asura_size,\z
      starting_blob_amplitude_multiplier =1/8,\z
      starting_patch_set_count = default_starting_resource_patch_set_count,\z
      starting_patch_set_index = 1,\z
      starting_rq_factor = 1/7}",
  },
  {
    type = "noise-expression",
    name = "lava_asura_final_probability",
    expression =  "if(city_biome_probability<=-10,lava_asura_probability * (elevation>0),-1000)" --"",
  },

   {
    type = "noise-expression",
    name = "chrome_asura_frequency",
    expression = "(control:chrome_asura:frequency)*1.5"
  },
  {
    type = "noise-expression",
    name = "chrome_asura_richness",
    expression = "richness_asura(control:chrome_asura:richness,chrome_asura_size,12)"
  },
  {
    type = "noise-expression",
    name = "chrome_asura_size",
    expression = "control:chrome_asura:size"
  },
   {
    type = "noise-expression",
    name = "chrome_asura_base_probability",
    expression =  "resource_autoplace_all_patches{\z
      base_density = 0.9,\z
      base_spots_per_km2 = 1.5,\z
      candidate_spot_count = 21,\z
      frequency_multiplier = chrome_asura_frequency*2,\z
      has_starting_area_placement = 0,\z
      random_spot_size_minimum = 2,\z
      random_spot_size_maximum = 4,\z
      regular_blob_amplitude_multiplier = 1/8,\z
      regular_patch_set_count = default_regular_resource_patch_set_count,\z
      regular_patch_set_index = 1,\z
      regular_rq_factor = 1.1/10,\z
      seed1 = 15487,\z
      size_multiplier = chrome_asura_size*2,\z
      starting_blob_amplitude_multiplier =1/8,\z
      starting_patch_set_count = default_starting_resource_patch_set_count,\z
      starting_patch_set_index = 1,\z
      starting_rq_factor = 1/7}",
  },
  {
    type = "noise-expression",
    name = "chrome_asura_probability",
    expression ="if(city_biome_probability<=-5,chrome_asura_base_probability,-1000)"
  },

  
---------------------------------------------------------------------------------------------------------------
----------------------------------   enemy spawn   --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

   --les bases des mechant c'est comme les bases de biter mais pas dans les villes
  {
    type = "noise-expression",
    name = "robot_spawner_intensity",
    -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
    expression = "clamp(distance, 0, 2400) / 325"
  },
  {
    type = "noise-expression",
    name = "robot_spawner_radius",
    expression = "sqrt(var('control:robot-spawner:size')) * (15 + 4 * robot_spawner_intensity)"
  },
  {
    type = "noise-expression",
    name = "robot_spawner_frequency",
    -- bases_per_km2 = 10 + 3 * enemy_base_intensity
    expression = "(0.00001 + 0.000003 * robot_spawner_intensity) * var('control:robot-spawner:frequency')"
  },
  {
    type = "noise-expression",
    name = "robot_spawner_probability",
    expression = "spot_noise{x = x,\z
                             y = y,\z
                             density_expression = spot_quantity_expression * max(0, robot_spawner_frequency),\z
                             spot_quantity_expression = spot_quantity_expression,\z
                             spot_radius_expression = spot_radius_expression,\z
                             spot_favorability_expression = 1,\z
                             seed0 = map_seed,\z
                             seed1 = 123,\z
                             region_size = 512,\z
                             candidate_point_count = 100,\z
                             hard_region_target_quantity = 0,\z
                             basement_value = -1000,\z
                             maximum_spot_basement_radius = 128} + \z
                  (blob(1/8, 1) + blob(1/24, 1) + blob(1/64, 2) - 0.5) * spot_radius_expression / 150 * \z
                  (0.1 + 0.9 * clamp(distance / 3000, 0, 1)) - 0.3 + min(0, 20 / starting_area_radius * distance - 20)",
    local_expressions =
    {
      spot_radius_expression = "max(0, robot_spawner_radius)",
      spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
    },
    local_functions =
    {
      blob =
      {
        parameters = { "input_scale", "output_scale" },
        expression = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 123, input_scale = input_scale, output_scale = output_scale}"
      }
    }
  },
  {
    type = "noise-function",
    name = "robot_autoplace_spawner",
    parameters = { "distance_factor", "seed" },
    expression = "asuras_out_city_probability(random_penalty{x = x + seed,\z
                                 y = y,\z
                                 source = min(robot_spawner_probability * max(0, 1 + 0.002 * distance_factor * (-312 * distance_factor - starting_area_radius + distance)),\z
                                              0.25 + distance_factor * 0.05),\z
                                 amplitude = 0.1})"
  },



--------------------------------------------------------------------------------------------------
----------------------------------------- Decorative ---------------------------------------------
--------------------------------------------------------------------------------------------------
  {
    type = "noise-function",
    name = "asura_remnant_bigscorchmark",
    parameters = { "distance_factor", "seed" },
    expression = 0 --"if(asura_remnant_probability>=asura_remnant_spot_quantity_max*0.3 & asura_remnant_probability<asura_remnant_spot_quantity_max*0.6,random{amplitude=1,seed=123},0)"
  },
  {
    type = "noise-function",
    name = "asura_remnant_mediumscorchmark",
    parameters = { "distance_factor", "seed" },
    expression = 0 --"if(asura_remnant_probability>=asura_remnant_spot_quantity_max*0.3 & asura_remnant_probability<asura_remnant_spot_quantity_max*0.6,random{amplitude=1,seed=123},0)"
  },
  {
    type = "noise-function",
    name = "asura_remnant_smallscorchmark",
    parameters = { "distance_factor", "seed" },
    expression = 0 --"if(asura_remnant_probability>0 & asura_remnant_probability<asura_remnant_spot_quantity_max*0.3,random{amplitude=1,seed=123},0)"
  },



}
