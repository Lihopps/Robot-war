data:extend {
 


  --placement des bases alliées et autre
  
  {
    type = "noise-expression",
    name = "asura_base_intensity",
    -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
    expression = "asura_map(clamp(distance,0,1000),0,1000,1,0.5)"
  },
  {
    type = "noise-expression",
    name = "asura_base_radius",
    expression = "var('control:asura-bases-proxy:size')"
  },
  {
    type = "noise-expression",
    name = "asura_base_frequancy",
    expression = "0.00005 * (asura_base_intensity) * var('control:asura-bases-proxy:frequency')" --"0.00005 * var('control:asura-bases-proxy:frequency')"
  },
  {
    type = "noise-expression",
    name = "asura_base_spot_radius_expression",
    expression = "10"
  },
  {
    type = "noise-expression",
    name = "asura_base_spot_quantity_expression",
    expression = "100"
  },
  {
    type = "noise-expression",
    name = "asura_base_spot_quantity_max",
    expression = "(3*100/(pi*10*10))"
  },
  -- value = 3*quantity / pi*radius^2   300/3.14*100  0.09
  {
    type = "noise-expression",
    name = "asura_base_probability",
    expression = "spot_noise{x = x,\z
                             y = y,\z
                             density_expression = 100 * max(0, asura_base_frequancy),\z
                             spot_quantity_expression = asura_base_spot_quantity_expression,\z
                             spot_radius_expression = asura_base_spot_radius_expression,\z
                             spot_favorability_expression = 1,\z
                             seed0 = map_seed,\z
                             seed1 = 456,\z
                             region_size = 512,\z
                             candidate_point_count = 100,\z
                             hard_region_target_quantity = 0,\z
                             basement_value = 0,\z
                             maximum_spot_basement_radius = 1,\z
                             suggested_minimum_candidate_point_spacing=60}"
  },
  {
    type = "noise-function",
    name = "asura_bases_proxy",
    parameters = { "size" },
    expression = "if(asura_base_probability>=asura_base_spot_quantity_max & (elevation>0) ,robot_base_intensity_size(size),0)"
  },
  --[[{
    type = "noise-function",
    name = "robot_base_intensity_size",
    parameters = { "size" },
    -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
    expression = "if(size==1,\z
                    robot_base_small_weight,\z
                  if(size==2,\z
                    robot_base_medium_weight,\z
                    robot_base_big_weight))"
  },]]
  
  {
    type = "noise-expression",
    name = "robot_base_first",
    expression = "500"
  },
  {
    type = "noise-expression",
    name = "robot_base_second",
    expression = "1000"
  },
  {
    type = "noise-expression",
    name = "robot_base_third",
    expression = "1500"
  },
  {
    type = "noise-expression",
    name = "robot_base_small_weight",
    expression = "if(distance<=robot_base_first,\z
                    asura_map(distance,0,robot_base_first,50,45),\z
                  if(distance>robot_base_first & distance<=robot_base_second,\z
                    asura_map(distance,robot_base_first,robot_base_second,45,20),\z
                    asura_map(clamp(distance,robot_base_second,robot_base_third),robot_base_second,robot_base_third,20,10)))"
  },
  {
    type = "noise-expression",
    name = "robot_base_medium_weight",
    expression = "if(distance<=robot_base_first,\z
                    asura_map(distance,0,robot_base_first,40,45),\z
                  if(distance>robot_base_first & distance<=robot_base_second,\z
                    asura_map(distance,robot_base_first,robot_base_second,45,60),\z
                    asura_map(clamp(distance,robot_base_second,robot_base_third),robot_base_second,robot_base_third,60,40)))"
  },
  {
    type = "noise-expression",
    name = "robot_base_big_weight",
    expression = "if(distance<=robot_base_first,\z
                    asura_map(distance,0,robot_base_first,2,10),\z
                  if(distance>robot_base_first & distance<=robot_base_second,\z
                    asura_map(distance,robot_base_first,robot_base_second,10,20),\z
                    asura_map(clamp(distance,robot_base_second,robot_base_third),robot_base_second,robot_base_third,20,50)))"
  },
  {
    type = "noise-function",
    name = "random_borned",
    parameters = { "lower", "upper" },
    expression = "floor((upper-lower+1)*random{amplitude=1,seed=123}+lower)"
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
