require 'socket'
require 'mqtt'

MQTT::Client.connect('localhost') do |c|
 
   c.subscribe('denon-control')
   c.get do |topic,message|
   	puts "#{topic}: #{message}"
	s = TCPSocket.new '192.168.1.72', 23
   
	if message=="unmute"
		s.send("MUOFF\r",0)
	end

	if message=="mute"
		s.send("MUON\r",0)
	end

	if message=="on"
		s.send("PWON\r",0)
	end

	if message=="off"
		s.send("PWSTANDBY\r",0)
	end

	if message.start_with?("volume")
		volume = message.split(' ')[1]
		s.send("MV#{volume}\r",0)
	end

	
	s.close

   end
end


