local cache = {}

local function on_chat_message(name, message)
    if (cache[name] and cache[name]==message) then
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