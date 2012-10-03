mcu_connect(handshake_speed)
function dump_response(r)
--   io.write("response: ")
--   for i,j in pairs(r) do
--      io.write(string.format(" %X ",j))
--   end
--   io.write("\n")
end

askmagicbyte="5007003601"..mcu['magic']
setbaud="C0F33F1A28" -- 57600

function magicbyte()
   -- print("Asking for magic byte");
   send_packet(askmagicbyte);
   mbyte = get_packet();
   if mbyte[0] ~= 0x8f then
      print("Heuston, problems")      
   end
end

-- TODO: We need baudrate calculation routines.
-- while now this will only work for 12M crystal

upload_speed=57600
function baudswitch()
   print("Performing baudswitch dance")
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


