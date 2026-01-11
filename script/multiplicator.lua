local multiplicator = {}



local function on_entity_died(e)
    if e.cause then
        if e.cause.name=="multiplicator" then
            local name = e.entity.name
            local item=prototypes.entity[name].items_to_place_this[1]
            if item then
                local qty=prototypes.mod_data["rw_rawR"].data[item.name]
                if qty["iron-ore"]>10 and qty["copper-ore"]>5 then
                    for i=1,1 do
                        e.entity.surface.create_entity{name="multiplicator",position=e.entity.position,force="enemy"}
                    end
                end
            end
        end
    end

end


multiplicator.events = {
	[defines.events.on_entity_died] = on_entity_died,

}

return multiplicator