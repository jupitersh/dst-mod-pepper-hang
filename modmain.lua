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