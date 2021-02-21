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