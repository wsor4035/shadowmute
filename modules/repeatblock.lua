local cache = {}

local command_whitelist = {
    ["/spawn"] = true,
    ["/who"] = true,
    ["/home"]=true,
    ["/help"]=true,
}

local function on_chat_message(name, message)
    if (cache[name] and cache[name]==message) then
        local command = message:split(" ")[1]
        if(minetest.registered_chatcommands[command] and command_whitelist[command]) then
            cache[name] = nil
            return false
        end
        minetest.chat_send_player(
            name,
            minetest.colorize("red", "sorry, repeat messages are not allowed")
        )
        return true
    else
        cache[name] = message
        return false
    end
end

table.insert(minetest.registered_on_chat_messages, 1, on_chat_message)