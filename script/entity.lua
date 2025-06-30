local test = require("script.test")
local base_builder=require("script.base-builder")



local function cant_build(e,name, number)
	local name_count = #e.entity.surface.find_entities_filtered { name = name }
	local ghost_name_count = #e.entity.surface.find_entities_filtered { ghost_name = name }
	if (name_count + ghost_name_count) > number then
		if e.player_index then
			if game.players[e.player_index] then
				game.players[e.player_index].create_local_flying_text {
					text = {"gui.not-twice"},
					position = e.entity.position,
					surface = e.entity.surface,
					color = { 1, 0, 0 },

				}
			end
		end
		e.entity.destroy()
	end
end

local function on_entity_build(e)
	--test.on_entity_build(e)
	if e.entity.name == "entity-ghost" then
		if e.entity.ghost_name == "distorsion-reactor" then
			cant_build(e,"distorsion-reactor",1)
		end
	elseif e.entity.name == "distorsion-reactor" then
		local quality=e.entity.quality.name
		cant_build(e,"distorsion-reactor",1)
		game.players[e.player_index].insert({name="distorsion-reactor",count=1,quality=quality})
	
	end
end

local function on_entity_damaged(e)
	if e.damage_type=="asura-nanite" then
		if e.entity.type == "unit" then
			if e.force then
				e.entity.force = e.force
			end
		end
	end
end

local function on_entity_died(e)
	if e.entity.name=="robot-totem" then
		for _,shield in pairs(storage.shield[e.entity.unit_number]) do
			shield.destroy()
		end
		if e.cause and e.cause.valid then
			if e.cause.name=="robot-unit" or e.cause.name=="robot-unit-big" then
				if e.cause.force.name~="robot_evil" then
					e.entity.force="robot_friend"
					base_builder.revive_base(e.entity)
				end
			end
		end
	end
end

local entities = {}

entities.events = {
	[defines.events.on_built_entity] = on_entity_build,
	[defines.events.on_entity_damaged] = on_entity_damaged,
	[defines.events.on_entity_died] = on_entity_died,

}

return entities
