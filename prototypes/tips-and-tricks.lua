local simulations=require("prototypes.tips-and-tricks-simulation")

data.extend({
    {
    type = "tips-and-tricks-item",
    name = "asuras-briefing",
    tag = "[planet=asuras]",
    category = "space-age",
    order = "e-a",
    trigger =
    {
      type = "research",
      technology = "planet-discovery-asuras"
    },
    skip_trigger =
    {
      type = "change-surface",
      surface = "asuras"
    },
    simulation = simulations.asuras_briefing
  },
  {
    type = "tips-and-tricks-item",
    name = "asuras-control-remote",
    tag = "[item=asura-unit-remote]",
    category = "space-age",
    order = "e-b",
    indent=1,
    trigger =
    {
      type = "research",
      technology = "asuras-robot-spawner"
    },
    simulation = simulations.control_unit
  },
  {
    type = "tips-and-tricks-item",
    name = "asuras-robot-deploiment",
    tag = "[item=asura-deploiment-remote]",
    category = "space-age",
    order = "e-b",
    indent=1,
    trigger =
    {
      type = "research",
      technology = "asuras-robot-deploiment"
    },
    image="__Robot-war__/graphics/entity/deploiment.png"
    --simulation = simulations.asuras_briefing
  },
})