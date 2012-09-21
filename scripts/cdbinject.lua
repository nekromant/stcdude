require("io");

print("Injecting Keil CDB data from file " .. arg[1] .. " into mcudb file ".. arg[2]);
dofile(arg[2]);

t = io.input(arg[1]);

state=0;
description={};
name="";
parms="";

function store_scraped_info()
   print("name: " .. name);
   print("parms: " .. parms);
   table.remove(description,#description)
   for i,j in pairs(description) do
      print("  ".. i .. "  " .. j);
   end
   -- Now let's store scraped info --
   
end

while true do
   local line = io.read()
   if line == nil then break end
   if (string.find(line, "Series") ~= nil) then
      store_scraped_info();
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