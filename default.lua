function dump_response(r)
   io.write("response: ")
   for i,j in pairs(r) do
      io.write(string.format(" %X ",j))
   end
   io.write("\n")
end

askmagicbyte="5007003601"..mcu['magic']

setbaud="C0F33F1A28" -- 57600
newbaud=57600
oldbaud=1200

print("Running a test io scenario");
send_packet(askmagicbyte);
mbyte = get_packet();
dump_response(mbyte);

send_packet("8F"..setbaud.."82");
set_baud(newbaud)
mbyte = get_packet();
dump_response(mbyte);
set_baud(oldbaud)
send_packet("8E"..setbaud);
set_baud(newbaud)
mbyte = get_packet();
dump_response(mbyte);




