name = "辣椒挂机大法"
description = [[
纯客户端模组
防止因长期没有向服务器放送数据而掉线
]]
author = "辣椒小皇纸"
version = "1.0.0"
forumthread = ""
api_version = 10

dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = false
dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

priority = -99

----------------------
-- General settings --
----------------------

configuration_options =
{
    {
        name = "mode",
        label = "防止掉线模式",
        hover = "",
        options =   {
                        {description = "定时移动", data = 1, hover = ""},
                        {description = "检测物品", data = 2, hover = "定时检测物品栏第一格的物品"},
                    },
        default = 1,
    },
}