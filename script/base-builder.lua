local blueprint = require("script.blueprint")
local util = require("script.util")
local force = require("script.force")
local test=require("script.test")

local size_map = { small = 10, medium = 20, big = 50 }
local size_number = { [1] = "small", [2] = "medium", [3] = "big" }

local soff=-10

local base_builder = {}

local function createshield(totem,center)
    storage.shield[totem.unit_number]={}
    local sizex=math.min(center.x+soff,-25)
    local sizey=math.min(center.y+soff,-25)
    for dx=sizex,-sizex do
        for dy=sizey,-sizey do
            if math.abs(dx)==-sizex or math.abs(dy)==-sizey then
                local position={totem.position.x+dx,totem.position.y+dy}
                local shield=totem.surface.create_entity{name="robot-shield",position=position,force=totem.force}
                if shield and shield.valid then
                    shield.destructible=false
                    table.insert(storage.shield[totem.unit_number],shield)
                end
            end
        end
    end
end


local function create_entities(proxy, remnant,object,size)
    
    local center = object[2]
    local table1 = object[1]
    local blueprint_num=object[3]
    --game.print(proxy.gps_tag)

    local area = { { proxy.position.x + center.x, proxy.position.y + center.y }, { proxy.position.x - center.x, proxy.position.y - center.y } }
    local entities_to_delete = proxy.surface.find_entities(area)
    for _, entity_to_delete in pairs(entities_to_delete) do
        if entity_to_delete.type ~= "simple-entity-with-force" and entity_to_delete.name~="robot-totem" and entity_to_delete.force.name~="enemy" and entity_to_delete.force.name~="robot_evil" then
            entity_to_delete.destroy()
        end
    end

    local tiles = {}
    for _, tile in pairs(table1.blueprint.tiles) do
        local position = { x = center.offsetx + proxy.position.x + tile.position.x, y = center.offsety + proxy.position
        .y + tile.position.y }

        local tile_o = { name = tile.name, position = position }

        proxy.surface.set_hidden_tile(position, "landfill")
        table.insert(tiles, tile_o)
    end
    --game.print(proxy.gps_tag.." : "..#tiles)
    proxy.surface.set_tiles(tiles)



    for _, entity in pairs(table1.blueprint.entities) do
        local name = ""
        if entity.name == "robot-spawner-blue" then
            name = "robot-spawner" .. remnant
        else
            name = entity.name .. remnant
        end
        if not prototypes.entity[name] then
            name = nil
            for name_c, corpse in pairs(prototypes.entity[entity.name].corpses) do
                name = name_c
                break
            end
            if not name then
                name = "big-remnants"
            end
        end
        local new_entity = proxy.surface.create_entity {
            name = name,
            position = { entity.position.x + proxy.position.x + center.x, entity.position.y + proxy.position.y + center.y },
            force = proxy.force,
            direction = entity.direction or 1,
            preserve_ghosts_and_corpses = true,
            quality = entity.quality
        }

        if new_entity and new_entity.valid then
            if new_entity.name == "requester-chest" then
                for i = 1, #entity.request_filters.sections[1].filters do
                    local item = entity.request_filters.sections[1].filters[i]
                    new_entity.get_requester_point().get_section(1).set_slot(i,
                        { value = { name = item.name, quality = item.quality }, min = item.count })
                end
            elseif new_entity.name == "robot-chest-provider" then
                new_entity.infinity_container_filters = entity.infinity_settings.filters
            elseif new_entity.name == "roboport" then
                --add robot
                local inv = new_entity.get_inventory(defines.inventory.roboport_robot)
                if inv then
                    inv.insert({ name = "logistic-robot", count = 50, quality = "legendary" })
                    inv.insert({ name = "construction-robot", count = 50, quality = "legendary" })
                end
            elseif new_entity.name == "beacon" then
                local inv = new_entity.get_inventory(defines.inventory.beacon_modules)
                if inv then
                    inv.insert({ name = entity.items[1].id.name, count = 2, quality = entity.items[1].id.quality })
                end
            elseif new_entity.name == "robot-assembler" then
                local recipe_config = util.recipe[size][math.random(#util.recipe[size])]
                new_entity.set_recipe(recipe_config)
            elseif new_entity.name == "accumulator" then
                new_entity.energy=5000000
            end
            new_entity.operable = false
            new_entity.minable = false


            if new_entity.name == "train-stop" then
                new_entity.operable = true
            elseif new_entity.name=="robot-spawner-remnants" then
                new_entity.minable=true
            end

        end
    end

    if remnant ~= "" then
        for i = 1, size_map[size] do
            local scorchmark_size = size_number[math.random(#size_number)]
            local position = tiles[math.random(#tiles)].position
            local scorchmark = proxy.surface.create_entity {
                name = scorchmark_size .. "-scorchmark",
                position = position,
                force = proxy.force,
                preserve_ghosts_and_corpses = true,
            }
        end
        --create spawner and totem
        local totem=proxy.surface.create_entity {
                name = "robot-totem",
                position = proxy.position,
                force = "robot_evil",
                preserve_ghosts_and_corpses = true,
            }
        if totem and totem.valid then
            totem.name_tag=totem.unit_number.."-"..size.."-"..blueprint_num
            totem.minable = false
            createshield(totem,center)
        end
        for i = 1, size_map[size]/10 do
            local position = tiles[math.random(#tiles)].position
            local spawner = proxy.surface.create_entity {
                name = "robot-spawner",
                position = position,
                force = "robot_evil",
                quality="legendary",
                preserve_ghosts_and_corpses = true,
            }
        end

    end

    proxy.destroy()
end




local function build_base(proxy, remnant)
    local size = util.split(proxy.name, "-")[4]
    local object = blueprint.choose_bp(size)
    --game.print(proxy.gps_tag)
    create_entities(proxy, remnant,object,size)
end

local function build_base_brut(base)
    local ratio=0.65
    if game.simulation then
        ratio=2
    end
    if math.random() < ratio then
        build_base(base, "")
    else
        build_base(base, "-remnants")
    end
end

function base_builder.revive_base(totem)
    local size=util.split(totem.name_tag, "-")[2]
    local num=util.split(totem.name_tag, "-")[3]
    local object = blueprint.choose_bp(size,num)
    create_entities(totem, "",object,size)
end

function base_builder.init(surface_index)
    local bases = game.surfaces[surface_index].find_entities_filtered { names = { "asura-base-proxy-small", "asura-base-proxy-medium", "asura-base-proxy-big" } }
    for _, base in pairs(bases) do
        build_base_brut(base)
    end
end

local function build_trigger_base(e)
    local proxy = e.source_entity
    if proxy and proxy.valid then
        if e.effect_id == "proxy_robotbase_built" then
            build_base_brut(proxy)
        elseif e.effect_id == "nanified_entity" then
            local offset = {
                x = proxy.bounding_box.left_top.x - proxy.position.x,
                y = proxy.bounding_box.left_top.y - proxy.position.y
            }
            rendering.draw_sprite
            {
                sprite = "asura-nanifyed",
                x_scale = 0.2,
                y_scale = 0.2,
                target = {
                    entity = proxy,
                    offset = offset
                },
                surface = proxy.surface,
                only_in_alt_mode = true
            }
        end
    end
end

local function savebp(e)
    local name = e.prototype_name or e.input_name or nil
    if name == "savebp" then
        test.delete()
        --local player = game.players[e.player_index]
        --local str = player.cursor_stack.export_stack()
        --util.bp_to_table(str)
    end
end

local function on_surface_created(e)
    local surface = game.surfaces[e.surface_index]
    if surface then
        if surface.name == "asuras" then
            surface.peaceful_mode = false
            surface.no_enemies_mode = false
            force.factor_evolution("robot_friend", surface.name, 0)
            force.factor_evolution("robot_evil", surface.name, 1)
        end
    end
end

base_builder.events = {
    [defines.events.on_script_trigger_effect] = build_trigger_base,
    [defines.events.on_lua_shortcut] = savebp,
    [defines.events.on_surface_created] = on_surface_created
}

return base_builder
