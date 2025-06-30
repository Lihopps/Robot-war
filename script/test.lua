

local test={}


function test.on_entity_build(e)
    local surface=e.entity.surface
    local mgs=surface.map_gen_settings
    local json=helpers.table_to_json(mgs)
    helpers.write_file("map.json",json)

    local c=surface.get_resource_counts()
    json=helpers.table_to_json(c)
    helpers.write_file("c.json",json)
end

function test.test()
    game.print(math.fmod(1.12,1))

end

function test.delete()
    for name,surface in pairs(game.surfaces)do
        if name~="asuras" then
            game.delete_surface(name)
        end
    end
    
    game.surfaces["asuras"].clone_area{
        source_area= {left_top = {384.000, 320.000}, right_bottom = {512.000, 417.000}},
        destination_area={left_top = {0, 0}, right_bottom = {512-384, 417-320}},
        destination_surface=game.surfaces[1],
        clone_decoratives=true,
        clone_entities=true,
        clone_tiles=true,
        clear_destination_decoratives=true,
        clear_destination_entities=true,
    }

    game.delete_surface("asuras")
end

return test