if GetModConfigData("mode") == 1 then

    AddUserCommand("hangup", {
        prettyname = nil,
        desc = nil,
        permission = GLOBAL.COMMAND_PERMISSION.USER,
        slash = true,   
        usermenu = false,
        servermenu = false,
        params = {"status"} ,
        localfn = function(params, caller)
            if params.status == "on" then
                local center = caller:GetPosition()
                caller.hangup_task = caller:DoPeriodicTask(5, function(player)
                    local x = center.x + math.random(0,4) - 2
                    local z = center.z + math.random(0,4) - 2
                    print(x,z)
                    SendRPCToServer(RPC.LeftClick, ACTIONS.WALKTO.code, x, z)
                end, 0)
                caller.HUD.controls.networkchatqueue:DisplaySystemMessage("开始挂机模式")
            elseif params.status == "off" then
                if caller.hangup_task then
                    caller.hangup_task:Cancel()
                    caller.hangup_task = nil
                end
                caller.HUD.controls.networkchatqueue:DisplaySystemMessage("停止挂机模式")
            else
                caller.HUD.controls.networkchatqueue:DisplaySystemMessage("输入错误")
            end
        end,
    })

else

    local function AutoCheck(inst)
        local player=GLOBAL.ThePlayer
        if player then
            local invent=player.replica.inventory
            local cont=nil
            local inspect_back=false
            if GLOBAL.EQUIPSLOTS.BACK then
                cont=invent:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK)
            else
                cont=invent:GetEquippedItem(GLOBAL.EQUIPSLOTS.BODY)
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
                for i=1,GLOBAL.GetMaxItemSlots(GLOBAL.TheNet:GetServerGameMode()) do
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

end