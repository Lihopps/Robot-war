local force=require("script.force")

local main={}

function main.on_init() 
    if not storage.rw_garage then storage.rw_garage={} end
end

function main.on_configuration_changed(e)
   
end

main.events={

}

return main
