-------------------------------------------------------------------------------------------------------------------
---------------------------------- asuras map gen -----------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

local function create(typ,name,model)
    local probexpression = data.raw[typ][name].autoplace.probability_expression
    local autoplace=data.raw["noise-expression"][probexpression] or data.raw["noise-function"][probexpression]
    local local_expressions={}
    print(name.."/"..tostring(type(autoplace)).."/"..probexpression)
    if autoplace then
        data.raw.planet["asuras"].map_gen_settings.property_expression_names[model..":" .. name .. ":probability"] =
        "asuras_out_city_probability_" .. autoplace.name                                                                                                   --*if("..autoplace..">0,"..autoplace..",-"..autoplace..")"

       
    elseif probexpression then
        data.raw.planet["asuras"].map_gen_settings.property_expression_names[model..":" .. name .. ":probability"] =
        "asuras_out_city_probability_" .. name  
        autoplace={name=name}
        local_expressions=data.raw[typ][name].autoplace.local_expressions or {}

    else
        print(type .. "/" .. name .. " : existe pas")
        return
    end
     data:extend({
            {
                type = "noise-expression",
                name = "asuras_out_city_probability_" .. autoplace.name,
                expression = "asuras_out_city_probability{base_prob="..probexpression.."}", --
                local_expressions=local_expressions
            },
        })
end

for _, v in pairs(data.raw["tree"]) do
    create("tree",v.name,"entity")
end

local entity_list = {

}

local decorative_list = {
    ["v-brown-carpet-grass"] = "optimized-decorative",
    ["v-brown-hairy-grass"] = "optimized-decorative",
    ["medium-rock"] = "optimized-decorative",
    ["small-rock"] = "optimized-decorative",
    ["tiny-rock"] = "optimized-decorative",
    ["tiny-rock-cluster"] = "optimized-decorative",
    ["vulcanus-rock-decal-large"] = "optimized-decorative",
    ["vulcanus-crack-decal-large"] = "optimized-decorative",
}

for k, v in pairs(entity_list) do
    create(v,k,"entity")
    -- if data.raw[v][k] then
    --     local autoplace = data.raw[v][k].autoplace.probability_expression
    --     data.raw.planet["asuras"].map_gen_settings.property_expression_names["entity:" .. k .. ":probability"] =
    --     "asuras_out_city_probability(" .. autoplace .. ")"
    -- else
    --     print(k .. "/" .. v .. " : existe pas")
    -- end
end

for k, v in pairs(decorative_list) do
    create(v,k,"decorative")
    -- if data.raw[v][k] then
    --     local autoplace = data.raw[v][k].autoplace.probability_expression
    --     data.raw.planet["asuras"].map_gen_settings.property_expression_names["decorative:" .. k .. ":probability"] =
    --     "asuras_out_city_probability(" .. autoplace .. ")"
    -- else
    --     print(k .. "/" .. v .. " : existe pas")
    -- end
end
