local _G = GLOBAL

local function AutoCheck(inst)
    local player=_G.ThePlayer
    if player then
        local invent=player.replica.inventory
        local cont=nil
        local inspect_back=false
        if _G.EQUIPSLOTS.BACK then
            cont=invent:GetEquippedItem(_G.EQUIPSLOTS.BACK)
        else
            cont=invent:GetEquippedItem(_G.EQUIPSLOTS.BODY)
        end
        if cont~=nil and cont.replica.container then
            local container=cont.replica.container
            for i=1,container:GetNumSlots() do
                local Item=container:GetItemInSlot(i)
                if Item then
                    invent:InspectItemFromInvTile(Item)
                    inspect_back=true
                end
            end
        end
        if inspect_back==false then
            for i=1,_G.GetMaxItemSlots(_G.TheNet:GetServerGameMode()) do
                local Item2=invent:GetItemInSlot(i)
                if Item2 then
                    invent:InspectItemFromInvTile(Item2)
                end
            end
        end
    end
end

AddPlayerPostInit(function(inst)
    inst:DoPeriodicTask(480, AutoCheck)
end)