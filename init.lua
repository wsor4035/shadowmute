local muted = {}
minetest.register_chatcommand("shadowmute", {
    privs = {server = true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return minetest.chat_send_player(name, "player is not online/ does not exist")
        end
        muted[param] = true
        return minetest.chat_send_player(name, param .. " was shadow muted")
    end,
})

minetest.register_chatcommand("unshadowmute", {
    privs = {server = true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return minetest.chat_send_player(name, "player is not online/ does not exist")
        end
        muted[param] = nil
        return minetest.chat_send_player(name, param .. " was unshadow muted")
    end,
})

minetest.register_on_chat_message(function(name, message)
    if muted[name] then
        if minetest.global_exists("cloaking") then cloaking.chat.send(name .. ": " .. message) end
        minetest.chat_send_player(name, name .. ": " .. message)
        return true else return false end
end)