local raw={}

local function getRawRessource()
    local res={
        ["raw-fish"]={["raw-fish"]=1},
        ["spoilage"]={["spoilage"]=1},
        ["depleted-uranium-fuel-cell"]={["depleted-uranium-fuel-cell"]=1},
        ["holmium-ore"]={["holmium-ore"]=1}
        }
    
    for name,datar in pairs(data.raw["asteroid-chunk"]) do
        res[name]={[name]=1}
    end

    for name,datar in pairs(data.raw.plant) do
        if datar.minable then
            if datar.minable.results then
                for _,result in pairs(datar.minable.results)do
                    res[result.name]={[result.name]=1}
                end
            end
        end
    end

    for name,datar in pairs(data.raw["resource"])do
        res[name]={[name]=1}
    end
    
    
    -- return {
    --     coal={coal=1},
    --     ["iron-ore"]={["iron-ore"]=1},
    --     ["copper-ore"]={["copper-ore"]=1},
    --     ["stone"]={["stone"]=1},
    --     ["uranium-ore"]={["uranium-ore"]=1},
    --     ["wood"]={["wood"]=1},
    --     ["calcite"]={["calcite"]=1},

    -- }
    return res
end

local function compil_recipe_for_item()
    local items={}
    for name,recipe in pairs(data.raw.recipe) do
        if not string.find(name,"recycling") then
            if recipe.main_product then
                if not items[recipe.main_product] then
                    items[recipe.main_product]={}
                end
                table.insert(items[recipe.main_product],name)
            else
                if recipe.results then
                    for _,result in pairs(recipe.results) do
                        if result.type=="item" then
                            if not items[result.name] then
                                items[result.name]={}
                            end
                            table.insert(items[result.name],name)
                        end
                    end
                end
            end 
        end
    end

    return items
end

local function getRecipeOutput(recipe,item)
    if not item and recipe.main_product then
        item=recipe.main_product
    end
    if not item then
        item=recipe.results[1].name
    end
    for _,result in pairs(recipe.results)do
        if result.name==item then
            return result.amount or (result.probability * (0.5 * (result.amount_max + result.amount_min)))
        end
    end
    return 1
end


function getRawIngredient(items,itemRaw,recipe,recipeRaw,count,multiplier)
    if count<1000 then
        if recipe.ingredients then
            for _,ingredient in pairs(recipe.ingredients) do
                if ingredient.type=="item" then
                    if itemRaw[ingredient.name] then 
                        for n,c in pairs(itemRaw[ingredient.name]) do
                            if not recipeRaw[n] then
                                recipeRaw[n]=0
                            end
                            recipeRaw[n]=recipeRaw[n]+(c*ingredient.amount*multiplier/getRecipeOutput(recipe))
                        end
                    else
                        if items[ingredient.name] then
                            getRawIngredient(items,itemRaw,data.raw.recipe[items[ingredient.name][1]],recipeRaw,count+1,ingredient.amount*multiplier/getRecipeOutput(recipe))
                        end
                        -- local rr=getRawIngredient(items,itemRaw,data.raw.recipe[items[ingredient.name][1]],{},count+1)
                        -- for n,c in pairs(rr) do
                        --     if not recipeRaw[n] then
                        --         recipeRaw[n]=0
                        --     end
                        --     recipeRaw[n]=recipeRaw[n]+c
                        -- end
                    end
                end
            end
        end  
    end
    return recipeRaw
end

local function totalcount(recipe)
    local total=0
    for name,c in pairs(recipe)do
        total=total+c
    end
    return total

end

function raw.compil()
    local items=compil_recipe_for_item()--{["iron-gear-wheel"]={"iron-gear-wheel"},boiler={"boiler"},pipe={"pipe"},["iron-plate"]={"iron-plate"},["stone-furnace"]={"stone-furnace"}}--
    helpers.write_file("items.json",helpers.table_to_json(items))
    local item_Raw=getRawRessource()
    for name,recipes in pairs(items)do
        if name then
            for _,recipe in ipairs(recipes) do
                local rawI=getRawIngredient(items,item_Raw,data.raw.recipe[recipe],{},0,1)
                if next(rawI) then
                    if not item_Raw[name] then
                        item_Raw[name]=rawI 
                    else   
                        local old=totalcount(item_Raw[name])
                        local new=totalcount(rawI)       
                        if new<old then
                            item_Raw[name]=rawI
                        end
                    end
                end
            end
        end


    end
    return item_Raw
end

return raw