local path = minetest.get_modpath(minetest.get_current_modname())
local mpath = path .. "/modules"

for _, file in pairs(minetest.get_dir_list(mpath, false)) do
    dofile(mpath .. "/" .. file)
end