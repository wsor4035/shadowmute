local function on_chat_message(name, message)
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
end

table.insert(minetest.registered_on_chat_messages, 1, on_chat_message)