
local function remove_asuras_tech(force,tech)
    force.technologies[tech.name].researched=false
    for name,tech_succ in pairs(tech.successors) do
        if tech_succ.researched then
            remove_asuras_tech(force,tech_succ)
        end
    end
end

local function on_research_finished(e)
    if string.find(e.research.name,"asuras",1,true) then
        if e.research.force.name=="player" then
            game.forces["robot_friend"].technologies[e.research.name].researched=true
        end
    end
end

local force={}

function force.factor_evolution(name,surface,factor)
        game.forces[name].set_evolution_factor(factor,surface)
        game.forces[name].set_evolution_factor_by_killing_spawners(factor,surface)
        game.forces[name].set_evolution_factor_by_pollution(factor,surface)
        game.forces[name].set_evolution_factor_by_time(factor,surface)
end

function force.make_it_op(name)
    game.forces[name].research_all_technologies()
    if game.forces[name].technologies["planet-discovery-asuras"].researched then
        remove_asuras_tech(game.forces[name],game.forces[name].technologies["planet-discovery-asuras"])
    end

end

function force.initi()
    if not game.forces["robot_friend"] then --les gentils
        game.create_force("robot_friend")
        game.forces["robot_friend"].copy_from("neutral")
        game.forces["robot_friend"].custom_color={0,0,255,255}
        game.forces["robot_friend"].copy_from("neutral")
        force.make_it_op("robot_friend")
        


        game.create_force("robot_evil")
        game.forces["robot_evil"].copy_from("enemy")
        game.forces["robot_evil"].custom_color={255,0,0,1}
    end
    game.forces["player"].set_friend("robot_friend",true)
    game.forces["robot_friend"].set_friend("player",true)
    game.forces["robot_friend"].ai_controllable=false
    game.forces["robot_friend"].ai_controllable=true
    game.forces["player"].ai_controllable=true
 
end



force.events = {
	[defines.events.on_research_finished] = on_research_finished,
	

}

return force