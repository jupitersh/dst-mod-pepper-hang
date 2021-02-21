if GetModConfigData("mode") == 1 then

    local function FindClosestInst(player)
        local x,y,z = player.Transform:GetWorldPosition()
        local ents = GLOBAL.TheSim:FindEntities(x, y, z, 20, nil, {"player", "FX", "NOCLICK", "DECOR", "INLIMBO", "CLASSIFIED"}, nil)
        local closest = nil
        local closeness = nil
        for k,v in pairs(ents) do
            if closest == nil or player:GetDistanceSqToInst(v) < closeness then
                closest = v
                closeness = player:GetDistanceSqToInst(v)
            end
        end
        return closest
    end

    AddPlayerPostInit(function(player)
        player:DoPeriodicTask(8*60, function(player)
            local ent = FindClosestInst(player)
            local x,y,z = ent.Transform:GetWorldPosition()
            GLOBAL.SendRPCToServer(25, 87, x, z, ent, false, 1, nil, nil, nil, false)
        end)
    end)

else
    AddPlayerPostInit(function(player)
        if player then
            player:DoPeriodicTask(8*60, function()
                local inventory = player.replica.inventory
                for i = 1, 15 do
                    local item = inventory:GetItemInSlot(i)
                    if item then
                        inventory:InspectItemFromInvTile(item)
                    end
                    return
                end
            end)
        end
    end)
end