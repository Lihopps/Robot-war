local seuil_demarrage=0.98
local seuil_teleport=0.99


local platform={}

---@param platform LuaSpacePlatform
---@param reactor LuaEntity
local function engage_reactor(platform,reactor)
    if platform.schedule then
        local destination=platform.schedule.records[platform.schedule.current]
        platform.space_location=prototypes.space_location[destination.station]
    else
        platform.distance=0.99
    end
    reactor.remove_fluid{name="distorsion_fluid",amount=1000}
end

---@param platform LuaSpacePlatform
local function start_reactor(platform)
    if platform.state==defines.space_platform_state.on_the_path then
        if platform.distance<=seuil_demarrage then
            if #platform.surface.find_entities_filtered{name="distorsion-reactor"}==1 then
                local reactor =platform.surface.find_entities_filtered{name="distorsion-reactor"}[1]
                if reactor and reactor.valid then
                    local fluids=reactor.get_fluid_contents()
                    if fluids["distorsion_fluid"] then
                        if fluids["distorsion_fluid"]>=498 then
                            engage_reactor(platform,reactor)
                        end
                    end
                end
            end
        end
    end
end

local function platform_change_state(e)
    if e.platform and e.platform.valid then
        start_reactor(e.platform)
    end
end

local function on_tick(e)
    if e.tick %(60*3)==0 then
        for force_name,force in pairs(game.forces)do
            for _,platform in pairs(game.forces[force_name].platforms)do
                if platform.valid then
                    start_reactor(platform)
                end
            end
        end
    end
end


platform.events={
    [defines.events.on_space_platform_changed_state]=platform_change_state,
    [defines.events.on_tick]=on_tick
}


return platform