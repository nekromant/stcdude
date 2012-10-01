mcudb_files = { "stc10fx.lua", "stc12x.lua" }
mcu = {}

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
}


function run_sequence(seq)
   print("Running sequence "..seq)
   if (seq ~= 'info') then
      dofile(SEQDIR..sequences[seq]..".lua")
   else
      dofile(SEQDIR..'info'..".lua")
   end
end