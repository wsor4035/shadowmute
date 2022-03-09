minetest.register_on_chat_message(function(name, message)
    local _, count = message:gsub("<@%d+>", "")
    if count and count > 3 then
        minetest.chat_send_player(
            name,
            minetest.colorize("red", "sorry, pinging more than 3 discord users is disallowed")
        )
        return true
    else
        return false
    end
end)