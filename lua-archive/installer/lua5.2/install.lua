local t = ...
local strPlatform = t:get_platform()

if strPlatform=='windows_32' then
	t:install('windows_x86/lua_plugins/lfs.dll', '${install_lua_cpath}')

elseif strPlatform=='windows_64' then
	t:install('windows_x64/lua_plugins/lfs.dll', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1204_32' then
	t:install('ubuntu_1204_32/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1204_64' then
	t:install('ubuntu_1204_64/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1404_32' then
	t:install('ubuntu_1404_32/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1404_64' then
	t:install('ubuntu_1404_64/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1604_32' then
	t:install('ubuntu_1604_32/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1604_64' then
	t:install('ubuntu_1604_64/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1610_32' then
	t:install('ubuntu_1610_32/lua_plugins/lfs.so', '${install_lua_cpath}')

elseif strPlatform=='ubuntu_1610_64' then
	t:install('ubuntu_1610_64/lua_plugins/lfs.so', '${install_lua_cpath}')

end

return true
