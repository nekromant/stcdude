mcu = {}
function get_mcu_by_magic(magic)
   -- print("Looking for magic "..magic)
   for n,m in pairs(mcudb) do
      if (magic == m['magic']) then
--	 print("Found ".. mcu['name'].." in database");
	 -- We also set mcu as global
	 mcu = m
	 return m
      end
   end
end