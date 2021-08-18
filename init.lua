local muted = {}
minetest.register_chatcommand("shadowmute", {
    privs = {server = true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return minetest.chat_send_player(name, "player is not online/ does not exist")
        end
        muted[param] = true
        return true, minetest.chat_send_player(name, param .. " was shadow muted")
    end,
})

minetest.register_chatcommand("unshadowmute", {
    privs = {server = true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return minetest.chat_send_player(name, "player is not online/ does not exist")
        end
        muted[param] = false
        return true, minetest.chat_send_player(name, param .. " was unshadow muted")
    end,
})

minetest.register_on_chat_message(function(name, message)
    if muted[name] then
        if minetest.global_exists("cloaking") then cloaking.chat.send(name .. "[shadowmuted]: " .. message) end
        minetest.chat_send_player(name, name .. ": " .. message)
        return true
    else
        return false
    end
end)

if minetest.registered_chatcommands["msg"] then
    local old_func = minetest.registered_chatcommands["msg"].func
    minetest.override_chatcommand("msg", {
        func = function(name, param)
            if muted[name] then
                local dest, msg = param:match("^(%S+)%s(.+)$")
                if not dest then
                    return false, "Invalid usage, see /help msg."
                end
                if not minetest.get_player_by_name(dest) then
                    return false, "The player " .. dest .. " is not online."
                end
                if name == dest then
                    minetest.chat_send_player(name, "DM from " .. name .. ": " .. msg)
                    return true, "Message sent."
                end
            else
                return old_func(name, param)
            end
        end
    })
end

if minetest.registered_chatcommands["m"] and minetest.registered_chatcommands["msg"] then
    local func = minetest.registered_chatcommands["msg"].func
    minetest.override_chatcommand("m", {
        func = function(name, param)
            return func(name, param)
        end
    })
end