local extensions = {
    ".jpg", ".jpeg", ".JPG", ".JPEG",
    ".png", ".PNG", ".gif", ".gifv",
    ".webm", ".mp4", ".wav", ".mp3",
    ".mp4", ".ogg", ".flac", ".mov",
}

minetest.register_on_chat_message(function(name, message)
    if message:find("http") then
        for _, ext in pairs(extensions) do
            if message:find(ext) then
                minetest.chat_send_player(
                    name,
                    minetest.colorize("red", "sorry, sharing images on this server is disallowed")
                )
                return true
            end
        end
        return false
    else
        return false
    end
end)