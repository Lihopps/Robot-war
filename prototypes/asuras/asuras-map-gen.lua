require("prototypes.asuras.asura-decorative")
require("prototypes.asuras.asura-noise-expression-2")

local planet_map_gen = {}

local remnants = {
    "cargo-landing-pad",
    "roboport",
    "assembling-machine-3",
    "stack-inserter",
    "turbo-transport-belt",
    "turbo-splitter",
    "gun-turret",
    "railgun-turret",
    "radar",
    "rocket-silo",
    "small",
    "medium",
    "big",
    "cargo-pod-container"
}

local function make_autoplace(type, object, autoplace)
    data.raw[type][object].autoplace = autoplace or {
        order = "a[ruin]-h[small]",
        probability_expression = 0.005
    }
    return {}
end

function planet_map_gen.asuras()
    local data_gen = {
        --aux_climate_control = true,
        --moisture_climate_control = true,
        starting_area="None",
        property_expression_names =
        {
            --elevation = "asuras_elevation",
            --temperature = "asuras_temperature",
            -- cliffiness = "cliffiness_basic",
            -- cliff_elevation = "cliff_elevation_nauvis",
            --["entity:tree-01:probability"]="asuras_trees_probability",
            --["entity:iron-ore:probability"]="iron_asura_probability",
            --["entity:iron-ore:richness"]="iron_asura_richness",
            ["entity:uranium-ore:probability"]="uranium_asura_probability",
            ["entity:uranium-ore:richness"]="uranium_asura_richness",
            ["entity:chrome-ore:probability"]="chrome_asura_probability",
            ["entity:chrome-ore:richness"]="chrome_asura_richness",
            
        },
        -- cliff_settings =
        -- {
        --     name = "cliff",
        --     control = "nauvis_cliff",
        --     cliff_smoothing = 2
        -- },

        autoplace_controls =
        {
            --["iron_asura"] = {},
            ["uranium_asura"] = {},
            ["chrome_asura"]={},
            ["asuras-city"]={},
            ["lava_asura"]={},


            ["water"] = {},
            ["trees"] = {},
            ["robot-spawner"] = {},
            ["asura-bases-proxy"]={},
            
        },
        autoplace_settings =
        {
            ["tile"] =
            {
                settings =
                {
                    ["refined-concrete-asuras"]={},
                    ["hazard-concrete-left-asuras"]={},
                    ["concrete-asuras"]={},

                    ["grass-1"] = {},
                    ["grass-2"] = {},
                    ["grass-3"] = {},
                    ["grass-4"] = {},
                    ["dry-dirt"] = {},
                    ["dirt-1"] = {},
                    ["dirt-2"] = {},
                    ["dirt-3"] = {},
                    ["dirt-4"] = {},
                    ["dirt-5"] = {},
                    ["dirt-6"] = {},
                    ["dirt-7"] = {},
                    ["water"] = {},
                    ["deepwater"] = {},
                    ["volcanic-ash-flats"] = {},
                    ["volcanic-ash-light"] = {},
                    ["volcanic-ash-dark"] = {},
                    ["volcanic-smooth-stone"] = {},
                    ["volcanic-ash-cracks"] = {},

                    ["asura_fluid"]={},
                }
            },
            ["decorative"] =
            {
                settings =
                {

                    ["v-brown-carpet-grass"] = {},
                    ["v-brown-hairy-grass"] = {},
                    ["medium-rock"] = {},
                    ["small-rock"] = {},
                    ["tiny-rock"] = {},
                    ["tiny-rock-cluster"] = {},
                    ["vulcanus-rock-decal-large"] = {},
                    ["vulcanus-crack-decal-large"] = {},


                    --["small-scorchmark"] = {},
                    --["medium-scorchmark"] = {},
                    --["big-scorchmark"] = {},
                }
            },
            ["entity"] =
            {
                settings =
                {
                    --["iron-ore"] = {},
                    ["uranium-ore"] = {},
                    ["chrome-ore"]={},

                    ["ashland-lichen-tree"] = {},
                    ["ashland-lichen-tree-flaming"] = {},
                    
                    ["asura-base-proxy-small"]={},
                    --["asura-base-proxy-medium"]={},
                    --["asura-base-proxy-big"]={},
                   
                    

                }
            }
        }
    }
    --add_tree(data_gen)

    return data_gen
end

--data.raw.tile["hazard-concrete-left"].autoplace={probability_expression = "asura_remnant_probability"}
--data.raw.tile["hazard-concrete-right"].autoplace=data.raw["simple-entity"]["fulgoran-ruin-medium"].autoplace
--data.raw.tile["space-platform-foundation"].autoplace=data.raw["simple-entity"]["fulgoran-ruin-colossal"].autoplace



return planet_map_gen
