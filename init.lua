function get_mcu_by_magic(magic)
   -- print("Looking for magic "..magic)
   for n,mcu in pairs(mcudb) do
      if (magic == mcu['magic']) then
--	 print("Found ".. mcu['name'].." in database");
	 return mcu
      end
   end
end