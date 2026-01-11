local util={}

function util.distance(a,b)
    return math.sqrt((b.x-a.x)*(b.x-a.x)+(b.y-a.y)*(b.y-a.y))
end


function util.distance_inf(posa, posb,distance)
    local dx=math.abs(posa.x-posb.x)
    local dy=math.abs(posa.y-posb.y)

    if dx<=distance*2 and dy<=distance*2 then
        return true
    else
        return false
    end
end

return util