local modname = minetest.get_current_modname()
local timeout = minetest.settings:get(modname .. ".repeat_timeout") or 60
local cache = {}

local blocked_cmds = {
    ["/me"] = true,
    ["/msg"] = true,
    ["/pm"] = true,
    ["/m"] = true
    }
local function on_chat_message(name, message)
    if (cache[name] and cache[name]==message) then
        if message:sub(1,1) == "/" then
            local cmd = message:match("/%S+")
            if not blocked_cmds[cmd] then
                return false
            end
        end
        minetest.chat_send_player(
            name,
            minetest.colorize("red", "sorry, repeat messages are not allowed")
        )
        return true
    else
        cache[name] = message
        minetest.after(timeout, function()
                cache[name] = nil
        end)
        return false
    end
end

table.insert(minetest.registered_on_chat_messages, 1, on_chat_message)
