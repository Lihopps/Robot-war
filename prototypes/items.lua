require("prototypes.capsule")

local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

data.extend({
    {
    type = "selection-tool",
    name = "asura-unit-remote",
    icon = "__Robot-war__/graphics/icons/unit-remote.png",
    flags = {"not-stackable", "spawnable"},
    auto_recycle = false,
    hidden=true,
    subgroup = "spawnables",
    draw_label_for_cursor_render=true,
    inventory_move_sound = item_sounds.spidertron_inventory_move,
    pick_sound = item_sounds.spidertron_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 1,
    select =
    {
      border_color = {71, 255, 73},
      mode = {"any-entity","same-force"},
      entity_type_filters={"unit"},
      cursor_box_type = "spidertron-remote-to-be-selected",
    },
    alt_select =
    {
      border_color = {239, 153, 34},
      mode = {"controllable-add"},
      --entity_filters={"robot-unit"},
      cursor_box_type = "spidertron-remote-to-be-selected",
    },
    reverse_select =
    {
      border_color = {246, 255, 0},
      mode = {"controllable-remove"},
      --entity_filters={"robot-unit"},
      cursor_box_type = "not-allowed"
    }
  },
  {
    type = "item-with-label",
    name = "asura-deploiment-remote",
    icon = "__Robot-war__/graphics/icons/deploi-remote.png",
    flags = {"only-in-cursor", "not-stackable", "spawnable"},
    auto_recycle = false,
    draw_label_for_cursor_render=true,
    hidden=true,
    subgroup = "spawnables",
    inventory_move_sound = item_sounds.artillery_remote_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.artillery_remote_inventory_move,
    stack_size = 1
  },
    {
        type = "item",
        name = "robot-fuel",
        icon = "__Robot-war__/graphics/icons/robot-fuel.png",
        fuel_category = "robot-fuel",
        fuel_value = "20GJ",
        subgroup = "asura-processes",
        order = "f",
        stack_size = 50,
        weight = (1000/(50*5)) * kg
    },
    {
    type = "item",
    name = "robot-satellite-asteroid-chunk",
    icon = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk.png",
    pictures =
    {
      { size = 64, filename = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk-02.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk-03.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk-04.png", scale = 0.5, mipmap_count = 4 },
      { size = 64, filename = "__Robot-war__/graphics/icons/robot-satellite-asteroid-chunk-05.png", scale = 0.5, mipmap_count = 4 }
    },
    subgroup = "space-material",
    order = "ca[robot-satelite-part]-e[chunk]",
    --inventory_move_sound = space_age_item_sounds.rock_inventory_move,
    --pick_sound = space_age_item_sounds.rock_inventory_pickup,
    --drop_sound = space_age_item_sounds.rock_inventory_move,
    auto_recycle=false,
    stack_size = 50,
    weight = (1000/50) * kg,
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "tool",
    name = "robot-science-pack",
    localised_description = {"item-description.science-pack"},
    icon = "__Robot-war__/graphics/icons/robot-science.png",
    subgroup = "science-pack",
    color_hint = { text = "R" },
    order = "ka",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    default_import_location = "asuras",
    weight = 1*kg,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    random_tint_color = item_tints.bluish_science
  },
     {
        type = "item",
        name = "asura_fluid-solide",
        icon = "__Robot-war__/graphics/icons/asura_fluid-solid.png",
        subgroup = "asura-processes",
        order = "a-[space]-aa",
        default_import_location = "asuras",
        stack_size = 100,
        weight = 20 * kg
    },
    {
        type = "item",
        name = "robot-unit",
        icons = {
            {
                icon = "__Robot-war__/graphics/icons/robot-unit-base.png"
            },
            {
                icon = "__base__/graphics/icons/ammo-category/bullet.png",
                scale = 0.25,
                shift = { 8, -8 }
            },
        },
        auto_recycle = false,
        subgroup = "asura-processes",
        default_import_location = "asuras",
        order = "e",
        place_result = "robot-unit",
        stack_size = 5,
        weight = 200 * kg
    },
    {
        type = "item",
        name = "robot-unit-big",
        icons = {
            {
                icon = "__Robot-war__/graphics/icons/robot-unit-base.png"
            },
            {
                icon = "__base__/graphics/icons/ammo-category/rocket.png",
                scale = 0.25,
                shift = { 8, -8 }
            },
        },
        auto_recycle = false,
        subgroup = "asura-processes",
        default_import_location = "asuras",
        order = "e",
        place_result = "robot-unit-big",
        stack_size = 1,
        weight = 1000 * kg
    },
    {
        type = "item",
        name = "neural-matrix",
        icon = "__Robot-war__/graphics/icons/neural-matrix.png",
        subgroup = "asura-processes",
        order = "b-[robot]-a",
        default_import_location = "asuras",
        stack_size = 50,
        weight = 20 * kg
    },
    {
        type = "item",
        name = "asura-crystal",
        icon = "__Robot-war__/graphics/icons/asura-crystal.png",
        subgroup = "asura-processes",
        order = "c-[inter]-a",
        default_import_location = "asuras",
        stack_size = 50,
        weight = 20 * kg
    },
    {
        type = "item",
        name = "asura-crystal-enriched",
        icon = "__Robot-war__/graphics/icons/asura-crystal-enriched.png",
        subgroup = "asura-processes",
        order = "c-[inter]-b",
        default_import_location = "asuras",
        stack_size = 25,
        weight = 40 * kg
    },
    {
        type = "item",
        name = "asura-nanite",
        icon = "__Robot-war__/graphics/icons/asura-nanite.png",
        subgroup = "asura-processes",
        order = "c-[inter]-c",
        default_import_location = "asuras",
        spoil_ticks = 60 * 60 * 5,
        spoil_result = "asura-crystal",
        stack_size = 100,
        weight = 1 * kg
    },

    {
        type = "capsule",
        name = "asura-nanite-capsule",
        icon = "__Robot-war__/graphics/icons/asura-nanite-capsule.png",
        capsule_action =
        {
            type = "throw",
            attack_parameters =
            {
                type = "projectile",
                activation_type = "throw",
                ammo_category = "capsule",
                cooldown = 30,
                projectile_creation_distance = 0.6,
                range = 25,
                ammo_type =
                {
                    target_type = "position",
                    action =
                    {
                        {
                            type = "direct",
                            action_delivery =
                            {
                                type = "projectile",
                                projectile = "asura-nanite-capsule",
                                starting_speed = 0.3
                            }
                        },
                        {
                            type = "direct",
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    {
                                        type = "play-sound",
                                        sound = sounds.throw_projectile
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        subgroup = "capsule",
        order = "c[slowdown-capsule]-a",
        inventory_move_sound = item_sounds.grenade_inventory_move,
        pick_sound = item_sounds.grenade_inventory_pickup,
        drop_sound = item_sounds.grenade_inventory_move,
        stack_size = 100,
        weight = 10 * kg
    },
    {
        type = "item",
        name = "distorsion-reactor",
        icon = "__Robot-war__/graphics/icons/distorsion.png",
        subgroup = "space-platform",
        order = "z-f[thruster]-a",
        place_result="distorsion-reactor",
        default_import_location = "asuras",
        stack_size = 1,
        weight = 1000 * kg
    },

})
