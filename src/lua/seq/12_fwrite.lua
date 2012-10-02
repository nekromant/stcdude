mcu_connect(handshake_speed)
function dump_response(r)
   io.write("response: ")
   for i,j in pairs(r) do
      io.write(string.format(" %X ",j))
   end
   io.write("\n")
end

askmagicbyte="5007003601"..mcu['magic']


function magicbyte()
   -- print("Asking for magic byte");
   send_packet(askmagicbyte);
   mbyte = get_packet();
   if mbyte[0] ~= 0x8f then
      print("Heuston, problems")      
   end
end


-- upload_speed=57600
-- PCON register values for smod 0 and 1
smod = { { 2, "C0"}, {1, "40"} }

function getbauderror(crystal, k, baud, alpha)
   bd = k/32*crystal/(256-alpha)
   d = math.abs(bd - baud)
   p = d*100/baud
   return d, p
end

-- This function returns a suitable smod, brt and errb, errp
function getbaudsettings(baud,crystal)
   --bd = k/32*crystal/(256-alpha);
   --baud*256 - baud*alpha = k/32*crystal
   for k,v in pairs(smod) do
      alpha = (baud*256 - v[1]/32*crystal)/baud
      if (alpha <=0xff) then
	 alpha = math.floor(alpha)
	 eb,ep = getbauderror(crystal, v[1], baud, alpha)
	 alpha = string.format("%02X", alpha)
	 return { v[2], alpha, eb, ep}
      end
   end
end


--setbaud="C0F3 3F1A 28" -- 57600


baudrates = { 115200, 57600, 38400, 28800, 19200, 9600, 4800, 2400, 1200, 300 }

function baudswitch()
   crystal = mcu_clock*1000000
   settings = getbaudsettings(upload_speed,crystal);
   print("WARNING: Baudrate dance is heavy experimental, sometimes fails");
   print("WARNING: If it doesn't work - try a lower baudrate manually");
   if (settings[4] >= 5) then
      print(upload_speed.." will result in "..settings[4].."% error")
      for n,b in pairs(baudrates) do
	 if (b < upload_speed) then
	    print("Picking "..b.." instead")
	    upload_speed = b
	    return baudswitch()
	 end
      end
      return
   end
--   print("Performing switch to "..upload_speed.." ("..settings[4].."% error)")
   setbaud = settings[1]..settings[2].."3F1628"
   print("payload: "..setbaud)
   send_packet("8F"..setbaud.."82");
   set_baud(upload_speed)
   mbyte = get_packet();
   dump_response(mbyte);
   set_baud(handshake_speed)
   send_packet("8E"..setbaud);
   set_baud(upload_speed)
   mbyte = get_packet();
   dump_response(mbyte);
end

function erase_flash()
   print("Erasing mcu flash...")
   erasehdr = "84FF00000000F000000000000000000000000080"
   for i = 0x7f,0xe,-1 do
      erasehdr = erasehdr..string.format("%02X",i)
   end
   send_packet(erasehdr)
   response = get_packet()
   dump_response(response)
end


magicbyte()
baudswitch()
erase_flash()
send_file(filename, 128)

--
--baudswitch()
--



