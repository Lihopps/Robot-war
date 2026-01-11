
local force={}


--- Create logistics force associate to the given force
---@param force LuaForce
function force.create_logistic_force(force)
    if not game.forces[force.name.."-rw-logistics"] then
        game.create_force(force.name.."-rw-logistics")
        game.forces[force.name.."-rw-logistics"].copy_from("neutral")
        game.forces[force.name.."-rw-logistics"].custom_color=force.custom_color
        game.forces[force.name].set_friend(force.name.."-rw-logistics",true)
        game.forces[force.name.."-rw-logistics"].set_friend(force.name,true)
        game.forces[force.name.."-rw-logistics"].share_chart=true
    end 
end



force.events = {
	
	

}

return force