local utile = require("script.util")

data:extend({
  {
    type = "technology",
    name = "planet-discovery-asuras",
    icons = util.technology_icon_constant_planet("__Robot-war__/graphics/technology/asuras-discovery.png"),
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-space-location",
        space_location = "asuras",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "asura-carbon",
      },
      {
        type = "unlock-recipe",
        recipe = "asura_fluid-to-solide"
      },
      {
        type = "unlock-recipe",
        recipe = "robot-rocket-recycling"
      },

    },
    prerequisites = { "quantum-processor", "nuclear-power" },
    unit =
    {
      count = 3500,
      ingredients =
      {
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }
      },
      time = 60
    }
  },

  {
    type = "technology",
    name = "asuras-rocket-fuel",
    icon = "__Robot-war__/graphics/technology/solidrocket.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "asura-thruster-fuel"
      },
      {
        type = "unlock-recipe",
        recipe = "asura-thruster-oxidizer"
      },
      {
        type = "unlock-recipe",
        recipe = "asura-rocket-fuel"
      },
    },
    prerequisites = { "planet-discovery-asuras" },
    research_trigger =
    {
      type = "craft-item",
      item = "asura_fluid-solide",
      count = 100
    }
  },
  {
    type = "technology",
    name = "asuras-robot-spawner",
    icon = "__Robot-war__/graphics/technology/creator.png",
    icon_size = 256,
    prerequisites = { "captivity", "planet-discovery-asuras" },
    research_trigger =
    {
      type = "capture-spawner",
      entity = "robot-spawner"
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-unit-spawnable"
      },
      {
        type = "nothing",
        effect_description = { "technology-description.laremote" },
        icon = "__Robot-war__/graphics/icons/unit-remote.png",
        icon_size = 64,
        use_icon_overlay_constant = true
      }
    }
  },
  {
    type = "technology",
    name = "asuras-robot-unit",
    icon = "__Robot-war__/graphics/technology/bullet.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-unit"
      },
    },
    prerequisites = { "asuras-robot-spawner" },
    research_trigger =
    {
      type = "craft-item",
      item = "robot-unit-spawnable",
      count = 10
    },
  },
  {
    type = "technology",
    name = "asuras-robot-science-pack",
    icon = "__Robot-war__/graphics/technology/robot-science.png",
    icon_size = 256,
    prerequisites = { "asuras-rocket-fuel", "asuras-robot-unit" },
    research_trigger =
    {
      type = "craft-item",
      item = "robot-unit"
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-science-pack"
      },
    }
  },
  {
    type = "technology",
    name = "asuras-crystal",
    icon = "__Robot-war__/graphics/technology/crystal.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "asura-crystal"
      },
    },
    prerequisites = { "asuras-robot-science-pack" },
    research_trigger =
    {
      type = "mine-entity",
      entity = "chrome-ore"
    },
  },
  {
    type = "technology",
    name = "asuras-neural-matrix-duplication",
    icon = "__Robot-war__/graphics/technology/matrix-duplication.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "neural-matrix-duplication"
      },
    },
    prerequisites = { "asuras-crystal" },
    unit =
    {
      count = 1000,
      ingredients =
      {
        { "robot-science-pack",    1 },
        { "automation-science-pack",      2 },
        { "logistic-science-pack",        2},
        { "chemical-science-pack",        2 },
        { "production-science-pack",      2 },
        { "utility-science-pack",         2 },
        { "space-science-pack",           2 },
        { "metallurgic-science-pack",     2 },
        { "agricultural-science-pack",    2 },
        { "electromagnetic-science-pack", 2 },
        { "cryogenic-science-pack",       2 }
      },
      time = 60
    }
  },

  {
    type = "technology",
    name = "asuras-robot-unit-big-spawnable",
    icon = "__Robot-war__/graphics/technology/rocket-spoil.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-unit-big-spawnable"
      },
    },
    prerequisites = { "asuras-robot-science-pack" },
    unit =
    {
      count = 1500,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }

      },
      time = 60
    }
  },
  {
    type = "technology",
    name = "asuras-robot-unit-big",
    icon = "__Robot-war__/graphics/technology/rocket.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-unit-big"
      },
    },
    prerequisites = { "asuras-robot-unit", "asuras-robot-unit-big-spawnable", "asuras-robot-science-pack" },
    unit =
    {
      count = 2500,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }

      },
      time = 60
    }
  },
  {
    type = "technology",
    name = "asuras-robot-deploiment",
    icon = "__Robot-war__/graphics/technology/deploi-remote.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "nothing",
        effect_description = { "technology-description.laremoted" },
        icon = "__Robot-war__/graphics/icons/unit-remote.png",
        icon_size = 64,
        use_icon_overlay_constant = true
      },
      effect
    },
    prerequisites = { "asuras-robot-unit", "asuras-robot-science-pack" },
    unit =
    {
      count = 500,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }

      },
      time = 60
    }
  },

  {
    type = "technology",
    name = "asuras-crystal-enriched",
    icon = "__Robot-war__/graphics/technology/crystalen.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "asura-crystal-enriched"
      },
    },
    prerequisites = { "asuras-crystal" },
    unit =
    {
      count = 800,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }
      },
      time = 60
    }
  },
  {
    type = "technology",
    name = "asuras-nanite",
    icon = "__Robot-war__/graphics/technology/nanite.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "asura-nanite"
      },
    },
    prerequisites = { "asuras-crystal-enriched" },
    unit =
    {
      count = 1000,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }
      },
      time = 60
    }
  },
  {
    type = "technology",
    name = "asuras-nanite-capsule",
    icon = "__Robot-war__/graphics/technology/capsule.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "asura-nanite-capsule"
      },
    },
    prerequisites = { "asuras-nanite" },
    unit =
    {
      count = 1100,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }
      },
      time = 60
    }
  },

  {
    type = "technology",
    name = "asuras-entity-nanified",
    icon = "__Robot-war__/graphics/technology/nanify.png",
    icon_size = 256,
    essential = true,
    effects =
    {

    },
    prerequisites = { "asuras-nanite" },
    unit =
    {
      count = 2000,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }
      },
      time = 60
    }
  },

  {
    type = "technology",
    name = "asuras-distorsion-reactor",
    icon = "__Robot-war__/graphics/technology/distorsion.png",
    icon_size = 256,
    essential = true,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "robot-fuel"
      },
      {
        type = "unlock-recipe",
        recipe = "distorsion-reactor"
      },
    },
    prerequisites = { "asuras-nanite", "asuras-neural-matrix-duplication" },
    unit =
    {
      count = 152000,
      ingredients =
      {
        { "robot-science-pack", 1 },
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 },
        { "promethium-science-pack", 1 },
      },
      time = 60
    }
  },
})


for i = 1, utile.techno_number do
  local prerequisites = {}
  if i == 1 then
    prerequisites = { "asuras-robot-deploiment" }
  else
    prerequisites = { "asuras-squad-base-" .. (i - 1) }
  end 
  data:extend({
    {
      type = "technology",
      name = "asuras-squad-base-" .. i,
      icon = "__Robot-war__/graphics/technology/squad.png",
      icon_size=256,
      effects =
      {
        {
          type = "nothing",
          icon = "__Robot-war__/graphics/technology/squad.png",
          icon_size=256,
          --icon = "__Robot-war__/graphics/icons/neural-matrix.png",
          effect_description = { "technology-description.squad",tostring(utile.squad_size(i-1)),tostring(utile.squad_size(i)) },
        }
      },
      unit =
      {
        count = 500 + (500 * i),
        ingredients =
        {
          { "robot-science-pack", 1 },
          { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "metallurgic-science-pack",     1 },
        { "agricultural-science-pack",    1 },
        { "electromagnetic-science-pack", 1 },
        { "cryogenic-science-pack",       1 }

        },
        time = 60
      },

      upgrade = true,
      show_levels_info = true,
      prerequisites = prerequisites,

      order = "a-b-b"
    }
  })
end
