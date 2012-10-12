
mcudb_files= { 
"1.lua", 
"10.lua", 
"11.lua", 
"12.lua", 
"13.lua", 
"2.lua", 
"3.lua", 
"4.lua", 
"5.lua", 
"6.lua", 
"7.lua", 
"8.lua", 
"9.lua", 
}


function get_mcu_by_magic(magic)
   -- print("Looking for magic "..magic)
   for j,file in pairs(mcudb_files) do
      print("Trying mcudb "..file)
      dofile(MCUDBDIR..file)
      for n,m in pairs(mcudb) do
	 if (magic == m['magic']) then
	    -- We also set mcu as global
	    mcu = m
	    return m
	 end
      end
   end
end



-- Script filenames that implement default supported sequences  
-- Sequences are: 'rflash'; 'wflash'; 'ropts'; 'wopts'; 'reeprom'; 'weeprom'
-- mcudb files should override these defaults, where necessary 

sequences = {
   wflash = "12_fwrite",
   dtest = "dtest",
}


function run_sequence(seq)
   print("Running sequence "..seq)
   if (seq ~= 'info') then
      dofile(SEQDIR..sequences[seq]..".lua")
   else
      dofile(SEQDIR..'info'..".lua")
   end
end