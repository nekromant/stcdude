require("io");
dofile('scripts/dumper.lua')

print("Injecting Keil CDB data from file " .. arg[1] .. " into mcudb file ".. arg[2]);
dofile(arg[2]);

t = io.input(arg[1]);

state=0;
description={};
name=nil;
parms=nil;

function findpattern(text, pattern, start)
   n = string.find(text, pattern, start)
   if n ~= nil then
      return string.sub(text, n)
   end
   return nil
end

function extract_hex_size(text,field)
   for word in string.gmatch(parms, field.."%(0%-0x%x+") do 
      a = string.gsub(word, field..'%(0%-','')
      return a;
   end
end

function extract_int_size(text,field)
   for word in string.gmatch(parms, field.."%(%d+") do 
      a = string.gsub(word, field..'%(','')
      return a;
   end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
	 if type(k) ~= 'number' then k = '"'..k..'"' end
	 s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
      end
      return s .. '} \n'
   else
      return tostring(o)
   end
end

function store_scraped_info()
   print("name: " .. name);
   print("paramstr: " .. parms);
   iram = extract_hex_size(parms, 'IRAM')
   print("iram size: "..iram)
   xram = extract_hex_size(parms, 'XRAM')
   if xram ~= nil then print("xram size: "..xram) end
   irom = extract_hex_size(parms, 'IROM')
   print("iram size: "..irom)
   clock = extract_int_size(parms, "CLOCK")
   print("maximum speed: " .. clock .. " Hz")
   
   table.remove(description,#description)
   for i,j in pairs(description) do
      print("  ".. i .. "  " .. j);
   end
   
   -- Let's find a suitable location for it --
   for n,mcu in pairs(mcudb) do
      k = string.find(name,mcu['name'])
      if (nil ~= k) then
	 print("Inserting info into db entry"..mcu['name'].." ".. n)
	 mcu['iram']=iram
	 mcu['xram']=xram
	 mcu['irom']=irom
	 mcu['speed']=clock
	 dsc=""
	 if description ~= nil then
	    for u,d in pairs(description) do
	       dsc=dsc.."\t"..d.."\n";
	    end
	 end
	 mcu['descr']=dsc;
      end
   end
   -- Now let's store scraped info --
   
end

while true do
   local line = io.read()
   if line == nil then break end
   if (string.find(line, "Series") ~= nil) then
      if name ~= nil then
	 store_scraped_info();
      end
      series = line 
      description = {};
      name = io.read() -- next line is the name
      -- io.write( 'Reading new series:'.. line .. "\n");   
      repeat
	 line = io.read();
	 table.insert(description,line)
      until (string.find(line,"CPU") ~= nil)
      
   end
   if (string.find(line, "IRAM") ~= nil) then
      parms = line
   end
   
end

local file = io.open("out.lua", "w")
file:write(DataDumper(mcudb,"mcudb", false, 1))