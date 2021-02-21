if GetModConfigData("mode") == 1 then

    AddPlayerPostInit(function(player)
        local worldid = GLOBAL.TheWorld.net._worldid and GLOBAL.TheWorld.net._worldid:value() or ""
        if worldid == "10" then
            local player_pt = player:GetPosition()
            local nightlight_inst = FindClosestInst(player_pt.x, player_pt.y, player_pt.z, "nightlight")
            local nightlight_pt = nightlight_inst:GetPosition()
            if not (math.abs(player_pt.x - nightlight_pt.x) < 20 and math.abs(player_pt.z - nightlight_pt.z) < 20) then
                player.hangup_task = player:DoPeriodicTask(GetModConfigData("frequency"), function(player)
                    local x = player_pt.x + math.random(0,4) - 2
                    local z = player_pt.z + math.random(0,4) - 2
                    SendRPCToServer(GLOBAL.RPC.LeftClick, GLOBAL.ACTIONS.WALKTO.code, x, z)
                end, 0)
            end
        end
    end)

else

    AddPlayerPostInit(function(player)
        if player then
            player:DoPeriodicTask(8*60, function()
                local inventory = player.replica.inventory
                local item = inventory:GetItemInSlot(1)
                if item then
                    inventory:InspectItemFromInvTile(item)
                end
            end)
        end
    end)

end