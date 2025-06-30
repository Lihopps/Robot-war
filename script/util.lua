

local util = {}

util.techno_number=10

util.item_to_nanify={
    ["gun-turret"]="ammo-turret",
    ["stone-wall"]="wall",
    ["gate"]="gate",
    ["laser-turret"]="electric-turret",
    ["rocket-turret"]="ammo-turret"
}
util.recipe={
    small={"asura-carbon","asura-crystal"},
    medium={"asura-carbon","neural-matrix-duplication","asura-crystal","asura-nanite"},
    big={"neural-matrix-duplication","asura-nanite","gun-turret-nanify","stone-wall-nanify","gate-nanify","asura-nanite-capsule"},
}


function util.bp_to_table(bpstring)
    local version=string.sub(bpstring,1,1)
    local body=string.sub(bpstring,2)
    local json_str=helpers.decode_string(body)
    helpers.write_file("blueprint.json",json_str)
    return helpers.json_to_table(json_str)
end

function util.squad_size(L)
    return L*2 +2
end

function util.get_base_squad(force)
    for i=1,util.techno_number+1 do
        if not force.technologies["asuras-squad-base-"..i] then
            return util.squad_size(i-1)
        end
    end
end

--separate string
function util.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return util
