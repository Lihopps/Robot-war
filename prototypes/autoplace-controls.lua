data.extend({
 {
    type = "autoplace-control",
    name = "asuras-city",
    can_be_disabled=false,
    order = "z-[asura]-a",
    category = "terrain"
  },
  {
    type = "autoplace-control",
    name = "robot-spawner",
    can_be_disabled=false,
    order = "z-[asura]-a",
    category = "enemy"
  },
  {
    type = "autoplace-control",
    name = "asura-bases-proxy",
    can_be_disabled=false,
    order = "z-[asura]-b",
    category = "enemy"
  },
   {
    type = "autoplace-control",
    name = "uranium_asura",
    localised_name=data.raw["autoplace-control"]["uranium-ore"].localised_name,
    richness = true,
    order = "z-[asura]-b",
    category = "resource"
  },
  --  {
  --   type = "autoplace-control",
  --   name = "iron_asura",
  --   richness = true,
  --   order = "z-[asura]-b",
  --   category = "resource"
  -- },
   {
    type = "autoplace-control",
    name = "chrome_asura",
    richness = true,
    order = "z-[asura]-b",
    category = "resource"
  },
   {
    type = "autoplace-control",
    name = "lava_asura",
    richness = true,
    order = "z-[asura]-b",
    category = "terrain"
  },
  --  {
  --   type = "autoplace-control",
  --   name = "asuras_trees",
  --   richness = true,
  --   order = "z-[asura]-b",
  --   category = "terrain"
  -- }
})

--data.raw.planet["nauvis"].map_gen_settings.autoplace_controls["robot-base-proxy"]={}