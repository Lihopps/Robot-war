data.extend({
    {
        type = "sprite",
        name = "asura-nanifyed",
        filename = "__Robot-war__/graphics/icons/healing.png",
        priority = "extra-high-no-scale",
        width = 64,
        height = 64,
        flags = {"gui-icon"},
    },
    {
        type = "sprite",
        name = "selected-unit",
        filename = "__Robot-war__/graphics/icons/selected.png",
        priority = "extra-high-no-scale",
        width = 64,
        height = 64,
        flags = {"gui-icon"},
    },
    {
    type = "custom-input",
    name = "give-unit-combat-remote",
    key_sequence = "ALT + B",
    block_modifiers = true,
    consuming = "game-only",
    item_to_spawn = "asura-unit-remote",
    action = "spawn-item"
  },
   {
    type = "custom-input",
    name = "give-remote-deploiment",
    key_sequence = "ALT + N",
    block_modifiers = true,
    consuming = "game-only",
    item_to_spawn = "asura-unit-remote",
    action = "spawn-item"
  },
   {
    type = "custom-input",
    name = "asura-use-item",
    linked_game_control="use-item",
    key_sequence = "",
    block_modifiers = true,
    consuming = "none",
    action = "lua"
  },
  {
    type = "shortcut",
    name = "give-unit-combat-remote",
    order = "e[spidertron-remote]",
    action = "spawn-item",
    localised_name = {"item-name.give-unit-combat-remote"},
    associated_control_input = "give-unit-combat-remote",
    technology_to_unlock = "asuras-robot-spawner",
    unavailable_until_unlocked = not lihop_debug,
    item_to_spawn = "asura-unit-remote",
    icon = "__Robot-war__/graphics/icons/rts-tool-x56.png",
    icon_size = 56,
    small_icon = "__Robot-war__/graphics/icons/rts-tool-x24.png",
    small_icon_size = 24
  },
  {
    type = "shortcut",
    name = "give-remote-deploiment",
    order = "e[spidertron-remote]",
    action = "spawn-item",
    localised_name = {"item-name.give-remote-deploiment"},
    associated_control_input = "give-remote-deploiment",
    technology_to_unlock = "asuras-robot-deploiment",
    unavailable_until_unlocked = not lihop_debug,
    item_to_spawn = "asura-deploiment-remote",
    icon = "__Robot-war__/graphics/icons/deploi-tool-x56.png",
    icon_size = 56,
    small_icon = "__Robot-war__/graphics/icons/deploi-tool-x24.png",
    small_icon_size = 24
  },
  
})