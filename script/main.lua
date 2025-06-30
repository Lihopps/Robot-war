local base_builder=require("script.base-builder")
local force=require("script.force")

local main={}

function main.on_init()
    --base_builder.init()
    force.initi()
    if not storage.player_unit then
        storage.player_unit={}
    end
    if not storage.shield then
        storage.shield={}
    end
   
end

function main.on_configuration_changed(e)
   
end

main.events={

}

return main
