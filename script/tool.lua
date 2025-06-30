local util=require("script.util")

local tool = {}

local function on_player_created(e)
    if not storage.player_unit[e.player_index] then
        storage.player_unit[e.player_index] = {}
    end
    if game.players[e.player_index].surface then
        storage.player_unit[e.player_index][game.players[e.player_index].surface.index] = {}
    end
end

local function reset_group_unit(e)
    if storage.player_unit[e.player_index] then
        if storage.player_unit[e.player_index][game.players[e.player_index].surface.index] then
            local id_group = next(storage.player_unit[e.player_index][game.players[e.player_index].surface.index])
            if id_group then
                if #storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].render > 0 then
                    for _, id in pairs(storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].render) do
                        if rendering.get_object_by_id(id) then
                            if rendering.get_object_by_id(id).valid then
                                rendering.get_object_by_id(id).destroy()
                            end
                        end
                    end
                end
            end
        end
    end
    storage.player_unit[e.player_index][game.players[e.player_index].surface.index] = {}
end

local function create_new_group_unit(e)
    local x = (e.area.left_top.x + e.area.right_bottom.x) / 2
    local y = (e.area.left_top.y + e.area.right_bottom.y) / 2
    local unit_group = e.surface.create_unit_group { position = { x = x, y = y }, force = game.players[e.player_index].force }
    storage.player_unit[e.player_index][game.players[e.player_index].surface.index][unit_group.unique_id] = {
        render = {},
        group = unit_group
    }
    for _, entity in pairs(e.entities) do
        unit_group.add_member(entity)

        local render = rendering.draw_sprite
            {
                sprite = "selected-unit",
                target = { entity = entity, offset = { 0, -2.5 } },
                surface = entity.surface,
                players = { e.player_index },
                visible = true
            }
        table.insert(
            storage.player_unit[e.player_index][game.players[e.player_index].surface.index][unit_group.unique_id].render,
            render.id)
    end
end

local function on_selected_area(e)
    if e.item == "asura-unit-remote" then
        if not storage.player_unit[e.player_index] then
            on_player_created(e)
        end
        if not storage.player_unit[e.player_index][e.surface.index] then
            on_player_created(e)
        end

        reset_group_unit(e)
        if #e.entities > 0 then
            create_new_group_unit(e)
        end
    end
end

local function set_stack_unit_remote(e, visible)
    if storage.player_unit then
        if storage.player_unit[e.player_index] then
            if storage.player_unit[e.player_index][game.players[e.player_index].surface.index] then
                local id_group = next(storage.player_unit[e.player_index][game.players[e.player_index].surface.index])
                if id_group then
                    for _, render in pairs(storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].render) do
                        if rendering.get_object_by_id(render) then
                            if rendering.get_object_by_id(render).valid then
                                rendering.get_object_by_id(render).visible = visible
                            end
                        end
                    end
                    if storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].command and storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].command.valid then
                        storage.player_unit[e.player_index][game.players[e.player_index].surface.index][id_group].command.visible =
                            visible
                    end
                end
            end
        end
    end
end

local function on_player_cursor_stack_changed(e)
    if game.players[e.player_index] then
        if game.players[e.player_index].cursor_stack.valid_for_read then
            if game.players[e.player_index].cursor_stack.name == "asura-unit-remote" then
                set_stack_unit_remote(e, true)
                return
            elseif game.players[e.player_index].cursor_stack.name == "asura-deploiment-remote" then
                game.players[e.player_index].cursor_stack.label = "Connecting..."
                return
            end
        end
        set_stack_unit_remote(e, false)
    end
end

local function use_unit_remote(e)
    if storage.player_unit then
        if storage.player_unit[e.player_index] then
            if storage.player_unit[e.player_index][game.players[e.player_index].surface.index] then
                local group_id = next(storage.player_unit[e.player_index]
                    [game.players[e.player_index].surface.index])
                if group_id then
                    local group = storage.player_unit[e.player_index]
                        [game.players[e.player_index].surface.index][group_id]
                    if group.group.valid then
                        if game.players[e.player_index].selected  then
                            if game.players[e.player_index].selected.force.is_enemy(game.players[e.player_index].force) then
                                group.group.set_command({
                                    type = defines.command.attack,
                                    target = game.players[e.player_index].selected,
                                })
                            else
                                group.group.set_command({
                                    type = defines.command.go_to_location,
                                    destination = e.cursor_position,
                                    radius = 1
                                })
                            end
                        else
                            group.group.set_command({
                                type = defines.command.go_to_location,
                                destination = e.cursor_position,
                                radius = 1
                            })
                        end
                    else
                        for _, render in pairs(group.render) do
                            if rendering.get_object_by_id(render) then
                                if rendering.get_object_by_id(render).valid then
                                    rendering.get_object_by_id(render).destroy()
                                end
                            end
                        end
                        return
                    end
                    if storage.player_unit[e.player_index][game.players[e.player_index].surface.index][group_id].command then
                        storage.player_unit[e.player_index][game.players[e.player_index].surface.index]
                            [group_id].command.destroy()
                    end
                    storage.player_unit[e.player_index][game.players[e.player_index].surface.index][group_id].command =
                        rendering.draw_line {
                            color = { 255, 255, 255 },
                            width = 5,
                            from = { entity = group.group.members[1] },
                            to = e.cursor_position,
                            surface = group.group.surface,
                            players = { e.player_index },
                            visible = true,
                        }
                end
            end
        end
    end
end

local function use_deploiment_remote(e)
    if tonumber(game.players[e.player_index].cursor_stack.label) > 0 then
        local platforms = game.players[e.player_index].force.platforms
        for _, platform in pairs(platforms) do
            if platform.space_location then
                if platform.space_location.name == game.players[e.player_index].surface.name then
                    if platform.hub and platform.hub.valid then
                        local inv = platform.hub.get_inventory(defines.inventory.hub_main)
                        if inv and inv.valid then
                            local robot = inv.get_item_count("robot-unit")
                            local robot_big = inv.get_item_count("robot-unit-big")
                            if robot > 0 or robot_big > 0 then
                                local cargo = platform.hub.create_cargo_pod()
                                if cargo and cargo.valid then
                                    local inv_cargo = cargo.get_inventory(defines.inventory.cargo_unit)
                                    if inv_cargo and inv_cargo.valid then
                                        local weight = 0
                                        local secur = 0
                                        local base_squad = util.get_base_squad(game.players[e.player_index].force)
                                        game.print(base_squad)
                                        while weight < base_squad and secur < math.max(30,base_squad) do
                                            if robot>0 then
                                                local removed=inv.remove({ name = "robot-unit", count = inv_cargo.insert({ name = "robot-unit", count =1 }) })
                                                robot=robot-removed
                                                weight=weight+1
                                            elseif robot_big>0 then
                                                local removed=inv.remove({ name = "robot-unit-big", count = inv_cargo.insert({ name = "robot-unit-big", count =1 }) })
                                                robot_big=robot_big-removed
                                                weight=weight+2
                                            end
                                            secur=secur+1
                                        end
                                    end
                                    cargo.cargo_pod_destination = {
                                        type = defines.cargo_destination.surface,
                                        surface = game.players[e.player_index].surface.name,
                                        position = e.cursor_position,
                                        land_at_exact_position = true
                                    }
                                    game.players[e.player_index].force.print("[gps=" ..e.cursor_position.x .."," .. e.cursor_position.y .. "," .. game.players[e.player_index].surface.name .. "]")
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        game.players[e.player_index].create_local_flying_text {
					text = {"gui.no-unit"},
					position = e.entity.position,
					surface = e.entity.surface,
					color = { 1, 0, 0 },

				}
    end
end

local function use_remote(e)
    if game.players[e.player_index] then
        if game.players[e.player_index].cursor_stack.valid_for_read then
            if game.players[e.player_index].cursor_stack.name == "asura-unit-remote" then
                use_unit_remote(e)
            elseif game.players[e.player_index].cursor_stack.name == "asura-deploiment-remote" then
                use_deploiment_remote(e)
            end
        end
    end
end

local function update_deploiement_label(player, item_stack)
    local platforms = player.force.platforms
    local unit_count = 0
    for _, platform in pairs(platforms) do
        if platform.space_location then
            if platform.space_location.name == player.surface.name then
                if platform.hub and platform.hub.valid then
                    local inv = platform.hub.get_inventory(defines.inventory.hub_main)
                    if inv and inv.valid then
                        unit_count = unit_count + inv.get_item_count("robot-unit")
                        unit_count = unit_count + inv.get_item_count("robot-unit-big")
                    end
                end
            end
        end
    end
    if unit_count==0 then
        item_stack.label_color={255,0,0}
    else
         item_stack.label_color={255,255,255}
    end
    item_stack.label = tostring(unit_count)
end

local function on_tick_deploiment_remote(e)
    if e.tick % (60 * 1) == 0 then
        for index, player in pairs(game.players) do 
            if player.cursor_stack then
                if player.cursor_stack.valid_for_read then
                    if player.cursor_stack.name == "asura-deploiment-remote" then
                        update_deploiement_label(player, player.cursor_stack)
                    end
                end
            end
        end
    end
end

local function on_command_completed(e)
    for iplayer, player_data in pairs(storage.player_unit) do
        for isurface, surface_data in pairs(storage.player_unit[iplayer]) do
            local group_id = next(storage.player_unit[iplayer][isurface])
            if group_id == e.unit_number then
                if storage.player_unit[iplayer][isurface][group_id].command then
                    storage.player_unit[iplayer][isurface][group_id].command.destroy()
                end
            end
        end
    end
end

local function on_cargo_pod_finished_descending(e)
    if e.cargo_pod and e.cargo_pod.valid then
        if e.cargo_pod.cargo_pod_origin then
            if e.cargo_pod.cargo_pod_origin.name == "space-platform-hub" then
                if e.cargo_pod.cargo_pod_destination.type == defines.cargo_destination.surface then
                    local inv = e.cargo_pod.get_inventory(defines.inventory.cargo_unit)
                    if inv and inv.valid then
                        for i = 1, inv.get_item_count("robot-unit") do
                            local robot = e.cargo_pod.surface.create_entity {
                                name = "robot-unit",
                                position = e.cargo_pod.position,
                                force = e.cargo_pod.force
                            }
                            if robot and robot.valid then
                                inv.remove({ name = "robot-unit", count = 1 })
                            end
                        end
                        for i = 1, inv.get_item_count("robot-unit-big") do
                            local robot = e.cargo_pod.surface.create_entity {
                                name = "robot-unit-big",
                                position = e.cargo_pod.position,
                                force = e.cargo_pod.force
                            }
                            if robot and robot.valid then
                                inv.remove({ name = "robot-unit-big", count = 1 })
                            end
                        end
                    end
                end
            end
        end
    end
end

tool.events = {
    [defines.events.on_player_selected_area] = on_selected_area,
    [defines.events.on_player_created] = on_player_created,
    [defines.events.on_player_cursor_stack_changed] = on_player_cursor_stack_changed,
    ["asura-use-item"] = use_remote,
    [defines.events.on_ai_command_completed] = on_command_completed,
    [defines.events.on_tick] = on_tick_deploiment_remote,
    [defines.events.on_cargo_pod_finished_descending] = on_cargo_pod_finished_descending,

}


return tool
