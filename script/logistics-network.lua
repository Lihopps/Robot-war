local force_util = require("script.force")
local util = require("script.util")

local buildings = {
    ["rw-passive-provider-station"] = true,
    ["rw-requester-station"] = true,
    ["rw-passive-provider-station-h"] = true,
    ["rw-requester-station-h"] = true,
    ["rw-roboport"] = true
}

local ln = {}

local function get_buildings_name()
    local b = {}
    for name, _ in pairs(buildings) do
        table.insert(b, name)
    end
    return b
end

local function switch_force(entity, force)
    if not game.forces[force.name .. "-rw-logistics"] then
        force_util.create_logistic_force(force)
    end
    entity.force = game.forces[force.name .. "-rw-logistics"]
end

local function create_force(force)
    if not game.forces[force.name .. "-rw-logistics"] then
        force_util.create_logistic_force(force)
    end
end


local function on_script_trigger(e)
    if e.effect_id == "rw-create-station" then
        if e.source_entity then
            local hidden = e.source_entity
            create_force(hidden.force)
            hidden.surface.create_entity {
                name = prototypes.entity[hidden.name].items_to_place_this[1].name .. "-h",
                force = hidden.force.name .. "-rw-logistics",
                position = hidden.position
            }
            local robstation = hidden.surface.create_entity {
                name = "rw-robstation",
                force = hidden.force.name .. "-rw-logistics",
                position = hidden.position
            }
            robstation.destructible = false
            robstation.minable_flag = false

            hidden.destroy()
        end
    elseif e.effect_id == "rw-destroy-station" then
        if e.source_entity then
            if buildings[e.source_entity.name] then
                local rob = e.source_entity.surface.find_entity("rw-robstation", e.source_entity.position)
                if rob then
                    rob.destroy()
                end
            end
        end
    elseif e.effect_id == "rw-create-garage" then
        if e.source_entity then
            create_force(e.source_entity.force)
            e.source_entity.force=e.source_entity.force.name.."-rw-logistics"
            storage.rw_garage[e.source_entity.unit_number]=e.source_entity
        end
    elseif e.effect_id == "rw-destroy-garage" then
        if e.source_entity then
            storage.rw_garage[e.source_entity.unit_number]=nil
        end
    end
end

local function draw_ln(player_index)
    create_force(game.players[player_index].force)
    local distance = prototypes.entity["rw-robstation"].logistic_parameters.logistics_connection_distance
    rendering.clear("Robot-war")
    local entities = game.players[player_index].surface.find_entities_filtered { name = get_buildings_name(), force = game.players[player_index].force.name .. "-rw-logistics" }
    if next(entities) then
        for i, a in ipairs(entities) do
            local sp = rendering.draw_sprite {
                sprite = "rw-robstation",
                x_scale = 0.505,
                y_scale = 0.505,
                target = a,
                surface = a.surface,
                players = { player_index },

            }
            sp.render_layer = "radius-visualization"
            for j, b in ipairs(entities) do
                if i > j then
                    if util.distance_inf(a.position, b.position, distance) then
                        rendering.draw_line {
                            surface = a.surface,
                            from = a,
                            to = b,
                            width = 4,
                            gap_length = 2,
                            dash_length = 1,
                            players = { player_index },
                            color = { r = 1, g = 1, b = 0 }
                        }
                    end
                end
            end
        end
        return
    end
end


local function on_stack_changed(e)
    local cursor = game.players[e.player_index].cursor_stack
    if cursor then
        if cursor.valid_for_read then
            if buildings[cursor.name] then
                draw_ln(e.player_index)
                return
            end
        end
    end
    rendering.clear("Robot-war")
end

local function on_mined_entity(e)
    if buildings[e.entity.name] then
        local effect="rw-destroy-station"
        if e.entity.name=="rw-roboport" then
            effect="rw-destroy-garage"
        end
        local e2 = { source_entity = e.entity, effect_id = effect}
        on_script_trigger(e2)
    end
end

local function on_entity_logistic_slot_changed(e)
    if e.entity.type == "roboport" then
        if not e.section.get_slot(e.slot_index).value then return end
        local item = e.section.get_slot(e.slot_index).value.name
        if item then
            if e.entity.name == "rw-roboport" then
                if item ~= "rw-transporter" then
                    e.section.clear_slot(e.slot_index)
                    game.print("not allowed")
                end
            else
                if item == "rw-transporter" then
                    e.section.clear_slot(e.slot_index)
                    game.print("not allowed")
                end
            end
        end
    end
end

local function on_tick(e)
    if e.tick %60 ==0 then
        for unit_number, entity in pairs(storage.rw_garage) do
            local inv=entity.get_inventory(defines.inventory.roboport_robot)
            if inv then
                if inv.valid then
                    for i=1,#inv do
                        local item_stack=inv[i]
                        if item_stack and item_stack.valid_for_read then
                            if item_stack.name=="rw-transporter" then
                                item_stack.spoil_percent=0
                            else
                                item_stack.clear()
                                --TODO spawn enemy ?
                            end
                        end
                    end
                end
            end
        end
    end
end

ln.events = {
    [defines.events.on_script_trigger_effect] = on_script_trigger,
    [defines.events.on_player_cursor_stack_changed] = on_stack_changed,
    [defines.events.on_player_mined_entity] = on_mined_entity,
    [defines.events.on_robot_mined_entity] = on_mined_entity,
    [defines.events.on_entity_logistic_slot_changed] = on_entity_logistic_slot_changed,
    [defines.events.on_tick]=on_tick
}

return ln

