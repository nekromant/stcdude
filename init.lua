mcu = {}
function get_mcu_by_magic(magic)
   -- print("Looking for magic "..magic)
   for n,m in pairs(mcudb) do
      if (magic == m['magic']) then
	 mcu = m
	 return m
      end
   end
end