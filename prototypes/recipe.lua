data.raw.recipe["wood-processing"].surface_conditions[1].max = 1800
data.raw.plant["tree-plant"].surface_conditions[1].max = 1800
data.extend({
    {
        type = "recipe",
        name = "robot-rocket-recycling",
        icons = {
            {
                icon = "__quality__/graphics/icons/recycling.png"
            },
            {
                icon = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk.png",
                scale = 0.4
            },
            {
                icon = "__quality__/graphics/icons/recycling-top.png"
            }
        },
        category = "recycling",
        subgroup = "asura-processes",
        order = "b-[robot]-d",
        enabled = lihop_debug,
        auto_recycle = false,
        energy_required = 0.2,
        ingredients = { { type = "item", name = "robot-satellite-asteroid-chunk", amount = 1 } },
        results =
        {
           
            { type = "item", name = "processing-unit",       amount_min = 1,amount_max=10, probability = 0.50,  show_details_in_recipe_tooltip = false },
            { type = "item", name = "low-density-structure", amount_min = 1,amount_max=10, probability = 0.50,  show_details_in_recipe_tooltip = false },
           
        },
        
    },
    {
        type = "recipe",
        name = "asura-carbon",
        icon="__Robot-war__/graphics/icons/carbon.png",
        category = "robot-assembling",
        subgroup = "asura-processes",
        order = "a-[space]-a",
        enabled = lihop_debug,
        allow_productivity = true,
        energy_required = 5,
        ingredients = { { type = "item", name = "wood", amount = 12 } },
        surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
        results =
        {
            { type = "item", name = "carbon", amount = 25 },
        },
        auto_recycle = false,

    },
    {
        type = "recipe",
        name = "asura_fluid-to-solide",
        enabled = lihop_debug,
        energy_required = 15,
        subgroup = "asura-processes",
        order = "a-[space]-aa",
        category = "organic",
        ingredients =
        {
            { type = "fluid", name = "asura_fluid",    amount = 100 },
            { type = "item", name = "carbon",     amount = 1 },
            { type = "item", name = "tungsten-carbide", amount = 2 },
        },
        results = { { type = "item", name = "asura_fluid-solide", amount = 2 } },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    
    {
        type = "recipe",
        name = "asura-thruster-fuel",
        icon = "__Robot-war__/graphics/icons/thruster-fuel.png",
        category = "chemistry-or-cryogenics",
        subgroup = "asura-processes",
        order = "a-[space]-b",
        auto_recycle = false,
        enabled = lihop_debug,
        ingredients =
        {
            { type = "item",  name = "carbon",      amount = 50 },
            { type = "fluid", name = "asura_fluid", amount = 100 },
            { type = "item", name = "asura_fluid-solide", amount = 10 }
        },
        surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
        energy_required = 10,
        results = { { type = "fluid", name = "thruster-fuel", amount = 100 } },
        allow_productivity = true,
        show_amount_in_title = false,
        always_show_products = true,
        crafting_machine_tint =
        {
            primary = { r = 0.881, g = 0.100, b = 0.000, a = 0.502 }, -- #e0190080
            secondary = { r = 0.930, g = 0.767, b = 0.605, a = 0.502 }, -- #edc39a80
            tertiary = { r = 0.873, g = 0.649, b = 0.542, a = 0.502 }, -- #dea58a80
            quaternary = { r = 0.629, g = 0.174, b = 0.000, a = 0.502 }, -- #a02c0080
        }
    },
    {
        type = "recipe",
        name = "asura-thruster-oxidizer",
        icon = "__Robot-war__/graphics/icons/oxidizer.png",
        category = "chemistry-or-cryogenics",
        subgroup = "asura-processes",
        order = "a-[space]-c",
        auto_recycle = false,
        enabled = lihop_debug,
        ingredients =
        {
            { type = "item",  name = "plastic-bar",    amount = 10 },
            { type = "fluid", name = "asura_fluid", amount = 100 },
            { type = "item", name = "asura_fluid-solide", amount = 10 }
        },
        surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
        energy_required = 10,
        results = { { type = "fluid", name = "thruster-oxidizer", amount = 100 } },
        allow_productivity = true,
        show_amount_in_title = false,
        always_show_products = true,
        crafting_machine_tint =
        {
            primary = { r = 0.082, g = 0.396, b = 0.792, a = 0.502 }, -- #1565ca80
            secondary = { r = 0.161, g = 0.553, b = 0.796, a = 0.502 }, -- #298dcb80
            tertiary = { r = 0.059, g = 0.376, b = 0.545, a = 0.502 }, -- #0f5f8a80
            quaternary = { r = 0.683, g = 0.915, b = 1.000, a = 0.502 }, -- #aee9ff80
        }
    },
    {
        type = "recipe",
        name = "asura-rocket-fuel",
        icon = "__Robot-war__/graphics/icons/rocket-fuel.png",
        category = "oil-processing",
        subgroup = "asura-processes",
        order = "a-[space]-d",
        auto_recycle = false,
        enabled = lihop_debug,
        ingredients =
        {
            { type = "fluid", name = "thruster-oxidizer", amount = 100 },
            { type = "fluid", name = "thruster-fuel",     amount = 100 },
            { type = "item", name = "iron-plate", amount = 1 }
        },
        surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
        energy_required = 10,
        results = { { type = "item", name = "rocket-fuel", amount = 1 } },
        allow_productivity = true,
        show_amount_in_title = false,
        always_show_products = true,
    },

    {
        type = "recipe",
        name = "robot-unit",
        enabled = lihop_debug,
        energy_required = 10,
        subgroup = "asura-processes",
        order = "b-[robot]-b",
        category = "robot-creation",
        ingredients =
        {
            { type = "item", name = "neural-matrix",    amount = 1 },
            { type = "item", name = "raw-fish",             amount = 1 },
            { type = "item", name = "carbon-fiber",     amount = 2 },
            { type = "item", name = "advanced-circuit", amount = 1 },
            { type = "item", name = "iron-plate",       amount = 6 },
            { type = "item", name = "low-density-structure",       amount = 1 },
            { type = "item", name = "submachine-gun",   amount = 1 },
        },
        results = { { type = "item", name = "robot-unit", amount = 1 } },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    {
        type = "recipe",
        name = "robot-unit-big",
        enabled = lihop_debug,
        energy_required = 60,
        subgroup = "asura-processes",
        order = "b-[robot]-c",
        category = "robot-creation",
        ingredients =
        {
            { type = "item", name = "neural-matrix",    amount = 2 },
            { type = "item", name = "raw-fish",             amount = 1 },
            { type = "item", name = "carbon-fiber",     amount = 4 },
            { type = "item", name = "advanced-circuit", amount = 6 },
            { type = "item", name = "iron-plate",       amount = 20 },
            { type = "item", name = "low-density-structure",       amount = 3 },
            { type = "item", name = "rocket-launcher",  amount = 1 },
        },
        results = { { type = "item", name = "robot-unit-big", amount = 1 } },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    {
        type = "recipe",
        name = "neural-matrix-duplication",
        enabled = lihop_debug,
        subgroup = "asura-processes",
        order = "b-[robot]-a",
        energy_required = 60,
        category = "robot-assembling",
        allowed_module_categories = { "efficiency", "speed", "quality" },
        allow_productivity=false,
        main_product = "neural-matrix",
        ingredients =
        {
            { type = "item", name = "neural-matrix",     amount = 1 },
            { type = "item", name = "quantum-processor", amount = 2 },
            { type = "item", name = "asura-crystal", amount = 2 },
        },
        results =
        {
            { type = "item", name = "neural-matrix",     amount = 2, extra_count_fraction = 0.1 },
            { type = "item", name = "quantum-processor", amount = 1, probability = 0.5 },
        },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    {
        type = "recipe",
        name = "robot-science-pack",
        enabled = lihop_debug,
        subgroup = "science-pack",
        order = "ka",
        energy_required = 60,
        category = "robot-creation",
        allow_productivity=true,
        ingredients =
        {
            { type = "item", name = "asura_fluid-solide",  amount = 5 },
            { type = "item", name = "robot-unit", amount = 1 },
            { type = "item", name = "bioflux", amount = 2 },
        },
        results =
        {
            { type = "item", name = "robot-science-pack", amount = 10 },
        }
    },
    {
        type = "recipe",
        name = "asura-crystal",
        enabled = lihop_debug,
        subgroup = "asura-processes",
        order = "c-[inter]-a",
        energy_required = 2,
        category = "robot-assembling",
        ingredients =
        {
            { type = "item", name = "chrome-ore",  amount = 10 },
            { type = "item", name = "uranium-238", amount = 15 },
        },
        results =
        {
            { type = "item", name = "asura-crystal", amount = 1 },
        }
    },
    {
        type = "recipe",
        name = "asura-crystal-enriched",
        enabled = lihop_debug,
        subgroup = "asura-processes",
        order = "c-[inter]-b",
        energy_required = 60,
        category = "centrifuging",
        main_product="asura-crystal-enriched",
        crafting_machine_tint =
        {
            primary = { r = 0.0, g = 0.0, b = 0.0, a = 1.000 },
            secondary = { r = 0.0, g = 0.0, b = 0.0, a = 1.000 },
        },
        ingredients =
        {
            { type = "item", name = "asura-crystal", amount = 2 },
            { type = "item", name = "uranium-235",   amount = 10 },
        },
        results =
        {
            { type = "item", name = "asura-crystal-enriched", amount = 1 },
            { type = "item", name = "uranium-235", amount = 1, probability = 0.05 },
        },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    {
        type = "recipe",
        name = "asura-nanite",
        enabled = lihop_debug,
        subgroup = "asura-processes",
        order = "c-[inter]-c",
        energy_required = 60,
        category = "robot-assembling",
        ingredients =
        {
            { type = "item",  name = "neural-matrix",          amount = 1 },
            { type = "item",  name = "asura-crystal-enriched", amount = 10 },
            { type = "item",  name = "asura_fluid-solide",     amount = 10 },
            { type = "item",  name = "copper-cable",     amount = 15 },
        },
        results =
        {
            { type = "item", name = "asura-nanite", amount = 10 },
        }
    },
    {
        type = "recipe",
        name = "asura-nanite-capsule",
        enabled = lihop_debug,
        subgroup = "capsule",
        order = "c[slowdown-capsule]-a",
        energy_required = 60,
        category = "robot-assembling",
        ingredients =
        {
            { type = "item",  name = "asura-nanite",          amount = 5 },
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "electronic-circuit", amount = 2},
        },
        results =
        {
            { type = "item", name = "asura-nanite-capsule", amount = 1 },
        }
    },
    {
        type = "recipe",
        name = "robot-fuel",
        enabled = lihop_debug,
        subgroup = "asura-processes",
        order = "f",
        energy_required = 15,
        category = "centrifuging",
        ingredients =
        {
            { type = "item",  name = "uranium-fuel-cell",          amount = 1 },
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "asura-crystal-enriched", amount = 5},
            {type = "item", name = "supercapacitor", amount = 2},
        },
        results =
        {
            { type = "item", name = "robot-fuel", amount = 1 },
        },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },
    {
        type = "recipe",
        name = "distorsion-reactor",
        enabled = lihop_debug,
        subgroup = "space-platform",
        order = "z-f[thruster]-a",
        energy_required = 15,
        
        ingredients =
        {
            { type = "item",  name = "neural-matrix",   amount = 100 },
            {type = "item", name = "quantum-processor", amount = 250},
            {type = "item", name = "superconductor", amount = 200},
            {type = "item", name = "tungsten-plate", amount = 200},
            {type = "item", name = "asura-nanite", amount = 1000},
        },
        results =
        {
            { type = "item", name = "distorsion-reactor", amount = 1 },
        },
         surface_conditions =
        {
            {
                property = "pressure",
                min = 1500,
                max = 1500
            }
        },
    },

})
